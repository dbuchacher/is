#!/usr/bin/env python3
"""
translate.py — automated English-to-lattice-coord translator

Usage:
    python3 translate.py "I bought milk."
    python3 translate.py --file genesis.txt
    echo "the dog runs" | python3 translate.py
    python3 translate.py            # interactive mode

Tokenizes English input, looks up each word in the vocabulary, and
computes the ρ walk through the lattice. Outputs the final coord
plus a per-word trace.

This is the WORKING DEMO of the framework: type any English sentence
and watch it walk the lattice.
"""

import re
import sys
from typing import Dict, List, Tuple

Coord = Tuple[int, int, int, int]
ORIGIN: Coord = (0, 0, 0, 0)

# ─── Vocabulary (curated from verbs.md, nouns.md, modifiers.md, etc.) ─

# This is a hand-curated subset of the most common English words and
# their coords. Loaded from the codex files conceptually but listed
# inline here for self-containment.

VOCAB: Dict[str, Coord] = {
    # ─── Atoms ───
    "rise": (1, 0, 0, 0),
    "fall": (-1, 0, 0, 0),
    "grow": (0, 1, 0, 0),
    "shrink": (0, -1, 0, 0),
    "bless": (0, 0, 1, 0),
    "curse": (0, 0, -1, 0),
    "begin": (0, 0, 0, 1),
    "end": (0, 0, 0, -1),

    # ─── A axis (position) family ───
    "go": (1, 0, 0, 0),
    "come": (1, 0, 0, 0),
    "move": (1, 0, 0, 0),
    "run": (1, 0, 0, 0),
    "walk": (1, 0, 0, 0),
    "reach": (1, 0, 0, 0),
    "visit": (1, 0, 0, 0),
    "return": (1, 0, 0, 0),
    "follow": (1, 0, 0, 0),
    "travel": (1, 0, 0, 0),
    "leave": (-1, 0, 0, 0),
    "drop": (-1, 0, 0, 0),
    "lower": (-1, 0, 0, 0),
    "ran": (1, 0, 0, 0),
    "went": (-1, 0, 0, -1),
    "came": (1, 0, 0, -1),
    "walked": (1, 0, 0, -1),
    "left": (-1, 0, 0, -1),

    # ─── B axis (substance) family ───
    "add": (0, 1, 0, 0),
    "include": (0, 1, 0, 0),
    "fill": (0, 1, 0, 0),
    "gain": (0, 1, 0, 0),
    "increase": (0, 1, 0, 0),
    "expand": (0, 1, 0, 0),
    "have": (0, 0, 0, 0),  # stative possession = origin
    "had": (0, 0, 0, 0),
    "has": (0, 0, 0, 0),
    "got": (0, 1, 0, 0),
    "get": (0, 1, 0, 0),
    "remove": (0, -1, 0, 0),
    "cut": (0, -1, 0, 0),
    "reduce": (0, -1, 0, 0),
    "empty": (0, -1, 0, 0),

    # ─── C axis (signal) family ───
    "love": (0, 0, 1, 0),
    "like": (0, 0, 1, 0),
    "honor": (0, 0, 1, 0),
    "praise": (0, 0, 1, 0),
    "thank": (0, 0, 1, 0),
    "reward": (0, 0, 1, 0),
    "good": (0, 0, 1, 0),
    "true": (0, 0, 1, 0),
    "great": (0, 0, 1, 0),
    "fair": (0, 0, 1, 0),
    "right": (0, 0, 1, 0),
    "hate": (0, 0, -1, 0),
    "blame": (0, 0, -1, 0),
    "punish": (0, 0, -1, 0),
    "reject": (0, 0, -1, 0),
    "fail": (0, 0, -1, 0),
    "bad": (0, 0, -1, 0),
    "wrong": (0, 0, -1, 0),
    "sorry": (0, 0, -1, 0),
    "ugly": (0, 0, -1, 0),

    # ─── D axis (time) family ───
    "start": (0, 0, 0, 1),
    "open": (0, 0, 0, 1),
    "launch": (0, 0, 0, 1),
    "stop": (0, 0, 0, -1),
    "close": (0, 0, 0, -1),
    "finish": (0, 0, 0, -1),
    "cease": (0, 0, 0, -1),
    "now": (0, 0, 0, 0),  # proximal
    "new": (0, 0, 0, 1),
    "old": (0, 0, 0, -1),

    # ─── Dyads ───
    "build": (1, 1, 0, 0),
    "construct": (1, 1, 0, 0),
    "make": (0, 1, 0, 1),
    "create": (0, 1, 0, 1),
    "write": (0, 1, 0, 1),
    "print": (0, 1, 0, 1),
    "destroy": (0, -1, 0, -1),
    "delete": (0, -1, 0, -1),
    "kill": (0, -1, 0, -1),
    "demolish": (-1, -1, 0, 0),
    "break": (-1, -1, 0, 0),
    "buy": (0, 1, -1, 0),
    "bought": (0, 1, -1, -1),
    "purchase": (0, 1, -1, 0),
    "sell": (0, -1, 1, 0),
    "sold": (0, -1, 1, -1),
    "earn": (0, 1, 1, 0),
    "earned": (0, 1, 1, -1),
    "waste": (0, -1, -1, 0),
    "spend": (0, -1, -1, 0),
    "spent": (0, -1, -1, -1),
    "pay": (0, -1, -1, 0),
    "paid": (0, -1, -1, -1),
    "advance": (1, 0, 1, 0),
    "retreat": (-1, 0, -1, 0),
    "enter": (1, 0, 0, 1),
    "exit": (-1, 0, 0, -1),
    "live": (0, 0, 1, 1),
    "die": (0, 0, -1, -1),
    "died": (0, 0, -1, -1),
    "remember": (0, 0, 1, -1),
    "forget": (0, 0, -1, 1),

    # ─── Triads ───
    "find": (1, 1, 1, 0),
    "found": (1, 1, 1, -1),
    "lose": (-1, -1, -1, 0),
    "lost": (-1, -1, -1, -1),
    "give": (0, -1, 1, 1),
    "gave": (0, -1, 1, 0),
    "take": (0, 1, -1, -1),
    "took": (0, 1, -1, -1),
    "help": (1, 0, 1, 1),
    "hurt": (-1, 0, -1, -1),

    # ─── Container (origin) ───
    "i": (0, 0, 0, 0),
    "me": (0, 0, 0, 0),
    "my": (0, 0, 0, 0),
    "we": (0, 0, 0, 0),
    "us": (0, 0, 0, 0),
    "our": (0, 0, 0, 0),
    "you": (0, 0, 0, 0),
    "your": (0, 0, 0, 0),
    "think": (0, 0, 0, 0),
    "thought": (0, 0, 0, 0),
    "know": (0, 0, 0, 0),
    "knew": (0, 0, 0, 0),
    "be": (0, 0, 0, 0),
    "am": (0, 0, 0, 0),
    "is": (0, 0, 0, 0),
    "are": (0, 0, 0, 0),
    "was": (0, 0, 0, 0),
    "were": (0, 0, 0, 0),
    "been": (0, 0, 0, 0),
    "exist": (0, 0, 0, 0),
    "feel": (0, 0, 0, 0),
    "felt": (0, 0, 0, 0),
    "see": (0, 0, 0, 0),
    "saw": (0, 0, 0, 0),
    "look": (0, 0, 0, 0),
    "watch": (0, 0, 0, 0),
    "hear": (0, 0, 0, 0),
    "heard": (0, 0, 0, 0),
    "listen": (0, 0, 0, 0),
    "say": (0, 0, 0, 0),
    "said": (0, 0, 0, 0),
    "tell": (0, 0, 0, 0),
    "told": (0, 0, 0, 0),
    "ask": (0, 0, 0, 0),
    "asked": (0, 0, 0, 0),
    "speak": (0, 0, 0, 0),
    "talk": (0, 0, 0, 0),
    "want": (0, 0, 0, 0),
    "wanted": (0, 0, 0, 0),
    "need": (0, 0, 0, 0),
    "wish": (0, 0, 0, 0),
    "hope": (0, 0, 0, 0),
    "dream": (0, 0, 0, 0),
    "sleep": (0, 0, 0, 0),
    "rest": (0, 0, 0, 0),
    "wait": (0, 0, 0, 0),
    "stay": (0, 0, 1, 1),  # persist coord
    "keep": (0, 0, 0, 0),
    "do": (0, 0, 0, 0),
    "did": (0, 0, 0, -1),
    "does": (0, 0, 0, 0),
    "done": (0, 0, 0, 0),
    "this": (0, 0, 0, 0),
    "that": (0, 0, 0, 0),
    "these": (0, 0, 0, 0),
    "it": (0, 0, 0, 0),
    "he": (0, 0, 0, 0),
    "she": (0, 0, 0, 0),
    "they": (0, 0, 0, 0),
    "him": (0, 0, 0, 0),
    "her": (0, 0, 0, 0),
    "them": (0, 0, 0, 0),
    "here": (0, 0, 0, 0),
    "name": (0, 0, 0, 0),
    "word": (0, 0, 0, 0),
    "way": (0, 0, 0, 0),
    "mind": (0, 0, 0, 0),
    "self": (0, 0, 0, 0),
    "love_n": (0, 0, 0, 0),  # noun sense

    # ─── Nouns at specific coords ───
    "hat": (1, 1, 0, 0),
    "tower": (1, 1, 0, 0),
    "roof": (1, 1, 0, 0),
    "head": (1, 1, 0, 0),
    "mountain": (1, 1, 0, 0),
    "house": (1, 1, 0, 0),
    "building": (1, 1, 0, 0),
    "office": (1, 1, 0, 0),
    "store": (0, 1, 1, 0),
    "shop": (0, 1, 1, 0),
    "money": (0, 0, 1, 0),
    "gold": (0, 0, 1, 0),
    "value": (0, 0, 1, 0),
    "price": (0, 0, 1, 0),
    "credit": (0, 0, 1, 0),
    "gift": (0, -1, 1, 1),
    "milk": (0, 1, 0, 0),
    "water": (0, 1, 0, 0),
    "food": (0, 1, 0, 0),
    "bread": (0, 1, 0, 0),
    "tree": (0, 1, 0, 0),
    "wood": (0, 1, 1, 0),
    "leaves": (0, 1, 0, 0),
    "object": (0, 1, 0, 0),
    "thing": (0, 1, 0, 0),
    "stuff": (0, 1, 0, 0),
    "matter": (0, 1, 0, 0),
    "body": (0, 1, 0, 0),
    "fire": (0, 1, 1, 1),
    "life": (0, 0, 1, 1),
    "heart": (0, 1, 1, 1),
    "dog": (0, 1, 1, 1),
    "cat": (0, 1, 1, 1),
    "person": (0, 1, 1, 1),
    "people": (0, 1, 1, 1),
    "child": (0, 1, 1, 1),
    "man": (0, 1, 1, 1),
    "woman": (0, 1, 1, 1),
    "friend": (0, 1, 1, 1),
    "family": (0, 1, 1, 1),
    "hole": (-1, -1, 0, 0),
    "pit": (-1, -1, 0, 0),
    "cave": (-1, -1, 0, 0),
    "grave": (-1, -1, 0, 0),
    "death": (0, 0, -1, -1),
    "morning": (0, 0, 0, 1),
    "night": (0, 0, 0, -1),
    "day": (0, 0, 1, 0),
    "evening": (0, 0, 0, -1),
    "beginning": (0, 0, 0, 1),
    "trouble": (0, 0, -1, 0),
    "problem": (0, 0, -1, 0),
    "sky": (1, 0, 0, 0),
    "heaven": (1, 0, 0, 0),
    "heavens": (1, 0, 0, 0),
    "earth": (-1, 0, 0, 0),
    "ground": (-1, 0, 0, 0),
    "floor": (-1, 0, 0, 0),
    "top": (1, 0, 0, 0),
    "bottom": (-1, 0, 0, 0),

    # ─── Adjectives ───
    "big": (0, 1, 0, 0),
    "large": (0, 1, 0, 0),
    "huge": (0, 2, 0, 0),
    "small": (0, -1, 0, 0),
    "little": (0, -1, 0, 0),
    "high": (1, 0, 0, 0),
    "low": (-1, 0, 0, 0),
    "above": (1, 0, 0, 0),
    "below": (-1, 0, 0, 0),
    "tall": (1, 0, 0, 0),
    "short": (-1, 0, 0, 0),
    "alive": (0, 0, 1, 1),
    "dead": (0, 0, -1, -1),

    # ─── Modifiers / function words (mostly origin or shifts) ───
    "the": (0, 0, 0, 0),
    "a": (0, 0, 0, 0),
    "an": (0, 0, 0, 0),
    "and": (0, 0, 0, 0),
    "or": (0, 0, 0, 0),
    "but": (0, 0, 0, 0),
    "if": (0, 0, 0, 0),
    "in": (1, 0, 0, 0),
    "on": (1, 0, 0, 0),
    "at": (0, 0, 0, 0),
    "to": (1, 0, 0, 0),
    "from": (-1, 0, 0, 0),
    "of": (0, 0, 0, 0),
    "with": (0, 0, 0, 0),
    "by": (0, 0, 0, 0),
    "for": (0, 0, 0, 0),
    "out": (-1, 0, 0, 0),
    "up": (1, 0, 0, 0),
    "down": (-1, 0, 0, 0),
    "over": (1, 0, 0, 0),
    "under": (-1, 0, 0, 0),
    "before": (0, 0, 0, -1),
    "after": (0, 0, 0, 1),

    # ─── Negation ───
    "not": (0, 0, 0, 0),  # polarity NOT — applied separately
    "no": (0, 0, 0, 0),

    # ─── Modals (bond layer — origin under content rule) ───
    "can": (0, 0, 0, 0),
    "could": (0, 0, 0, 0),
    "may": (0, 0, 0, 0),
    "might": (0, 0, 0, 0),
    "must": (0, 0, 0, 0),
    "shall": (0, 0, 0, 0),
    "should": (0, 0, 0, 0),
    "will": (0, 0, 0, 1),
    "would": (0, 0, 0, 0),

    # ─── Filling in more common nouns/concepts ───
    "question": (0, 0, 0, 0),  # abstract
    "answer": (0, 0, 0, 0),
    "idea": (0, 0, 0, 0),
    "love": (0, 0, 1, 0),  # as both noun and verb
    "evil": (0, 0, -1, 0),  # CURSE atom
    "good_n": (0, 0, 1, 0),
    "fortune": (0, 0, 1, 0),
    "power": (0, 1, 1, 0),
    "all": (0, 0, 0, 0),  # universal scope marker
    "every": (0, 0, 0, 0),
    "some": (0, 0, 0, 0),
    "many": (0, 1, 0, 0),
    "much": (0, 1, 0, 0),
    "few": (0, -1, 0, 0),
    "root": (-1, 1, 0, 0),  # FALL+GROW (downward substance)
    "kingdom": (1, 1, 1, 0),  # FIND triad — domain
    "glory": (0, 0, 2, 0),  # shell-2 BLESS
    "spirit": (0, 0, 1, 0),
    "father": (0, 0, 0, 0),  # origin (parent of self)
    "mother": (0, 1, 1, 1),
    "deep": (-1, 0, 0, 0),
    "surface": (1, 0, 0, 0),
    "wind": (1, 0, 0, 0),
    "air": (1, 0, 0, 0),
    "land": (-1, 1, 0, 0),
    "world": (0, 1, 0, 0),
    "light": (0, 0, 1, 0),  # noun = signal
    "darkness": (0, 0, -1, 0),
    "dark": (0, 0, -1, 0),
    "sea": (0, 2, 0, 0),  # large substance
    "river": (0, 1, 0, 1),  # flowing substance
    "road": (1, 1, 0, 0),
    "path": (1, 0, 0, 0),
    "way_n": (0, 0, 0, 0),
    "moment": (0, 0, 0, 0),  # instant
    "time": (0, 0, 0, 0),
    "year": (0, 0, 0, 0),
    "sin": (0, 0, -1, 0),
    "grace": (0, 0, 1, 0),
    "peace": (0, 0, 1, 0),
    "war": (0, 0, -1, 0),
    "joy": (0, 0, 1, 0),
    "pain": (0, 0, -1, 0),
    "fear": (0, 0, -1, 0),
    "hope_n": (0, 0, 1, 0),

    # ─── More common English from various texts ───
    "poor": (0, -1, -1, 0),  # lacking substance + negative state
    "rich": (0, 1, 1, 0),    # EARN coord
    "those": (0, 0, 0, 0),   # demonstrative
    "who": (0, 0, 0, 0),     # interrogative
    "what": (0, 0, 0, 0),
    "when": (0, 0, 0, 0),
    "where": (0, 0, 0, 0),
    "why": (0, 0, 0, 0),
    "how": (0, 0, 0, 0),
    "mourn": (0, 0, -1, 0),
    "comfort": (0, 0, 1, 0),
    "comforted": (0, 0, 1, 0),
    "meek": (0, 0, 0, 0),    # humble = origin
    "hunger": (0, -1, -1, 0),
    "thirst": (0, -1, -1, 0),
    "righteousness": (0, 0, 1, 0),
    "merciful": (0, 0, 1, 0),
    "mercy": (0, 0, 1, 0),
    "pure": (0, 0, 1, 0),
    "god": (0, 0, 0, 0),     # ultimate container
    "peacemaker": (0, 0, 1, 0),
    "peacemakers": (0, 0, 1, 0),
    "called": (0, 0, 0, 0),  # past CALL = container
    "children": (0, 1, 1, 1),
    "persecuted": (0, 0, -1, -1),
    "sake": (0, 0, 0, 0),
    "theirs": (0, 0, 0, 0),
    "yours": (0, 0, 0, 0),
    "his": (0, 0, 0, 0),
    "hers": (0, 0, 0, 0),
    "ours": (0, 0, 0, 0),
    "inherit": (0, 1, 0, 0),  # gain substance
    "obtain": (0, 1, 0, 0),
    "filled": (0, 1, 0, 0),
    "fill_n": (0, 1, 0, 0),

    # More common verbs (past forms)
    "lived": (0, 0, 1, 1),
    "loved": (0, 0, 1, 0),
    "hated": (0, 0, -1, 0),
    "feared": (0, 0, -1, 0),
    "found_v": (1, 1, 1, 0),
    "made": (0, 1, 0, 1),
    "created": (0, 1, 0, 1),
    "destroyed": (0, -1, 0, -1),
    "killed": (0, -1, 0, -1),
    "blessed": (0, 0, 1, 0),
    "cursed": (0, 0, -1, 0),
    "began": (0, 0, 0, 1),
    "ended": (0, 0, 0, -1),
    "rose": (1, 0, 0, 0),
    "fell": (-1, 0, 0, 0),
    "grew": (0, 1, 0, 0),
    "shrank": (0, -1, 0, 0),

    # More nouns
    "hand": (0, 1, 0, 0),
    "foot": (-1, 1, 0, 0),
    "arm": (0, 1, 0, 0),
    "leg": (-1, 1, 0, 0),
    "eye": (1, 1, 0, 0),
    "ear": (1, 1, 0, 0),
    "mouth": (1, 1, 0, 0),
    "face": (1, 1, 0, 0),
    "body": (0, 1, 0, 0),
    "blood": (0, 1, 1, 1),
    "bone": (0, 1, 0, 0),
    "skin": (0, 1, 0, 0),
    "tree": (0, 1, 0, 0),
    "flower": (0, 1, 1, 1),
    "rock": (0, 1, 0, 0),
    "stone": (0, 1, 0, 0),
    "river": (0, 1, 0, 1),
    "lake": (0, 1, 0, 0),
    "ocean": (0, 2, 0, 0),
    "star": (0, 1, 1, 1),
    "sun": (1, 1, 1, 1),
    "moon": (1, 1, 0, 0),
    "cloud": (1, 1, 0, 0),
    "rain": (-1, 1, 0, 0),
    "snow": (-1, 1, 0, 0),

    # Time words
    "today": (0, 0, 0, 0),
    "tomorrow": (0, 0, 0, 1),
    "yesterday": (0, 0, 0, -1),
    "always": (0, 0, 0, 1),
    "never": (0, 0, 0, -1),
    "often": (0, 0, 0, 1),
    "sometimes": (0, 0, 0, 0),
    "soon": (0, 0, 0, 1),
    "later": (0, 0, 0, 1),
    "early": (0, 0, 0, 1),
    "late": (0, 0, 0, -1),

    # ─── Numbers ───
    "one": (0, 1, 0, 0),
    "two": (0, 1, 0, 0),
    "three": (0, 1, 0, 0),
    "four": (0, 1, 0, 0),
    "five": (0, 1, 0, 0),
    "six": (0, 1, 0, 0),
    "seven": (0, 1, 0, 0),
    "eight": (0, 1, 0, 0),
    "nine": (0, 1, 0, 0),
    "ten": (0, 1, 0, 0),
    "first": (0, 0, 0, -1),  # ordinal first = earliest
    "second": (0, 0, 0, 0),
    "third": (0, 0, 0, 1),
    "last": (0, 0, 0, -1),

    # ─── Family ───
    "brother": (0, 1, 1, 1),
    "sister": (0, 1, 1, 1),
    "son": (0, 1, 1, 1),
    "daughter": (0, 1, 1, 1),
    "wife": (0, 1, 1, 1),
    "husband": (0, 1, 1, 1),
    "parent": (0, 1, 1, 1),
    "baby": (0, 1, 1, 1),

    # ─── Common verbs not yet in vocab ───
    "eat": (0, 1, 0, 0),  # body gains substance
    "ate": (0, 1, 0, -1),
    "drink": (0, 1, 0, 0),
    "drank": (0, 1, 0, -1),
    "sit": (0, 0, 0, 0),  # stative
    "sat": (0, 0, 0, -1),
    "stand": (0, 0, 0, 0),
    "stood": (0, 0, 0, -1),
    "lie": (0, 0, 0, 0),
    "lay": (0, 0, 0, -1),
    "breathe": (0, 0, 0, 0),
    "breath": (0, 0, 0, 0),
    "let": (0, 0, 0, 0),  # modal
    "there": (0, 0, 0, 0),
    "separated": (0, -1, 0, 0),
    "separate": (0, -1, 0, 0),
    "formless": (0, 0, 0, 0),
    "hovering": (0, 0, 0, 0),
    "hover": (0, 0, 0, 0),
    "save": (0, 0, 1, -1),  # REMEMBER family
    "saved": (0, 0, 1, -1),

    # ─── More adjectives ───
    "strong": (0, 1, 1, 0),
    "weak": (0, -1, -1, 0),
    "young": (0, 0, 0, 1),
    "ancient": (0, 0, 0, -1),
    "beautiful": (0, 0, 1, 0),
    "happy": (0, 0, 1, 0),
    "sad": (0, 0, -1, 0),
    "angry": (0, 0, -1, 0),
    "afraid": (0, 0, -1, 0),
    "calm": (0, 0, 0, 0),
    "warm": (0, 0, 1, 0),
    "cold": (0, 0, -1, 0),
    "hot": (0, 0, 1, 0),
    "wet": (0, 1, 0, 0),
    "dry": (0, -1, 0, 0),
    "clean": (0, 0, 1, 0),
    "dirty": (0, 0, -1, 0),
    "free": (0, 0, 1, 0),
    "bound": (0, 0, -1, 0),
    "open_a": (0, 0, 0, 1),
    "closed_a": (0, 0, 0, -1),

    # ─── Common nouns from secular texts ───
    "score": (0, 1, 0, 0),  # Gettysburg
    "year": (0, 0, 0, 0),
    "years": (0, 0, 0, 0),
    "ago": (0, 0, 0, -1),
    "fathers": (0, 1, 1, 1),
    "brought": (0, 1, 0, -1),
    "bring": (0, 1, 0, 0),
    "forth": (0, 0, 0, 1),
    "continent": (0, 1, 0, 0),
    "nation": (0, 1, 1, 1),
    "conceived": (0, 1, 0, 1),
    "liberty": (0, 0, 1, 0),
    "dedicated": (0, 0, 1, 0),
    "proposition": (0, 0, 0, 0),
    "men": (0, 1, 1, 1),
    "equal": (0, 0, 0, 0),
    "compare": (0, 0, 0, 0),
    "thee": (0, 0, 0, 0),
    "summer": (0, 0, 1, 0),  # warmth season
    "winter": (0, 0, -1, 0),
    "spring": (0, 0, 0, 1),
    "autumn": (0, 0, 0, -1),
    "fall_n": (0, 0, 0, -1),

    # ─── Intensifiers (would push next word to shell 2 if we had
    #     proper modifier composition; for now they're origin or
    #     small magnitude markers) ───
    "very": (0, 0, 0, 0),     # intensifier — applied to next word
    "really": (0, 0, 0, 0),
    "extremely": (0, 0, 0, 0),
    "truly": (0, 0, 0, 0),
    "quite": (0, 0, 0, 0),
    "totally": (0, 0, 0, 0),
    "absolutely": (0, 0, 0, 0),
    "almost": (0, 0, 0, 0),
    "nearly": (0, 0, 0, 0),
    "just": (0, 0, 0, 0),
    "only": (0, 0, 0, 0),
    "barely": (0, 0, 0, 0),
    "hardly": (0, 0, 0, 0),
    "well": (0, 0, 1, 0),       # adverbial form of GOOD
    "badly": (0, 0, -1, 0),
    "quickly": (1, 0, 0, 1),    # speed
    "slowly": (-1, 0, 0, -1),
    "carefully": (0, 0, 1, 0),
    "loudly": (0, 0, 1, 0),
    "softly": (0, 0, -1, 0),

    # ─── More common verbs ───
    "becomes": (0, 1, 0, 1),
    "became": (0, 1, 0, 0),
    "changing": (0, 0, 0, 0),
    "changed": (0, 0, 0, 0),
    "showed": (0, 0, 1, 1),
    "shown": (0, 0, 1, 1),
    "show": (0, 0, 1, 1),
    "explain": (0, 0, 0, 0),
    "explained": (0, 0, 0, 0),
    "remember_v": (0, 0, 1, -1),
    "forget_v": (0, 0, -1, 1),

    # ─── Additional grammatical particles ───
    "yes": (0, 0, 1, 0),
    "okay": (0, 0, 1, 0),
    "ok": (0, 0, 1, 0),
    "well_int": (0, 0, 0, 0),
    "oh": (0, 0, 0, 0),
    "ah": (0, 0, 0, 0),

    # ─── Famous words from various texts ───
    "dust": (0, 1, 0, 0),
    "ash": (0, 1, 0, 0),
    "wisdom": (0, 0, 1, 0),
    "knowledge": (0, 0, 1, 0),
    "secret": (0, 0, 1, 0),
    "lie_n": (0, 0, -1, 0),
    "truth_n": (0, 0, 1, 0),
    "promise": (0, 0, 0, 1),
    "threat": (0, 0, -1, -1),
    "law": (0, 0, 1, 0),
    "rule": (0, 0, 1, 0),
    "order_n": (0, 0, 0, 0),
    "freedom": (0, 0, 0, 0),
    "slavery": (0, 0, -1, 0),
    "victory": (1, 0, 1, 0),
    "defeat_n": (-1, 0, -1, 0),
}

