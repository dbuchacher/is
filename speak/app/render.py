"""
speak/app/render.py — render substrate decomposition.

render_terminal(data) → ANSI-colored string for stdout
render_html(data) → HTML string for static-site pages

Both consume the same dict from lib.lookup(word).
"""
import textwrap
from lib import load_graph, curated_words

# ---- ANSI colors ----
R = "\033[0m"      # reset
B = "\033[1m"      # bold
D = "\033[2m"      # dim
C = "\033[36m"     # cyan — PIE forms
Y = "\033[33m"     # yellow — the claim
G = "\033[32m"     # green — cross-lang match
U = "\033[4m"      # underline


def _wrap(text, width=64, indent="  "):
    return textwrap.fill(text, width=width, initial_indent=indent,
                         subsequent_indent=indent)


def _underline_morpheme(morphemes, stress_form):
    """Build ' · '-joined morpheme line + a caret line underneath the stress."""
    parts = [m["form"] for m in morphemes]
    sep = " · "
    joined = sep.join(parts)
    # Find where stress starts in joined string.
    carets = [" "] * len(joined)
    pos = 0
    for i, form in enumerate(parts):
        if form == stress_form:
            for k in range(len(form)):
                if pos + k < len(carets):
                    carets[pos + k] = "^"
            break
        pos += len(form) + len(sep)
    # keep trailing spaces for position tracking, strip only in caller
    return joined, "".join(carets)


def _render_branches(primary_pie, branches):
    """If branches is {name: [words]}, format them as pedagogical prose."""
    if not branches or len(branches) < 2:
        return []
    lines = ["  ONE verb in PIE. English split it into branches:"]
    for name, words in branches.items():
        # show up to 6 descendants per branch
        sample = ", ".join(words[:6])
        lines.append(f"    {B}{name}:{R}  {sample}")
    return lines


def _render_coord(coord):
    """Format the cross-language evidence table."""
    if not coord:
        return []
    lines = ["  Evidence — unrelated languages name it:"]
    label_width = 10

    def row(lang_label, entry):
        if entry is None:
            return f"    {lang_label:{label_width}}(not yet indexed)"
        ids = entry.get("ids") or ([entry["id"]] if entry.get("id") else [])
        ids_str = " · ".join(ids) if ids else "(—)"
        gloss = entry.get("gloss", "")
        return f"    {lang_label:{label_width}}{C}{ids_str}{R}" + \
               (f"    {D}({gloss}){R}" if gloss else "")

    lines.append(row("PIE",      coord.get("pie")))
    lines.append(row("Egyptian", coord.get("egyptian")))
    lines.append(row("Chinese",  coord.get("chinese")))
    lines.append(row("Sumerian", coord.get("sumerian")))
    return lines


def _try_next(data):
    """Return 3 suggestions — graph-neighbor words from branches."""
    primary = data["entry"]["primary_pie"]
    # Try: other curated words that share the same primary_pie
    from lib import load_app_data
    app = load_app_data()
    word = data["word"]
    siblings = [w for w, e in app["en-pie"].items()
                if e["primary_pie"] == primary and w != word]
    if len(siblings) >= 3:
        return siblings[:3]
    # Fall back: curated words not yet shown
    extra = [w for w in curated_words() if w != word and w not in siblings]
    return (siblings + extra)[:3]


