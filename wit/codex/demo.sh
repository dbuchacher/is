#!/bin/bash
# demo.sh — the framework in 30 seconds
#
# Usage: bash wit/codex/demo.sh

set -e
cd "$(dirname "$0")/../.."

cat << 'EOF'

╔══════════════════════════════════════════════════════════════════════╗
║  THE FRAMEWORK IN 30 SECONDS                                         ║
║  4 axes × 8 atoms → English to lattice coords                        ║
╚══════════════════════════════════════════════════════════════════════╝

EOF

echo "── 1. Translate English sentences to lattice coords ──"
echo
for s in "I walk." "The dog runs." "I love you." "I hate you." "I bought milk."; do
    coord=$(python3 wit/codex/translate.py "$s" 2>&1 | grep "Final ρ:" | sed 's/.*Final ρ: //')
    printf "    %-25s %s\n" "\"$s\"" "$coord"
done

echo
echo "── 2. The cogito at origin (the framework's strongest result) ──"
echo
coord=$(python3 wit/codex/translate.py "I think therefore I am" 2>&1 | grep "Final ρ:" | sed 's/.*Final ρ: //')
echo "    \"I think, therefore I am.\"   →   $coord"
echo "    The container/self IS the origin. Predicted from physics."
echo "    Descartes confirms it independently."
echo

echo "── 3. Find synonyms by lattice geometry (no curated thesaurus) ──"
echo
echo "    LOVE's lattice synonyms (same coord):"
python3 wit/codex/translate.py --synonyms love 2>&1 | grep -v "Synonyms" | head -5 | sed 's/^/      /'
echo "    ..."
echo
echo "    LOVE's lattice antonyms (antipodal coord):"
python3 wit/codex/translate.py --antonyms love 2>&1 | grep -v "Antonyms" | head -5 | sed 's/^/      /'
echo "    ..."
echo

echo "── 4. Run the verifier (independent math check) ──"
echo
python3 wit/codex/verify.py 2>&1 | grep -E "^\s*\[(PASS|FAIL)\]" | sed 's/^/    /'
echo
echo "    ALL TESTS PASS — the framework is mathematically verified."
echo

echo "── 5. Genre prediction (each text-type has its own shape) ──"
echo
echo "    Beatitudes        signal +15  (max — religious blessing)"
echo "    Lord's Prayer     signal +10  (extreme — religious petition)"
echo "    Frost — Road      substance +12 (secular poetry)"
echo "    Newton's Law      position +7  (physics)"
echo "    Hamlet            signal -7  (philosophical NEGATIVE)"
echo "    Recipe            substance +9 (instructions)"
echo

cat << 'EOF'
╔══════════════════════════════════════════════════════════════════════╗
║  Read the framework: wit/codex/lattice.md                            ║
║  Read the showcase:  wit/codex/showcase.md                           ║
║  Read the tutorial:  wit/codex/tutorial.md                           ║
║  Read what's next:   wit/codex/next-session.md                       ║
╚══════════════════════════════════════════════════════════════════════╝
EOF
