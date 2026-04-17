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
        coord_name = coord.get("name", "")
        if coord_name:
            lines.append(f"  {D}→ see coord: {coord_name} — full "
                         f"argument across all witnesses{R}")
        lines.append("")

    # ---- try next ----
    tn = _try_next(data)
    if tn:
        next_cmds = "  ".join(f"speak {w}" for w in tn)
        lines.append(f"  {D}try:  {next_cmds}{R}")

    return "\n".join(lines)


def render_redirect_terminal(rd):
    """Structured one-card redirect for an English descendant not
    directly curated. No forged claim prose — just parentage + pointer.
    """
    word = rd["word"]
    pie = rd["parent_pie"]
    branch = rd["branch_name"]
    hero = rd["parent_hero"]

    lines = [f"{B}{word}{R}"]
    if hero:
        lines.append(
            f"  {D}descends from PIE{R} {C}{pie}{R} "
            f"{D}via the{R} {B}{branch}{R} "
            f"{D}branch — see the curated parent:{R} {B}{hero}{R}"
        )
        lines.append("")
        lines.append(f"  {D}try:  speak {hero}{R}")
    else:
        lines.append(
            f"  {D}descends from PIE{R} {C}{pie}{R} "
            f"{D}via the{R} {B}{branch}{R} "
            f"{D}branch — no curated hero word for this root yet.{R}"
        )
    return "\n".join(lines)


def render_redirect_html(rd):
    """HTML redirect card — one short page, no meta-refresh. Honest
    structural output per BUILD-SPEC: parent + branch + pointer,
    no forged claim prose."""
    word = rd["word"]
    pie = rd["parent_pie"]
    branch = rd["branch_name"]
    hero = rd["parent_hero"]

    out = [f'<div class="word">{word}</div>']
    out.append('<div style="color:#666;font-size:0.9em;'
               'margin-top:0.3em;">English descendant — '
               'redirect to curated parent</div>')

    if hero:
        out.append(
            f'<div class="section">'
            f'<b>{word}</b> descends from PIE '
            f'<span class="ids">{pie}</span> via the '
            f'<b>{branch}</b> branch.</div>'
        )
        out.append(
            f'<div class="section">See the curated entry for the '
            f'parent root:<br>'
            f'<a href="{hero}.html" '
            f'style="font-size:1.2em;">→ speak {hero}</a></div>'
        )
    else:
        out.append(
            f'<div class="section">'
            f'<b>{word}</b> descends from PIE '
            f'<span class="ids">{pie}</span> via the '
            f'<b>{branch}</b> branch. No curated hero word for '
            f'this root yet.</div>'
        )

    out.append('<div class="section" style="margin-top:2em;'
               'font-size:0.9em;">'
               '<a href="index.html">← all words</a></div>')

    return HTML_TEMPLATE.format(word=word, body="\n".join(out))


def render_cross_lang_terminal(xl):
    """Render output for a cross-language morpheme match.

    xl = {lang, morpheme_id, coord_name, coord_data, atomic}
    """
    lang = xl["lang"]
    mid = xl["morpheme_id"]
    name = xl["coord_name"]
    coord = xl["coord_data"]
    atomic = xl.get("atomic") or {}

    lines = []
    prefix = f"{B}{mid}{R}  "
    lines.append(f"{prefix}{D}({lang} morpheme){R}")

    anchor = atomic.get("anchor") or {}
    gloss = atomic.get("gloss", "")
    if anchor and gloss:
        form = anchor.get("form", "")
        lines.append(f"  {C}{form}{R}  {D}\"{gloss}\"{R}")
    elif gloss:
        lines.append(f"  {D}\"{gloss}\"{R}")
    lines.append("")

    lines.append(f"  {Y}This morpheme sits at coord:{R} {B}{name}{R}")
    lines.append(f"  {D}(a coord = one shared identity named by "
                 f"multiple unrelated languages){R}")
    lines.append("")

    claim = coord.get("claim", "").strip()
    if claim:
        lines.append(_wrap(claim, width=64, indent="  "))
    lines.append("")

    lines.append("  Other vocabularies naming the same coord:")
    label_width = 10
    for lang_key, lang_label in [("pie", "PIE"), ("egyptian", "Egyptian"),
                                  ("chinese", "Chinese"),
                                  ("sumerian", "Sumerian")]:
        if lang_key == lang:
            continue  # skip self
        entry = coord.get(lang_key)
        if entry is None:
            lines.append(
                f"    {lang_label:{label_width}}"
                f"{D}(no atomic file indexed){R}"
            )
        else:
            ids = entry.get("ids") or (
                [entry["id"]] if entry.get("id") else []
            )
            ids_str = " · ".join(ids) if ids else "(—)"
            g = entry.get("gloss", "")
            lines.append(
                f"    {lang_label:{label_width}}{C}{ids_str}{R}"
                + (f"    {D}({g}){R}" if g else "")
            )
    lines.append("")

    # English descendants at this coord
    desc = _coord_descendants(coord, None)
    if desc:
        try_cmds = "  ".join(f"speak {w}" for w in desc[:4])
        lines.append(f"  English words here:  "
                     f"{', '.join(desc[:6])}"
                     f"{'...' if len(desc) > 6 else ''}")
        lines.append(f"  {D}try:  {try_cmds}{R}")

    return "\n".join(lines)


