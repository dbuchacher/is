#!/bin/bash
# corpus.sh — run translate.py on all test texts and report shapes
#
# Usage: bash wit/codex/corpus.sh

set -e
cd "$(dirname "$0")/../.."

echo "═══════════════════════════════════════════════════════════════════════"
echo "CORPUS REGRESSION TEST — running translate.py on all test texts"
echo "═══════════════════════════════════════════════════════════════════════"
echo ""

# Test sentences (single sentences)
echo "── Single sentences ───────────────────────────────────────────────"
for sentence in \
    "I walk." \
    "The dog runs." \
    "I bought milk." \
    "I have a hat." \
    "I love you." \
    "I hate you." \
    "I do not walk." \
    "All dogs run." \
    "No dogs run." \
    "To be or not to be."; do
    coord=$(python3 wit/codex/translate.py "$sentence" 2>&1 | grep "Final ρ:" | sed 's/.*Final ρ: //' | head -1)
    printf "  %-30s %s\n" "\"$sentence\"" "$coord"
done

echo ""
echo "── Sample words (synonyms / antonyms) ────────────────────────────"
for word in "love" "die" "create" "build" "find" "buy" "run" "rise"; do
    syns=$(python3 wit/codex/translate.py --synonyms $word 2>&1 | wc -l)
    ants=$(python3 wit/codex/translate.py --antonyms $word 2>&1 | wc -l)
    printf "  %-12s synonyms: %d, antonyms: %d\n" "$word" "$((syns-1))" "$((ants-1))"
done

echo ""
echo "── Verifier ──────────────────────────────────────────────────────"
python3 wit/codex/verify.py 2>&1 | grep -E "^\s*\[(PASS|FAIL)\]"

echo ""
echo "═══════════════════════════════════════════════════════════════════════"
echo "Done."