def render_terminal(data):
    if data is None:
        return render_no_match_terminal()

    word = data["word"]
    entry = data["entry"]
    atomic = data.get("atomic")
    branches = data.get("branches") or {}
    coord = data.get("coord")

    lines = []

    # ---- header: morpheme split + stress underline + PIE form ----
    joined, carets = _underline_morpheme(entry["morphemes"],
                                         entry.get("stress_morpheme", ""))
    prefix = f"{B}{word}{R}  =  "
    visual_prefix_len = len(word) + len("  =  ")
    lines.append(prefix + joined)

    # find stress position within joined string (for aligning PIE form)
    stress_pos = 0
    stress_form = entry.get("stress_morpheme", "")
    if carets:
        # leading spaces in carets = offset
        stress_pos = len(carets) - len(carets.lstrip())
        lines.append(" " * visual_prefix_len + carets)
    if atomic and atomic.get("anchor"):
        form = atomic["anchor"]["form"]
        gloss = atomic.get("gloss", "")
        align = " " * (visual_prefix_len + stress_pos)
        lines.append(align + f"{C}{form}{R}  {D}\"{gloss}\"{R}")
    lines.append("")

    # ---- branches (if polysemic) ----
    branch_lines = _render_branches(entry["primary_pie"], branches)
    if branch_lines:
        lines.extend(branch_lines)
        lines.append("")

    # ---- the claim ----
    claim = entry.get("claim", "").strip()
    if claim:
        lines.append(f"  {Y}The claim:{R}")
        lines.append(_wrap(claim, width=64, indent="  "))
        lines.append("")

    # ---- cross-language evidence ----
    if coord:
        lines.extend(_render_coord(coord))
        lines.append("")
        if coord.get("claim"):
            lines.append(_wrap(coord["claim"], width=64, indent="  "))
            lines.append("")

    # ---- try next ----
    tn = _try_next(data)
    if tn:
        next_cmds = "  ".join(f"speak {w}" for w in tn)
        lines.append(f"  {D}try:  {next_cmds}{R}")

    return "\n".join(lines)


def render_no_match_terminal(word=None):
    msg = [f"  {D}'{word}' not in curated set.{R}"] if word else [
        f"  {D}not in curated set.{R}"]
    msg.append(f"  {D}curated ({len(curated_words())} words):{R}")
    msg.append("  " + ", ".join(curated_words()))
    return "\n".join(msg)


def render_first_run_terminal():
    return f"""
  {B}speak{R} — substrate decomposition of English words.

  One universe. Many languages are vocabularies for it.
  When PIE, Egyptian, and Chinese name the same operation
  with different morphemes, they're naming ONE thing, not
  three similar things.

  {D}try:{R}   speak cognition
         speak year
         speak king

  {D}all:{R}   {", ".join(curated_words())}
"""


# ---- HTML rendering (for static-site mode) ----

HTML_TEMPLATE = """<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>speak — {word}</title>
<style>
  body {{ font-family: -apple-system, system-ui, sans-serif;
          max-width: 42em; margin: 2em auto; padding: 0 1em;
          line-height: 1.5; color: #222; background: #fafaf7; }}
  .word {{ font-size: 2em; font-weight: bold; }}
  .morphemes {{ font-family: ui-monospace, monospace;
                 font-size: 1.2em; color: #555; margin-top: 0.5em; }}
  .stress {{ text-decoration: underline;
              text-decoration-color: #c53030;
              text-decoration-thickness: 3px; color: #222; }}
  .pie-form {{ color: #2c5282; font-family: ui-monospace, monospace;
               margin-top: 0.5em; }}
  .pie-gloss {{ color: #666; font-style: italic; }}
  .section {{ margin-top: 1.5em; }}
  .branch-label {{ font-weight: bold; margin-right: 0.3em; }}
  .claim {{ border-left: 3px solid #c53030; padding: 0.5em 1em;
             background: #fff5f5; }}
  table {{ margin-top: 0.5em; border-collapse: collapse; }}
  td {{ padding: 0.2em 1em 0.2em 0; vertical-align: top; }}
  .lang {{ color: #666; font-weight: bold; }}
  .ids {{ font-family: ui-monospace, monospace; color: #2c5282; }}
  .gloss {{ color: #666; font-style: italic; }}
  .synthesis {{ margin-top: 1em; color: #444; font-style: italic; }}
  .try-next {{ margin-top: 2em; color: #666; font-size: 0.9em; }}
  .try-next a {{ color: #2c5282; font-family: ui-monospace, monospace;
                  margin-right: 1em; }}
  .no-parallel {{ color: #999; }}
  footer {{ margin-top: 4em; color: #999; font-size: 0.85em;
             border-top: 1px solid #eee; padding-top: 1em; }}
  a {{ color: #2c5282; }}
</style>
</head>
<body>
{body}
<footer>
<p>one universe, many vocabularies. <a href="index.html">speak</a> shows
the substrate decomposition behind an English word.</p>
</footer>
</body>
</html>
"""