def render_no_match_terminal(word=None, near=None):
    msg = [f"  {D}'{word}' not in curated set.{R}"] if word else [
        f"  {D}not in curated set.{R}"]
    if near:
        try_cmds = "  ".join(f"speak {w}" for w in near)
        msg.append("")
        msg.append(f"  {Y}nearest curated:{R}  "
                   + ", ".join(near))
        msg.append(f"  {D}try:  {try_cmds}{R}")
    else:
        msg.append("")
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
        coord_name = coord.get("name", "")
        out.append('<div class="section"><b>Same identity in unrelated '
                   'languages:</b>')
        out.append('<table>')
        for lang_key, lang_label in [("pie", "PIE"), ("egyptian", "Egyptian"),
                                      ("chinese", "Chinese"), ("sumerian", "Sumerian")]:
            entry = coord.get(lang_key)
            if entry is None:
                out.append(f'<tr><td class="lang">{lang_label}</td>'
                           f'<td class="no-parallel">(not yet indexed)</td></tr>')
            else:
                ids = entry.get("ids") or ([entry["id"]] if entry.get("id") else [])
                ids_html = _ids_html(lang_key, ids, href_prefix="atomic/")
                out.append(f'<tr><td class="lang">{lang_label}</td>'
                           f'<td class="ids">{ids_html}</td>'
                           f'<td class="gloss">{entry.get("gloss", "")}</td></tr>')
        out.append('</table>')
        # Coord-unity claim is NOT repeated here; it lives on the
        # coord page. Word pages keep the per-word claim above.
        if coord_name:
            out.append(f'<p style="margin-top:0.5em;font-size:0.9em;">'
                       f'→ <a href="coord/{coord_name}.html">see '
                       f'coord: {coord_name}</a> '
                       f'<span style="color:#888;">— full argument, '
                       f'all witnesses, all English descendants</span>'
                       f'</p>')
        out.append('</div>')

    tn = _try_next(data)
    if tn:
        out.append('<div class="try-next">try: ' +
                   " ".join(f'<a href="{w}.html">{w}</a>' for w in tn) +
                   '</div>')

    return HTML_TEMPLATE.format(word=word, body="\n".join(out))


INDEX_SEARCH_BLOCK = """
<form id="speak-search" method="get" action="."
      style="margin-top:1.5em;margin-bottom:1em;">
  <input id="speak-word" name="w" list="speak-words" autofocus
         placeholder="type a word — e.g. cognition, year, king, xin, sDm"
         autocomplete="off"
         style="font-size:1.1em;padding:0.4em 0.6em;width:100%;
                max-width:24em;border:1px solid #ccc;
                border-radius:4px;font-family:ui-monospace,monospace;">
  <datalist id="speak-words">
{options}
  </datalist>
</form>
<script>
(function() {{
  var params = new URLSearchParams(window.location.search);
  var w = (params.get('w') || '').trim();
  var curated = {curated_js};
  var xlang = {xlang_js};  // {{morpheme: coord-name}} (case-preserving)
  function go(word) {{
    var lower = word.toLowerCase();
    if (curated.indexOf(lower) !== -1) {{
      window.location.href = lower + '.html';
      return;
    }}
    // cross-language morpheme match — preserve the case the user typed,
    // fall back to case-insensitive on the keys
    if (xlang[word]) {{
      window.location.href = 'coord/' + xlang[word] + '.html';
      return;
    }}
    for (var k in xlang) {{
      if (k.toLowerCase() === lower) {{
        window.location.href = 'coord/' + xlang[k] + '.html';
        return;
      }}
    }}
  }}
  if (w) go(w);
  var form = document.getElementById('speak-search');
  var input = document.getElementById('speak-word');
  form.addEventListener('submit', function(e) {{
    e.preventDefault();
    go((input.value || '').trim());
  }});
  input.addEventListener('change', function() {{
    go((input.value || '').trim());
  }});
}})();
</script>
"""