# ─── Composition functions ───────────────────────────────────────────

def compose(a: Coord, b: Coord) -> Coord:
    return tuple(a[i] + b[i] for i in range(4))

def negate(c: Coord) -> Coord:
    return tuple(-c[i] for i in range(4))

def fmt(c: Coord) -> str:
    return "[" + ", ".join(f"{v:+d}".replace("+0", " 0").rjust(3) for v in c) + "]"

def tokenize(text: str) -> List[str]:
    """Simple tokenizer: lowercase, strip punctuation, split."""
    text = text.lower()
    text = re.sub(r"[^\w\s']", " ", text)
    tokens = text.split()
    return tokens

def lookup(word: str) -> Coord:
    """Look up a word in the vocab. Returns origin if not found."""
    if word in VOCAB:
        return VOCAB[word]
    # Try simple stemming for inflected forms
    for suffix in ('s', 'es', 'ed', 'ing', 'er', 'est', 'ly'):
        if word.endswith(suffix):
            stem = word[:-len(suffix)]
            if stem in VOCAB:
                return VOCAB[stem]
            # Also try stem + 'e' (e.g., "loved" → "love")
            if stem + 'e' in VOCAB:
                return VOCAB[stem + 'e']
    return ORIGIN

def translate(text: str, verbose: bool = True) -> Coord:
    """Translate English text to a lattice coord."""
    tokens = tokenize(text)

    if verbose:
        print(f"\n  Input: \"{text}\"")
        print(f"  Tokens: {tokens}")
        print()

    rho = ORIGIN
    pending_not = False

    if verbose:
        print(f"  ρ₀ = {fmt(rho)}    (start at origin)")

    unknown = []
    for i, token in enumerate(tokens, 1):
        if token in ('not', "n't"):
            pending_not = True
            continue

        coord = lookup(token)
        if token in VOCAB:
            marker = ""
        elif coord != ORIGIN:
            marker = "  (stemmed)"
        else:
            unknown.append(token)
            marker = "  (unknown — defaulting to origin)"

        if pending_not:
            coord = negate(coord)
            marker += "  (NOT applied)"
            pending_not = False

        rho = compose(rho, coord)

        if verbose:
            print(f"  ρ{i:<2} = {fmt(rho)}    + {token:<14} {fmt(coord)}{marker}")

    if verbose:
        print()
        print(f"  Final ρ: {fmt(rho)}")
        if unknown:
            print(f"  Unknown words: {unknown}")

        # Interpret the dominant axis
        labels = ["POSITION", "SUBSTANCE", "SIGNAL", "TIME"]
        max_idx = max(range(4), key=lambda i: abs(rho[i]))
        if rho[max_idx] != 0:
            sign = "+" if rho[max_idx] > 0 else "-"
            print(f"  Dominant: {labels[max_idx]} {sign}{abs(rho[max_idx])}")

    return rho

