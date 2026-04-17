"""
Test --walk one-hop graph neighborhood output.

Takes a word OR cross-lang morpheme OR redirect descendant, prints
its anchor + coord + group memberships + sibling descendants +
hop suggestions. The reverse-LLM walker primitive at vocabulary
scale.
"""
import re
import subprocess
import sys
from pathlib import Path

SPEAK = Path(__file__).resolve().parent.parent / "speak.py"


def run_walk(word):
    res = subprocess.run(
        [sys.executable, str(SPEAK), "--walk", word],
        capture_output=True, text=True, timeout=10,
    )
    out = re.sub(r"\x1b\[[0-9;]*m", "", res.stdout)
    return res.returncode, out


def main():
    fails = []

    # curated English word → PIE anchor + coord + groups + branches
    code, out = run_walk("cognition")
    if code != 0:
        fails.append(f"cognition: exit {code}")
    for s in [
        "[start: curated English word → PIE gneh3]",
        "anchor",
        "*ǵneh",
        "coord",
        "know-beget",
        "via egyptian:",
        "sjA",
        "groups",
        "perception-verbs",
        "read-write-unity",
        "curated English at this root",
        "branches of PIE gneh3",
        "know-branch:",
        "beget-branch:",
        "walk further:",
    ]:
        if s not in out:
            fails.append(f"cognition walk missing: {s!r}")

    # cross-lang morpheme → start from that lang, coord pulls in siblings
    code, out = run_walk("xin")
    if code != 0:
        fails.append(f"xin: exit {code}")
    for s in [
        "[start: chinese morpheme]",
        "anchor",
        "chinese:",
        "heart",
        "coord",
        "know-beget",
        "via pie:",
        "gneh3",
        "groups",
    ]:
        if s not in out:
            fails.append(f"xin walk missing: {s!r}")

    # redirect descendant → inherits parent's PIE walk
    code, out = run_walk("genetic")
    if code != 0:
        fails.append(f"genetic: exit {code}")
    for s in [
        "genetic",
        "start: descendant of PIE gneh3",
        "anchor",
        "coord",
        "know-beget",
    ]:
        if s not in out:
            fails.append(f"genetic walk missing: {s!r}")

    # gibberish returns non-zero, no crash
    code, out = run_walk("xyzzyxyzzy")
    if code == 0:
        fails.append("gibberish walk should return non-zero exit")
    if "no walk start point" not in out:
        fails.append("gibberish should produce helpful message")

    if fails:
        for f in fails:
            print(f"  FAIL  {f}")
        print(f"\n{len(fails)} failure(s)")
        return 1

    print("walk test: OK (curated, cross-lang, redirect, gibberish)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