def _has_atomic_page(lang, morpheme_id):
    """Does an atomic HTML page exist for this morpheme?

    True when (a) the morpheme resolves to an atomic .md in its
    graph AND (b) it participates in coord-unity (we only build
    atomic pages for coord-tagged morphemes, per iter-12 scope).
    """
    from lib import load_graph, coord_tag_for_morpheme
    graph = load_graph(lang)
    if morpheme_id not in graph:
        return False
    return coord_tag_for_morpheme(lang, morpheme_id) is not None


def _ids_html(lang, ids, href_prefix="atomic/"):
    """Render a list of morpheme IDs as ` · `-joined HTML, linking
    each one to its atomic page when one was built.

    href_prefix: path prefix from the current page. On a word page
    (docs/<word>.html) → "atomic/"; on a coord page
    (docs/coord/<name>.html) → "../atomic/".
    """
    parts = []
    for mid in ids:
        if _has_atomic_page(lang, mid):
            parts.append(f'<a href="{href_prefix}{lang}/{mid}.html">{mid}</a>')
        else:
            parts.append(mid)
    return " · ".join(parts)


def _coord_descendants(coord_data, pie_graph):
    """Find en-pie.json entries whose primary_pie ID matches one of the
    PIE IDs referenced by this coord. Returns sorted word list."""
    from lib import load_app_data
    pie = coord_data.get("pie")
    if not pie:
        return []
    pie_ids = set()
    if isinstance(pie, dict):
        if pie.get("id"):
            pie_ids.add(pie["id"])
        pie_ids.update(pie.get("ids") or [])
    if not pie_ids:
        return []
    app = load_app_data()
    return sorted(
        w for w, e in app["en-pie"].items()
        if e.get("primary_pie") in pie_ids
    )


def _coord_clean_hit_count(coord_data):
    """Number of non-null language slots (the 3/4 or 4/4 count)."""
    return sum(
        1 for k in ("pie", "sumerian", "egyptian", "chinese")
        if coord_data.get(k)
    )


COORD_DEFINITION = (
    'A <b>coord</b> is one shared identity — a slot where multiple '
    'unrelated languages have independently named the same operation '
    'or thing with their own unrelated morphemes. When 3 or 4 '
    'language families land on the same slot, that\'s the claim '
    'made literal: one universe, many vocabularies.'
)


def render_coord_page(coord_name, coord_data):
    """Render a per-coord argument page.

    Coord page = the argument surface. One coord, up to 4 vocabularies
    naming it, the shared claim once, English descendants listed, link
    back to index. The scale dimension of v2 lives here.

    Layout per cold-reader feedback: definition first (define "coord"
    before using it), evidence table next (data leads the argument),
    shared claim follows the evidence, descendants close.
    """
    hit = _coord_clean_hit_count(coord_data)
    descendants = _coord_descendants(coord_data, None)
    claim = coord_data.get("claim", "")

    out = [f'<div class="word">{coord_name}</div>']
    out.append(f'<div style="color:#666;font-size:0.9em;margin-top:0.3em;">'
               f'one shared identity — {hit} of 4 unrelated languages '
               f'name this coord</div>')

    # Coord definition — surfaces the term that cold readers flagged
    # as undefined jargon.
    out.append(f'<div class="section" style="font-size:0.95em;color:#555;">'
               f'{COORD_DEFINITION}</div>')

    # Evidence table FIRST — let data lead. Morphemes link to their
    # atomic pages so the matching rule is clickable, not asserted.
    out.append('<div class="section"><b>Same identity in four '
               'unrelated languages:</b>')
    out.append('<div style="color:#666;font-size:0.85em;">'
               '(click any morpheme to see its own page — definition, '
               'groups, cross-references)</div>')
    out.append('<table>')
    for lang_key, lang_label in [("pie", "PIE"), ("egyptian", "Egyptian"),
                                  ("chinese", "Chinese"),
                                  ("sumerian", "Sumerian")]:
        entry = coord_data.get(lang_key)
        if entry is None:
            out.append(f'<tr><td class="lang">{lang_label}</td>'
                       f'<td class="no-parallel">(no atomic file indexed)</td></tr>')
        else:
            ids = entry.get("ids") or (
                [entry["id"]] if entry.get("id") else []
            )
            ids_html = _ids_html(lang_key, ids, href_prefix="../atomic/")
            out.append(
                f'<tr><td class="lang">{lang_label}</td>'
                f'<td class="ids">{ids_html}</td>'
                f'<td class="gloss">{entry.get("gloss", "")}</td></tr>'
            )
    out.append('</table>')
    out.append('</div>')

    # Claim AFTER evidence — framed as the read of the data.
    if claim:
        out.append(f'<div class="section claim"><b>What this means:</b> '
                   f'{claim}</div>')

    if descendants:
        links = " ".join(
            f'<a href="../{w}.html">{w}</a>' for w in descendants
        )
        out.append(f'<div class="section"><b>English words at this coord:'
                   f'</b><div class="try-next" style="margin-top:0.3em">'
                   f'{links}</div></div>')
    else:
        out.append('<div class="section" style="color:#888;font-size:0.9em;">'
                   'no curated English words live at this coord yet — '
                   'the cross-language identity above still holds '
                   'independently of English.</div>')

    out.append('<div class="section" style="margin-top:2em;font-size:0.9em;">'
               '<a href="../index.html">← all words</a> · '
               '<a href="index.html">all coords</a></div>')

    return HTML_TEMPLATE.format(word=coord_name, body="\n".join(out))