def manhattan_distance(a: Coord, b: Coord) -> int:
    """L1 distance between two coords on the lattice."""
    return sum(abs(a[i] - b[i]) for i in range(4))

def find_neighbors(coord: Coord, max_distance: int = 0) -> List[Tuple[str, Coord, int]]:
    """
    Find all words within max_distance of the given coord (Manhattan).
    Returns list of (word, coord, distance) sorted by distance.
    """
    results = []
    for word, c in VOCAB.items():
        d = manhattan_distance(c, coord)
        if d <= max_distance:
            results.append((word, c, d))
    return sorted(results, key=lambda x: (x[2], x[0]))

def synonyms(word: str) -> List[str]:
    """Find all words at the SAME coord as the given word."""
    if word not in VOCAB:
        return []
    target = VOCAB[word]
    return [w for w, c in VOCAB.items() if c == target and w != word]

def antonyms(word: str) -> List[str]:
    """Find all words at the antipodal coord of the given word."""
    if word not in VOCAB:
        return []
    target = negate(VOCAB[word])
    return [w for w, c in VOCAB.items() if c == target]

def main():
    args = sys.argv[1:]

    if not args:
        # Demo mode: run several test sentences
        demos = [
            "I walk.",
            "I see the dog.",
            "I bought milk.",
            "The dog runs.",
            "I have a hat.",
            "I do not walk.",
            "In the beginning God created the heavens and the earth.",
            "To be or not to be.",
            "An object at rest stays at rest.",
            "Money is the root of all evil.",
        ]

        print()
        print("█" * 70)
        print("LATTICE TRANSLATOR — DEMO MODE")
        print("█" * 70)

        for sentence in demos:
            translate(sentence, verbose=True)
            print()
            print("─" * 70)

        return 0

    if args[0] == '--file' and len(args) > 1:
        with open(args[1]) as f:
            text = f.read()
        translate(text, verbose=True)
        return 0

    if args[0] == '--lines' and len(args) > 1:
        # Process each line separately, reporting per-line coords
        with open(args[1]) as f:
            lines = [line.strip() for line in f if line.strip()]
        print()
        print(f"Processing {len(lines)} lines independently")
        print("=" * 70)
        line_coords = []
        for i, line in enumerate(lines, 1):
            print(f"\n  Line {i}: \"{line}\"")
            coord = translate(line, verbose=False)
            print(f"  → {fmt(coord)}")
            line_coords.append(coord)
        # Sum
        total = ORIGIN
        for c in line_coords:
            total = compose(total, c)
        print()
        print("=" * 70)
        print(f"  Total (sum of all lines): {fmt(total)}")
        labels = ["POSITION", "SUBSTANCE", "SIGNAL", "TIME"]
        max_idx = max(range(4), key=lambda i: abs(total[i]))
        if total[max_idx] != 0:
            sign = "+" if total[max_idx] > 0 else "-"
            print(f"  Dominant: {labels[max_idx]} {sign}{abs(total[max_idx])}")
        return 0

    if args[0] == '--synonyms' and len(args) > 1:
        word = args[1].lower()
        syns = synonyms(word)
        if not syns:
            print(f"No synonyms found for '{word}' (or word not in vocab)")
        else:
            print(f"Synonyms of '{word}' (same coord {fmt(VOCAB.get(word, ORIGIN))}):")
            for s in sorted(syns):
                print(f"  {s}")
        return 0

    if args[0] == '--antonyms' and len(args) > 1:
        word = args[1].lower()
        ants = antonyms(word)
        if not ants:
            print(f"No antonyms found for '{word}' (or word not in vocab)")
        else:
            print(f"Antonyms of '{word}' (antipodal coord):")
            for a in sorted(ants):
                print(f"  {a}  {fmt(VOCAB[a])}")
        return 0

    if args[0] == '--neighbors' and len(args) > 1:
        word = args[1].lower()
        if word in VOCAB:
            target = VOCAB[word]
        else:
            print(f"Word '{word}' not in vocab")
            return 1
        max_d = int(args[2]) if len(args) > 2 else 1
        neighbors = find_neighbors(target, max_distance=max_d)
        print(f"Neighbors of '{word}' {fmt(target)} (distance ≤ {max_d}):")
        for w, c, d in neighbors:
            if w != word:
                print(f"  d={d}  {w:<14} {fmt(c)}")
        return 0

    if args[0] == '--coord' and len(args) > 1:
        # --coord "0,1,1,1" find words at this coord
        coord_str = args[1]
        try:
            parts = [int(x.strip()) for x in coord_str.split(',')]
            target = tuple(parts)
            assert len(target) == 4
        except (ValueError, AssertionError):
            print(f"Invalid coord: {coord_str}. Format: '0,1,1,1'")
            return 1
        max_d = int(args[2]) if len(args) > 2 else 0
        neighbors = find_neighbors(target, max_distance=max_d)
        print(f"Words at/near {fmt(target)} (distance ≤ {max_d}):")
        for w, c, d in neighbors:
            print(f"  d={d}  {w:<14} {fmt(c)}")
        return 0

    if args[0] == '--help':
        print(__doc__)
        print()
        print("Modes:")
        print("  python3 translate.py                 # demo mode")
        print("  python3 translate.py 'sentence'      # translate text")
        print("  python3 translate.py --file FILE     # translate file")
        print("  python3 translate.py --synonyms WORD")
        print("  python3 translate.py --antonyms WORD")
        print("  python3 translate.py --neighbors WORD [DISTANCE]")
        print("  python3 translate.py --coord 'A,B,C,D' [DISTANCE]")
        return 0

    # Otherwise translate the args as a sentence
    text = ' '.join(args)
    translate(text, verbose=True)
    return 0

if __name__ == "__main__":
    sys.exit(main())
