# Sources: Egyptian — Reading Guide

What to read, what to skip, and why.

Location: `tmp/sources/egyptian/`


## Read in full (short, high value)

### raw-creation-glyphs.txt (37 lines)
Raw Unicode hieroglyphs for Egyptian creation passages. Actual glyph
sequences with cartouches (𓍹𓍺). No translation — pair with the
translations below.

### memphite-theology.txt (40 lines)
Shabaka Stone, Lichtheim translation. Ptah creates through heart
(thought) and tongue (speech). The key line: "every hieroglyph came
about through what the heart devised and the tongue commanded." Claims
Old Kingdom origin (~2700 BCE), surviving copy ~700 BCE.

### pyramid-texts-creation.txt (64 lines)
Creation-specific utterances extracted from Pyramid Texts (Mercer).
Atum self-creates from Nun, spews Shu and Tefnut. Includes notes
mapping Egyptian entities to Genesis parallels (Nu=ha-mayim, Shu=or,
Geb=ha-aretz, Nut=ha-shamayim, Ka=ruach, Ennead=Elohim).

### goldwasser-icon-to-metaphor.txt (16 lines)
Just the title page of Goldwasser's monograph. Skip — the actual
content is in goldwasser-metaphor.txt.

### classifier-mappings.md (257 lines)
Core data file. Every hieroglyphic classifier mapped to 4D
coordinates (𓇯,𓈖,𓇳,𓏴 = χ,μ,φ,τ). ~250 signs with coordinate
assignments and 5-word English glosses. Table format, grep-friendly.

### logogram-mappings.md (271 lines)
Same format as classifier-mappings but for logograms (signs used as
whole words rather than classifiers). ~270 entries. Together with
classifier-mappings, these two files cover the coordinate assignments
for ~520 hieroglyphs.

### goldwasser-metaphor.txt (624 lines)
Full text of Goldwasser 2005 "Where Is Metaphor?" — the most
important paper here. Core argument: Egyptian determinatives are
conceptual classifiers, not just reading aids. Metaphor = alternative
classification. The script reveals cognitive categories that exist
before language names them. Key example: HIDE AND TAIL classifier
proves Egyptians had a "mammal/animal" concept 2000 years before any
Egyptian word for "animal" existed. The conceptual system is more
detailed than language — language lags behind.

Read this one carefully. It's the theoretical foundation for treating
hieroglyphic classifiers as coordinate assignments.


## Read selectively (large, structured)

### goldwasser-classifiers.txt (2385 lines)
Table of contents + full text of an edited volume (Lingua Aegyptia
Studia Monographica 9, 2012). Multiple papers on Egyptian classifiers,
lexical semantics, spatial cognition. Skim the TOC (first ~80 lines)
to find relevant chapters. Goldwasser & Grinevald "What are
Determinatives good for?" (pp. 17-53) is the key chapter.

### gardiner-signs.json (10077 lines)
JSON array of all Gardiner sign entries. Each entry has codepoint,
gardiner number, glyph, category, transliteration, function,
description. The `coordinate` field exists but is null — these are the
source records that classifier-mappings.md was built from. Use for
lookups when you need glyph descriptions or categories.

### tla-earlier-egyptian.jsonl (12773 lines)
Thesaurus Linguae Aegyptiae corpus. Each line is JSON with:
hieroglyphs, transliteration, lemmatization (with IDs), UPOS tags,
German glossing, date range. Spans Old Kingdom through New Kingdom.
This is the actual linguistic corpus — use for verifying glyph usage
in context, checking co-occurrence, validating coordinate assignments.

### raw-glyphs.txt (12773 lines)
Raw hieroglyphic text corpus in Unicode. Same content as the TLA
corpus but just the glyph sequences without annotation. Use
tla-earlier-egyptian.jsonl instead — it has everything this has plus
transliteration and dates.


## Reference only (very large, use for lookups)

### pyramid-texts-allen.txt (29559 lines)
Allen's full Pyramid Text translation. Comprehensive but huge.
Search with grep when you need a specific utterance.

### pyramid-texts-mercer.txt (26268 lines)
Mercer's full Pyramid Text translation (1952, public domain).
Older scholarship but complete. Same advice — grep, don't read.

### Unikemet.txt (37962 lines)
Unicode Unikemet 16.0 reference data. Normative character database
for Egyptian hieroglyphs. Tab-separated: codepoint, tag, value.
Contains catalog values, descriptions, functions, JSesh/Hieroglyphica
sources. Use for character identification and cross-referencing.


## Skip

### fischer-calligraphy.txt (0 lines)
Empty file. The PDF exists but the text extraction failed.

### goldwasser-mirror.txt (7031 lines)
Garbled OCR/PDF extraction. Mostly noise characters. The actual
content is probably goldwasser-classifiers.txt or another paper.
Not usable.

### PDFs (fischer-calligraphy.pdf, goldwasser-*.pdf, pyramid-texts-*.pdf)
Source PDFs. The .txt versions are the extracted text. Only go to
the PDFs if the .txt extraction is bad (which it is for
goldwasser-mirror and fischer-calligraphy).


## Loading order for a new session

1. classifier-mappings.md + logogram-mappings.md (the coordinate data)
2. goldwasser-metaphor.txt (the theoretical framework)
3. memphite-theology.txt + pyramid-texts-creation.txt (the texts)
4. raw-creation-glyphs.txt (the actual glyphs, with translations loaded)
5. Everything else as needed via grep