def render_atomic_page(lang, atomic):
    """Render one morpheme's atomic file as a standalone HTML page.

    This closes cold-reader D's round-2 catch: the coord evidence
    table now LINKS each morpheme to its own page, so a skeptic can
    click through and see the walk (sjA → perception; Hw → speech;
    xpr → becoming) that the coord page summarizes. The matching
    rule is no longer asserted — it's clickable.
    """
    aid = atomic.get("id") or "?"
    anchor = atomic.get("anchor") or {}
    gloss = atomic.get("gloss", "")
    desc = atomic.get("descendants", "")
    definition = atomic.get("definition", "")
    groups = atomic.get("groups") or []

    out = [f'<div class="word">{aid}</div>']
    out.append(f'<div style="color:#666;font-size:0.9em;'
               f'margin-top:0.3em;">{lang} morpheme — atomic file</div>')

    if anchor and anchor.get("form"):
        out.append(f'<div class="pie-form" style="margin-top:1em;">'
                   f'{anchor["lang"]} '
                   f'<span class="ids">{anchor["form"]}</span> '
                   f'<span class="pie-gloss">"{gloss}"</span></div>')

    if desc:
        out.append(f'<div class="section" style="font-size:0.95em;">'
                   f'<b>Descendants:</b> {desc}</div>')

    if definition:
        # Convert [id](id.md) cross-references into links to sibling
        # atomic pages IN THE SAME LANG — only when the sibling has
        # a built page (is coord-tagged). Otherwise keep as plain
        # text, which prevents 404s and keeps the reader honest
        # about which morphemes have been surfaced.
        import re
        def linkify(match):
            label = match.group(1)
            target = match.group(2)
            if label != target:
                return match.group(0)
            if _has_atomic_page(lang, target):
                return f'<a href="{target}.html">{target}</a>'
            # Not built — keep plain + mark as cross-ref
            return f'<span style="color:#888;">{target}</span>'
        def_linked = re.sub(
            r"\[([a-zA-Z0-9_-]+)\]\(([a-zA-Z0-9_-]+)\.md\)",
            linkify,
            definition,
        )
        # preserve paragraph breaks as <br><br>
        def_html = def_linked.replace("\n\n", "<br><br>").replace("\n", " ")
        out.append(f'<div class="section"><b>Definition</b><br>'
                   f'{def_html}</div>')

    if groups:
        out.append('<div class="section"><b>Groups this morpheme '
                   'belongs to:</b><ul>')
        for g in groups:
            gid = g.get("id", "")
            reason = g.get("reason", "")
            out.append(f'<li><b>{gid}</b>'
                       f'{(" — " + reason) if reason else ""}</li>')
        out.append('</ul></div>')

    out.append('<div class="section" style="margin-top:2em;font-size:0.9em;">'
               '<a href="../../index.html">← all words</a> · '
               '<a href="../../coord/index.html">all coords</a></div>')

    return HTML_TEMPLATE.format(word=aid, body="\n".join(out))