def _html_morphemes(morphemes, stress):
    parts = []
    for m in morphemes:
        form = m["form"]
        if form == stress:
            parts.append(f'<span class="stress">{form}</span>')
        else:
            parts.append(form)
    return " · ".join(parts)


def render_html(data):
    if data is None:
        return "<p>not curated</p>"

    word = data["word"]
    entry = data["entry"]
    atomic = data.get("atomic") or {}
    branches = data.get("branches") or {}
    coord = data.get("coord")

    out = []
    out.append(f'<div class="word">{word}</div>')
    out.append(f'<div class="morphemes">= '
               f'{_html_morphemes(entry["morphemes"], entry.get("stress_morpheme"))}'
               f'</div>')

    anchor = atomic.get("anchor") or {}
    if anchor:
        out.append(f'<div class="pie-form">PIE {anchor.get("form", "")}'
                   f' <span class="pie-gloss">'
                   f'"{atomic.get("gloss", "")}"</span></div>')

    if branches and len(branches) >= 2:
        out.append('<div class="section"><b>ONE verb in PIE. '
                   'English split it into branches:</b><ul>')
        for name, words in branches.items():
            out.append(f'<li><span class="branch-label">{name}:</span>'
                       f'{", ".join(words[:6])}</li>')
        out.append('</ul></div>')

    claim = entry.get("claim", "").strip()
    if claim:
        out.append(f'<div class="section claim"><b>The claim:</b> {claim}</div>')

    if coord:
        out.append('<div class="section"><b>Evidence — unrelated languages name it:</b>')
        out.append('<table>')
        for lang_key, lang_label in [("pie", "PIE"), ("egyptian", "Egyptian"),
                                      ("chinese", "Chinese"), ("sumerian", "Sumerian")]:
            entry = coord.get(lang_key)
            if entry is None:
                out.append(f'<tr><td class="lang">{lang_label}</td>'
                           f'<td class="no-parallel">(not yet indexed)</td></tr>')
            else:
                ids = entry.get("ids") or ([entry["id"]] if entry.get("id") else [])
                out.append(f'<tr><td class="lang">{lang_label}</td>'
                           f'<td class="ids">{" · ".join(ids)}</td>'
                           f'<td class="gloss">{entry.get("gloss", "")}</td></tr>')
        out.append('</table>')
        if coord.get("claim"):
            out.append(f'<p class="synthesis">{coord["claim"]}</p>')
        out.append('</div>')

    tn = _try_next(data)
    if tn:
        out.append('<div class="try-next">try: ' +
                   " ".join(f'<a href="{w}.html">{w}</a>' for w in tn) +
                   '</div>')

    return HTML_TEMPLATE.format(word=word, body="\n".join(out))


def render_html_index():
    body = ['<h1>speak</h1>',
            '<p>substrate decomposition of English words. '
            'one universe, many vocabularies.</p>',
            '<ul>']
    for w in curated_words():
        body.append(f'<li><a href="{w}.html">{w}</a></li>')
    body.append('</ul>')
    return HTML_TEMPLATE.format(word="index", body="\n".join(body))


if __name__ == "__main__":
    # smoke test
    import sys
    from lib import lookup
    word = sys.argv[1] if len(sys.argv) > 1 else "cognition"
    data = lookup(word)
    print(render_terminal(data))
