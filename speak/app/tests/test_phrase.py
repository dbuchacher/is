"""
Test phrase / sentence / paragraph decomposition.

Per-token dispatch: curated → stem → redirect → cross-lang → miss.
Stopwords skipped. Coord clusters surfaced when multiple tokens
share a coord.
"""
import re
import subprocess
import sys
from pathlib import Path

SPEAK = Path(__file__).resolve().parent.parent / "speak.py"


def run(args):
    res = subprocess.run(
        [sys.executable, str(SPEAK)] + args,
        capture_output=True, text=True, timeout=15,
    )
    return res.returncode, re.sub(r"\x1b\[[0-9;]*m", "", res.stdout)


def main():
    fails = []

    # 1. Multi-word plain phrase: words dispatch through their chains.
    code, out = run(["the", "king", "knows", "his", "mother"])
    if code != 0:
        fails.append(f"phrase exit: {code}")
    # collapse whitespace so ANSI-gap artifacts don't matter
    collapsed = re.sub(r"\s+", " ", out)
    for s in [
        "decomposing:", "5 token(s)",
        "the — function word",
        "king", "→ PIE genh1", "coord:", "kin-line-and-rule",
        "knows → stem know", "→ PIE gneh3",
        "his — function word",
        "mother", "→ PIE meh2ter", "kinship-mother-pair",
        "summary",
        "coords named in this phrase",
    ]:
        if s not in collapsed:
            fails.append(f"phrase output missing: {s!r}")

    # 2. Coord-cluster surfacing: two words sharing a coord should
    # land under the same coord group.
    code, out = run(["cognition", "and", "genesis", "at", "one", "root"])
    if code != 0:
        fails.append(f"coord-cluster exit: {code}")
    if "know-beget" not in out:
        fails.append("coord-cluster: know-beget missing")
    # "cognition, genesis" should appear together under know-beget
    mcluster = re.search(
        r"know-beget\s+←\s+([^\n]+)", out
    )
    if not mcluster:
        fails.append("coord-cluster: know-beget group line missing")
    else:
        members = mcluster.group(1)
        for expected in ("cognition", "genesis"):
            if expected not in members:
                fails.append(
                    f"coord-cluster: {expected} missing from know-beget group"
                )

    # 3. Pure-miss sentence (honest flagging, no force-fit).
    code, out = run(["hello", "there", "stranger"])
    if code != 0:
        fails.append(f"miss-sentence exit: {code}")
    if "— unknown" not in out:
        fails.append("miss-sentence: no 'unknown' flag")

    # 4. Single-word call still dispatches to word mode (not phrase).
    code, out = run(["cognition"])
    if code != 0:
        fails.append(f"single-word exit: {code}")
    if "decomposing:" in out:
        fails.append("single-word: fell into phrase mode")
    if "=" not in out or "re- · co- · gno- · -tion" not in out:
        fails.append("single-word: full word output missing")

    # 5. Punctuation tokenizes cleanly.
    code, out = run(["cognition,", "genesis."])
    if code != 0:
        fails.append(f"punct exit: {code}")
    if "2 token(s)" not in out:
        fails.append("punct: expected 2 tokens after stripping punct")

    if fails:
        for f in fails:
            print(f"  FAIL  {f}")
        print(f"\n{len(fails)} failure(s)")
        return 1

    print("phrase test: OK (multi-word dispatch, coord-cluster, "
          "miss-flagging, single-word passthrough, punctuation)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