def render_coord_index(coords):
    """Index of all coord pages, grouped by hit count.

    coords: list of (name, coord_data, hit_count) tuples.
    """
    fours = [(n, c) for n, c, h in coords if h == 4]
    threes = [(n, c) for n, c, h in coords if h == 3]
    twos = [(n, c) for n, c, h in coords if h == 2]

    body = ['<h1>coord pages</h1>',
            '<p>Each coord is a substrate identity named by multiple '
            'unrelated vocabularies. The shared claim lives here, once; '
            'the English descendants are apertures on it.</p>']

    if fours:
        body.append(f'<h2 style="margin-top:2em;">four-way convergence '
                    f'({len(fours)})</h2><ul>')
        for name, c in fours:
            body.append(f'<li><a href="{name}.html">{name}</a> '
                        f'<span style="color:#888;">— {c.get("claim", "")[:80]}'
                        f'{"..." if len(c.get("claim", "")) > 80 else ""}'
                        f'</span></li>')
        body.append('</ul>')

    if threes:
        body.append(f'<h2 style="margin-top:2em;">three-way '
                    f'({len(threes)})</h2><ul>')
        for name, c in threes:
            body.append(f'<li><a href="{name}.html">{name}</a> '
                        f'<span style="color:#888;">— {c.get("claim", "")[:80]}'
                        f'{"..." if len(c.get("claim", "")) > 80 else ""}'
                        f'</span></li>')
        body.append('</ul>')

    if twos:
        body.append(f'<h2 style="margin-top:2em;">two-way — below filter '
                    f'threshold ({len(twos)})</h2>')
        body.append('<p style="color:#666;font-size:0.9em;">'
                    'below the 3/4 threshold. Listed here for transparency; '
                    'not ship-ready as standalone claims.</p><ul>')
        for name, c in twos:
            body.append(f'<li><a href="{name}.html">{name}</a></li>')
        body.append('</ul>')

    body.append('<div class="section" style="margin-top:3em;font-size:0.9em;">'
                '<a href="../index.html">← all words</a></div>')

    return HTML_TEMPLATE.format(word="coords", body="\n".join(body))


def render_html_index():
    from lib import cross_lang_index, redirect_descendants
    words = curated_words()
    xl = cross_lang_index()
    # Flatten into {morpheme_id: coord_name} preserving case
    xl_flat = {}
    for lang in ("sumerian", "egyptian", "chinese", "pie"):
        for mid, coord_name in xl.get(lang, {}).items():
            xl_flat.setdefault(mid, coord_name)
    # Descendant redirects — each one has its own HTML page
    redirects = redirect_descendants()
    redirect_words = sorted(r["word"].lower() for r in redirects)
    # Datalist: curated + redirect descendants + cross-lang morphemes
    opt_items = [f'    <option value="{w}">' for w in words]
    opt_items.extend(
        f'    <option value="{w}">' for w in redirect_words
    )
    opt_items.extend(
        f'    <option value="{mid}">' for mid in sorted(xl_flat.keys())
    )
    options = "\n".join(opt_items)
    import json as _json
    # Curated + redirect-descendants both land on a same-named .html
    # at the site root. URL-state handler treats them as one set.
    known_pages = sorted(set(words) | set(redirect_words))
    search_block = INDEX_SEARCH_BLOCK.format(
        options=options,
        curated_js=_json.dumps(known_pages),
        xlang_js=_json.dumps(xl_flat),
    )
    body = ['<h1>speak</h1>',
            '<p>substrate decomposition of English words. '
            'one universe, many vocabularies.</p>',
            search_block,
            '<p style="color:#666;font-size:0.9em;">'
            'or browse the curated set:</p>',
            '<ul>']
    for w in words:
        body.append(f'<li><a href="{w}.html">{w}</a></li>')
    body.append('</ul>')
    body.append('<p style="margin-top:2em;"><a href="coord/index.html">'
                '→ coord pages</a> — cross-vocabulary convergences '
                '(the argument surface).</p>')
    return HTML_TEMPLATE.format(word="index", body="\n".join(body))


if __name__ == "__main__":
    # smoke test
    import sys
    from lib import lookup
    word = sys.argv[1] if len(sys.argv) > 1 else "cognition"
    data = lookup(word)
    print(render_terminal(data))
