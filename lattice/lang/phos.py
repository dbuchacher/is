#!/usr/bin/env python3
"""phos — lattice walk preprocessor

Transforms domain-specific syntax into .w files for hodos.

Syntax modes (by file extension):
  .wm  — math:        let, type annotations, infix operators
  .wp  — physics:     basis, state, observable, measure
  .wl  — programming: type keywords, function calls, bracket indexing
  .we  — elements:    chemical elements as quaternion coordinates
  .wg  — logic:       Post gates (AND/OR/NOT) on balanced ternary
  .ws  — music:       pitch classes, intervals, mod-12 arithmetic
  .wd  — DNA:         bases, codons, Watson-Crick complementarity
  .wk  — lambda:      SKI combinators as trit values
  .wn  — language:    semantic primes as lattice coordinates

Usage: phos input.wm [-o output.w]
"""

import sys
import re
import os

# ── Type registry ────────────────────────────────────

TYPES = {
    'Z': (1, {'value': 0, '0': 0}),
    'C': (2, {'re': 0, 'im': 8, '0': 0, '1': 8}),
    'H': (4, {'w': 0, 'i': 8, 'j': 16, 'k': 24,
              '0': 0, '1': 8, '2': 16, '3': 24,
              'scalar': 0, 'x': 8, 'y': 16, 'z': 24}),
    'O': (8, {f'e{i}': i * 8 for i in range(8)}),
    'S': (16, {f'e{i}': i * 8 for i in range(16)}),
    'P': (32, {f'e{i}': i * 8 for i in range(32)}),
}

TYPE_KEYWORDS = {
    'scalar': 'Z', 'complex': 'C', 'quat': 'H',
    'oct': 'O', 'sedenion': 'S', 'pathion': 'P',
}

CD_MUL = {2: 'cd_mul_d2', 4: 'cd_mul_d4', 8: 'cd_mul_d8',
           16: 'cd_mul_d16', 32: 'cd_mul_d32'}

# ── Domain lookup tables ─────────────────────────────

# Physics: basis elements for ket notation
# quaternion (w, x, y, z) = (τ, χ, μ, φ)
BASIS = {
    'H': {'1': (1,0,0,0), 'i': (0,1,0,0), 'j': (0,0,1,0), 'k': (0,0,0,1),
           'e0': (1,0,0,0), 'e1': (0,1,0,0), 'e2': (0,0,1,0), 'e3': (0,0,0,1)},
    'O': {f'e{i}': tuple(1 if j == i else 0 for j in range(8)) for i in range(8)},
    'S': {f'e{i}': tuple(1 if j == i else 0 for j in range(16)) for i in range(16)},
    'P': {f'e{i}': tuple(1 if j == i else 0 for j in range(32)) for i in range(32)},
}

# Elements: 12-alpha cycle coordinates as quaternion (w,x,y,z) = (τ,χ,μ,φ)
# Each alpha adds +1 to next axis (χ→μ→φ→τ→χ...) with balanced-ternary wrap
ELEMENTS = {
    'H':  (0, 1, 0, 0),   # hydrogen-1: 1 extra proton on χ
    'He': (0, 1, 0, 0),   # helium-4: 1st alpha → χ
    'Be': (0, 1, 1, 0),   # beryllium-8: 2nd alpha → χμ (UNSTABLE)
    'C':  (0, 1, 1, 1),   # carbon-12: 3rd alpha → χμφ
    'O':  (1, 1, 1, 1),   # oxygen-16: 4th alpha → χμφτ = HYLO
    'Ne': (1,-1, 1, 1),   # neon-20: 5th alpha → wraps χ
    'Mg': (1,-1,-1, 1),   # magnesium-24: 6th alpha → wraps μ
    'Si': (1,-1,-1,-1),   # silicon-28: 7th alpha → wraps φ
    'S':  (-1,-1,-1,-1),  # sulfur-32: 8th alpha → wraps τ = META
    'Ar': (-1, 0,-1,-1),  # argon-36: 9th alpha → χ back to 0
    'Ca': (-1, 0, 0,-1),  # calcium-40: 10th alpha → μ back to 0
    'Ti': (-1, 0, 0, 0),  # titanium-44: 11th alpha (UNSTABLE)
    'Cr': (0, 0, 0, 0),   # chromium-48: 12th alpha = ORIGIN (UNSTABLE)
    'Fe': (0, 1, 0, 1),   # iron-56: cycle repeats from 1st + τ offset
    'N':  (0, 1, 1, 0),   # nitrogen-14: same as Be-8 (3α + extra proton)
}

# Music: pitch classes (mod 12)
NOTES = {
    'C': 0, 'Cs': 1, 'Db': 1, 'D': 2, 'Ds': 3, 'Eb': 3,
    'E': 4, 'F': 5, 'Fs': 6, 'Gb': 6, 'G': 7, 'Gs': 8, 'Ab': 8,
    'A': 9, 'As': 10, 'Bb': 10, 'B': 11,
}

INTERVALS = {
    'unison': 0, 'P1': 0,
    'm2': 1, 'M2': 2, 'm3': 3, 'M3': 4,
    'P4': 5, 'tritone': 6, 'TT': 6, 'A4': 6, 'd5': 6,
    'P5': 7, 'm6': 8, 'M6': 9,
    'm7': 10, 'M7': 11, 'P8': 12, 'octave': 12,
}

# DNA: bases as quaternion axis directions
# A/T complementary on χ, C/G complementary on μ
# Watson-Crick pairing = additive inverse
DNA_BASES = {
    'A': (0, 1, 0, 0),   # adenine  → +χ = i
    'T': (0,-1, 0, 0),   # thymine  → -χ = -i  (complement of A)
    'C': (0, 0, 1, 0),   # cytosine → +μ = j
    'G': (0, 0,-1, 0),   # guanine  → -μ = -j  (complement of C)
}

# Lambda: SKI combinators = trit values
# S = ↑ = +1 (creation/OR), K = ↔ = 0 (passthrough/NOT), I = ↓ = -1 (annihilation/AND)
COMBINATORS = {
    'S': 1,    # Schönfinkel substitution = ↑ = OR = max
    'K': 0,    # Schönfinkel constancy   = ↔ = NOT fixed point
    'I': -1,   # Schönfinkel identity    = ↓ = AND = min
}

# Language: 16 corners = self-operation words
# trit notation (χ,μ,φ,τ) → quaternion (w,x,y,z) = (τ,χ,μ,φ)
WORDS = {
    'BE':         (-1,-1,-1,-1),  # ↓↓↓↓ = meta = identity
    'WILL':       ( 1,-1,-1,-1),  # ↓↓↓↑ = test
    'MAY':        (-1,-1,-1, 1),  # ↓↓↑↓ = drain
    'HAVE':       (-1,-1, 1,-1),  # ↓↑↓↓ = call
    'CAN':        ( 1,-1, 1,-1),  # ↓↑↓↑ = maybe
    'FEEL':       ( 1,-1, 1, 1),  # ↓↑↑↑ = bind
    'DO':         (-1, 1,-1,-1),  # ↑↓↓↓ = read
    'SEE':        (-1, 1,-1,-1),  # ↑↓↓↓ = read (alias)
    'HEAR':       (-1, 1,-1,-1),  # ↑↓↓↓ = read (alias)
    'MUST':       ( 1, 1,-1,-1),  # ↑↓↓↑ = filter
    'KNOW':       (-1, 1, 1,-1),  # ↑↑↓↓ = fold
    'UNDERSTAND': ( 1, 1, 1,-1),  # ↑↑↓↑ = map
    'REMEMBER':   (-1, 1, 1, 1),  # ↑↑↑↓ = foldl
    'THINK':      ( 1, 1, 1, 1),  # ↑↑↑↑ = hylo = all forces forward
}

# Logic gate names → bond names
GATES = {
    'AND': 'min', 'OR': 'max', 'NOT': 'neg',
    'MIN': 'min', 'MAX': 'max', 'NEG': 'neg',
}


# ── Core engine ──────────────────────────────────────

class Phos:
    def __init__(self, filename='<stdin>'):
        self.symbols = {}
        self.next_offset = 0
        self.temp_offset = None
        self.output = []
        self.basis_type = 'H'
        self.filename = filename

    def err(self, lineno, msg):
        print(f'phos: {self.filename}:{lineno}: {msg}', file=sys.stderr)
        sys.exit(1)

    def alloc(self, name, type_name):
        dim = TYPES[type_name][0]
        offset = self.next_offset
        self.symbols[name] = (offset, dim, type_name)
        self.next_offset += dim * 8
        if self.next_offset > 65536:
            raise RuntimeError(f'scratch overflow at {name}')
        return offset

    def get_temp(self):
        if self.temp_offset is None:
            self.temp_offset = self.next_offset
            self.next_offset += 8
        return self.temp_offset

    def lookup(self, name):
        if name not in self.symbols:
            raise RuntimeError(f"undefined: '{name}'")
        return self.symbols[name]

    def comp_offset(self, name, comp):
        offset, dim, tname = self.lookup(name)
        comps = TYPES[tname][1]
        if comp not in comps:
            raise RuntimeError(f"'{tname}' has no component '{comp}'")
        return offset + comps[comp]

    def emit(self, line):
        self.output.append(line)

    def emit_swrite(self, value, offset):
        if value < 0:
            self.emit(f'neg      θ¹ρρ  {abs(value)}')
            self.emit(f'swrite64 θρ¹ρ  {offset}')
        else:
            self.emit(f'swrite64 θ¹¹ρ  {value}  {offset}')

    def emit_swrite_pipe(self, offset):
        self.emit(f'swrite64 θρ¹ρ  {offset}')

    def emit_sread(self, offset):
        self.emit(f'sread64  θ¹ρρ  {offset}')

    def emit_ssub(self, offset):
        self.emit(f'ssub64   θ¹ρρ  {offset}')

    def emit_sadd(self, offset):
        self.emit(f'sadd64   θ¹ρρ  {offset}')

    # ── high-level operations ────────────────────────

    def emit_literal(self, name, tname, values):
        dim = TYPES[tname][0]
        if len(values) != dim:
            raise RuntimeError(f"'{tname}' expects {dim} values, got {len(values)}")
        offset = self.alloc(name, tname)
        self.emit(f'; {name} : {tname} at scratch[{offset}..{offset + dim*8 - 1}]')
        for i, v in enumerate(values):
            self.emit_swrite(v, offset + i * 8)

    def emit_mul(self, rname, aname, bname):
        a_off, a_dim, a_type = self.lookup(aname)
        b_off, b_dim, _ = self.lookup(bname)
        if a_dim != b_dim:
            raise RuntimeError(f'dimension mismatch: {aname} vs {bname}')
        if a_dim not in CD_MUL:
            raise RuntimeError(f'no CD multiply for dim {a_dim}')
        r_off = self.alloc(rname, a_type)
        self.emit(f'; {rname} = {aname} * {bname}')
        self.emit(f'{CD_MUL[a_dim]} θ¹¹¹  {a_off}  {b_off}  {r_off}')

    def emit_comp_sub(self, rname, aname, bname):
        a_off, a_dim, a_type = self.lookup(aname)
        b_off, b_dim, _ = self.lookup(bname)
        if a_dim != b_dim:
            raise RuntimeError('dimension mismatch in subtraction')
        r_off = self.alloc(rname, a_type)
        temp = self.get_temp()
        self.emit(f'; {rname} = {aname} - {bname}')
        for i in range(a_dim):
            self.emit_sread(b_off + i * 8)
            self.emit_swrite_pipe(temp)
            self.emit_sread(a_off + i * 8)
            self.emit_ssub(temp)
            self.emit_swrite_pipe(r_off + i * 8)

    def emit_comp_add(self, rname, aname, bname):
        a_off, a_dim, a_type = self.lookup(aname)
        b_off, b_dim, _ = self.lookup(bname)
        if a_dim != b_dim:
            raise RuntimeError('dimension mismatch in addition')
        r_off = self.alloc(rname, a_type)
        temp = self.get_temp()
        self.emit(f'; {rname} = {aname} + {bname}')
        for i in range(a_dim):
            self.emit_sread(b_off + i * 8)
            self.emit_swrite_pipe(temp)
            self.emit_sread(a_off + i * 8)
            self.emit_sadd(temp)
            self.emit_swrite_pipe(r_off + i * 8)

    def emit_conj(self, rname, aname):
        a_off, a_dim, a_type = self.lookup(aname)
        r_off = self.alloc(rname, a_type)
        self.emit(f'; {rname} = conj({aname})')
        self.emit_sread(a_off)
        self.emit_swrite_pipe(r_off)
        for i in range(1, a_dim):
            self.emit(f'add      θ¹¹ρ  0  0')
            self.emit_ssub(a_off + i * 8)
            self.emit_swrite_pipe(r_off + i * 8)

    def emit_commutator(self, rname, aname, bname):
        tmp_ab = f'_{rname}_ab'
        tmp_ba = f'_{rname}_ba'
        self.emit_mul(tmp_ab, aname, bname)
        self.emit_mul(tmp_ba, bname, aname)
        self.emit_comp_sub(rname, tmp_ab, tmp_ba)

    def emit_return_comp(self, name, comp):
        offset = self.comp_offset(name, comp)
        self.emit(f'; return {name}.{comp}')
        self.emit_sread(offset)

    def emit_return_index(self, name, idx):
        offset, dim, tname = self.lookup(name)
        if idx < 0 or idx >= dim:
            raise RuntimeError(f'index {idx} out of range for {tname}')
        self.emit(f'; return {name}[{idx}]')
        self.emit_sread(offset + idx * 8)


# ── Parsing helpers ──────────────────────────────────

def parse_tuple(s):
    s = s.strip()
    if (s.startswith('(') and s.endswith(')')) or \
       (s.startswith('[') and s.endswith(']')):
        s = s[1:-1]
    return [int(x.strip()) for x in s.split(',')]

def parse_ket(s):
    s = s.strip()
    if s.startswith('|') and (s.endswith('>') or s.endswith('⟩')):
        return s[1:-1].strip()
    raise RuntimeError(f"expected |x⟩, got: {s}")

def parse_commutator_bracket(s):
    s = s.strip()
    if s.startswith('[') and s.endswith(']'):
        parts = s[1:-1].split(',')
        if len(parts) == 2:
            return parts[0].strip(), parts[1].strip()
    raise RuntimeError(f"expected [a, b], got: {s}")

def parse_func(s):
    m = re.match(r'(\w+)\(([^)]*)\)', s.strip())
    if m:
        return m.group(1), [a.strip() for a in m.group(2).split(',')]
    return None, None


# ── Common line handler (shared by domain parsers) ───

def try_common_line(p, line):
    """Try math-style let/return. Returns True if handled."""
    if line.startswith('let '):
        m = re.match(r'let\s+(\w+)\s*:\s*(\w+)\s*=\s*(.*)', line)
        if not m:
            return False
        name, tname, expr = m.group(1), m.group(2), m.group(3).strip()
        if tname not in TYPES:
            raise RuntimeError(f"unknown type '{tname}'")
        if expr[0] in '([':
            p.emit_literal(name, tname, parse_tuple(expr))
        elif expr.startswith('conj('):
            fn, args = parse_func(expr)
            p.emit_conj(name, args[0])
        else:
            m2 = re.match(r'(\w+)\s*([*+\-])\s*(\w+)', expr)
            if not m2:
                raise RuntimeError(f'unknown expression: {expr}')
            a, op, b = m2.group(1), m2.group(2), m2.group(3)
            if op == '*':   p.emit_mul(name, a, b)
            elif op == '-': p.emit_comp_sub(name, a, b)
            elif op == '+': p.emit_comp_add(name, a, b)
        return True

    if line.startswith('return '):
        expr = line[7:].strip()
        # handle mod: "return X mod N"
        if ' mod ' in expr:
            parts = expr.split(' mod ')
            var_expr, modulus = parts[0].strip(), int(parts[1].strip())
            _emit_return_expr(p, var_expr)
            p.emit(f'mod      θρ¹ρ  {modulus}')
        else:
            _emit_return_expr(p, expr)
        return True

    return False

def _emit_return_expr(p, expr):
    """Emit the value part of a return statement."""
    if '.' in expr:
        name, comp = expr.rsplit('.', 1)
        p.emit_return_comp(name, comp)
    elif '[' in expr:
        m = re.match(r'(\w+)\[(\d+)\]', expr)
        if m:
            p.emit_return_index(m.group(1), int(m.group(2)))
        else:
            raise RuntimeError(f'bad index: {expr}')
    else:
        # bare variable — read first component
        if expr in p.symbols:
            p.emit_return_comp(expr, '0')
        else:
            raise RuntimeError(f"undefined: '{expr}'")


# ── Math parser (.wm) ───────────────────────────────

def parse_math(p, lines):
    for lineno, raw in enumerate(lines, 1):
        line = raw.strip()
        if not line or line[0] in ';#': continue
        try:
            if not try_common_line(p, line):
                raise RuntimeError('unknown statement')
        except RuntimeError as e:
            p.err(lineno, e)


# ── Physics parser (.wp) ────────────────────────────

def parse_physics(p, lines):
    for lineno, raw in enumerate(lines, 1):
        line = raw.strip()
        if not line or line[0] in ';#': continue
        try:
            if line.startswith('basis '):
                p.basis_type = line.split()[1]
            elif line.startswith('state '):
                m = re.match(r'state\s+(\w+)\s*=\s*(.*)', line)
                if not m: raise RuntimeError('bad state')
                name, ket = m.group(1), m.group(2).strip()
                elem = parse_ket(ket)
                bt = p.basis_type
                if bt not in BASIS or elem not in BASIS[bt]:
                    raise RuntimeError(f"unknown |{elem}⟩ in {bt}")
                p.emit_literal(name, bt, list(BASIS[bt][elem]))
            elif line.startswith('observable '):
                m = re.match(r'observable\s+(\w+)\s*=\s*(.*)', line)
                if not m: raise RuntimeError('bad observable')
                name, expr = m.group(1), m.group(2).strip()
                if expr.startswith('['):
                    a, b = parse_commutator_bracket(expr)
                    p.emit_commutator(name, a, b)
                else:
                    m2 = re.match(r'(\w+)\s*\*\s*(\w+)', expr)
                    if m2: p.emit_mul(name, m2.group(1), m2.group(2))
                    else: raise RuntimeError(f'unknown observable: {expr}')
            elif line.startswith('measure '):
                expr = line[8:].strip()
                if '.' in expr:
                    name, comp = expr.rsplit('.', 1)
                    p.emit_return_comp(name, comp)
                else:
                    raise RuntimeError('measure needs .component')
            elif not try_common_line(p, line):
                raise RuntimeError('unknown statement')
        except RuntimeError as e:
            p.err(lineno, e)


# ── Programming parser (.wl) ────────────────────────

FUNC_OPS = {
    'qmul': 'mul', 'cmul': 'mul', 'omul': 'mul',
    'qsub': 'sub', 'csub': 'sub', 'osub': 'sub',
    'qadd': 'add', 'cadd': 'add', 'oadd': 'add',
    'qconj': 'conj', 'cconj': 'conj', 'oconj': 'conj',
}

def parse_programming(p, lines):
    for lineno, raw in enumerate(lines, 1):
        line = raw.strip()
        if not line or line[0] in ';#': continue
        try:
            first = line.split()[0]
            if first in TYPE_KEYWORDS:
                tname = TYPE_KEYWORDS[first]
                m = re.match(r'\w+\s+(\w+)\s*=\s*(.*)', line)
                if not m: raise RuntimeError('bad declaration')
                name, expr = m.group(1), m.group(2).strip()
                fn, args = parse_func(expr)
                if fn and fn in FUNC_OPS:
                    op = FUNC_OPS[fn]
                    if op == 'mul':   p.emit_mul(name, args[0], args[1])
                    elif op == 'sub': p.emit_comp_sub(name, args[0], args[1])
                    elif op == 'add': p.emit_comp_add(name, args[0], args[1])
                    elif op == 'conj': p.emit_conj(name, args[0])
                elif expr[0] in '([':
                    inner = expr[1:-1]
                    parts = [x.strip() for x in inner.split(',')]
                    try:
                        p.emit_literal(name, tname, [int(x) for x in parts])
                    except ValueError:
                        if len(parts) == 2:
                            p.emit_commutator(name, parts[0], parts[1])
                        else:
                            raise RuntimeError(f'bad bracket expr: {expr}')
                else:
                    raise RuntimeError(f'unknown: {expr}')
            elif not try_common_line(p, line):
                raise RuntimeError('unknown statement')
        except RuntimeError as e:
            p.err(lineno, e)


# ── Elements parser (.we) ───────────────────────────

def parse_elements(p, lines):
    for lineno, raw in enumerate(lines, 1):
        line = raw.strip()
        if not line or line[0] in ';#': continue
        try:
            if line.startswith('element '):
                name = line.split()[1]
                sym = name.capitalize() if len(name) > 2 else name
                if sym not in ELEMENTS:
                    raise RuntimeError(f"unknown element '{sym}'")
                p.emit_literal(name, 'H', list(ELEMENTS[sym]))
            elif not try_common_line(p, line):
                raise RuntimeError('unknown statement')
        except RuntimeError as e:
            p.err(lineno, e)


# ── Logic parser (.wg) ──────────────────────────────

def parse_logic(p, lines):
    for lineno, raw in enumerate(lines, 1):
        line = raw.strip()
        if not line or line[0] in ';#': continue
        try:
            tokens = line.split()
            op = tokens[0].upper()
            if op in ('AND', 'MIN'):
                p.emit(f'; AND({tokens[1]}, {tokens[2]})')
                p.emit(f'min      θ¹¹ρ  {tokens[1]}  {tokens[2]}')
            elif op in ('OR', 'MAX'):
                p.emit(f'; OR({tokens[1]}, {tokens[2]})')
                p.emit(f'max      θ¹¹ρ  {tokens[1]}  {tokens[2]}')
            elif op in ('NOT', 'NEG'):
                if len(tokens) > 1:
                    p.emit(f'; NOT({tokens[1]})')
                    p.emit(f'neg      θ¹ρρ  {tokens[1]}')
                else:
                    p.emit('; NOT(pipeline)')
                    p.emit(f'sub      θ¹ρρ  0')
            elif not try_common_line(p, line):
                raise RuntimeError('unknown statement')
        except RuntimeError as e:
            p.err(lineno, e)


# ── Music parser (.ws) ──────────────────────────────

def parse_music(p, lines):
    for lineno, raw in enumerate(lines, 1):
        line = raw.strip()
        if not line or line[0] in ';#': continue
        try:
            if line.startswith('note '):
                m = re.match(r'note\s+(\w+)\s*=\s*(\w+)', line)
                if not m: raise RuntimeError('bad note')
                name, note = m.group(1), m.group(2)
                val = NOTES.get(note, None)
                if val is None: val = int(note)
                p.emit_literal(name, 'Z', [val])
            elif line.startswith('interval '):
                m = re.match(r'interval\s+(\w+)\s*=\s*(\w+)', line)
                if not m: raise RuntimeError('bad interval')
                name, iv = m.group(1), m.group(2)
                val = INTERVALS.get(iv, None)
                if val is None: val = int(iv)
                p.emit_literal(name, 'Z', [val])
            elif not try_common_line(p, line):
                raise RuntimeError('unknown statement')
        except RuntimeError as e:
            p.err(lineno, e)


# ── DNA parser (.wd) ────────────────────────────────

def parse_dna(p, lines):
    for lineno, raw in enumerate(lines, 1):
        line = raw.strip()
        if not line or line[0] in ';#': continue
        try:
            if line.startswith('base '):
                m = re.match(r'base\s+(\w+)\s*=\s*(\w+)', line)
                if not m: raise RuntimeError('bad base')
                name, base = m.group(1), m.group(2).upper()
                if base not in DNA_BASES:
                    raise RuntimeError(f"unknown base '{base}'")
                p.emit_literal(name, 'H', list(DNA_BASES[base]))
            elif line.startswith('complement '):
                m = re.match(r'complement\s+(\w+)\s*=\s*(\w+)', line)
                if not m: raise RuntimeError('bad complement')
                name, src = m.group(1), m.group(2)
                p.emit_conj(name, src)
            elif not try_common_line(p, line):
                raise RuntimeError('unknown statement')
        except RuntimeError as e:
            p.err(lineno, e)


# ── Lambda parser (.wk) ─────────────────────────────

def parse_lambda(p, lines):
    for lineno, raw in enumerate(lines, 1):
        line = raw.strip()
        if not line or line[0] in ';#': continue
        try:
            tokens = line.split()
            if tokens[0] == 'val':
                m = re.match(r'val\s+(\w+)\s*=\s*(-?\d+)', line)
                if not m: raise RuntimeError('bad val')
                name, value = m.group(1), int(m.group(2))
                p.emit_literal(name, 'Z', [value])
            elif tokens[0] in COMBINATORS:
                comb = tokens[0]
                val = COMBINATORS[comb]
                if comb == 'I' and len(tokens) > 1:
                    # I x = x (identity)
                    p.emit(f'; I({tokens[1]}) = {tokens[1]}')
                    p.emit(f'add      θ¹¹ρ  {tokens[1]}  0')
                elif comb == 'K' and len(tokens) > 2:
                    # K x y = x (constant)
                    p.emit(f'; K({tokens[1]}, {tokens[2]}) = {tokens[1]}')
                    p.emit(f'add      θ¹¹ρ  {tokens[1]}  0')
                elif comb == 'S' and len(tokens) == 1:
                    # S value = +1
                    p.emit(f'; S = ↑ = +1')
                    p.emit(f'add      θ¹¹ρ  1  0')
                else:
                    p.emit(f'; {comb} = {val}')
                    p.emit(f'add      θ¹¹ρ  {val}  0')
            elif not try_common_line(p, line):
                raise RuntimeError('unknown statement')
        except RuntimeError as e:
            p.err(lineno, e)


# ── Language parser (.wn) ────────────────────────────

def parse_language(p, lines):
    for lineno, raw in enumerate(lines, 1):
        line = raw.strip()
        if not line or line[0] in ';#': continue
        try:
            if line.startswith('word '):
                m = re.match(r'word\s+(\w+)\s*=\s*(\w+)', line)
                if not m: raise RuntimeError('bad word')
                name, word = m.group(1), m.group(2).upper()
                if word not in WORDS:
                    raise RuntimeError(f"unknown word '{word}'")
                p.emit_literal(name, 'H', list(WORDS[word]))
            elif not try_common_line(p, line):
                raise RuntimeError('unknown statement')
        except RuntimeError as e:
            p.err(lineno, e)


# ── Main ────────────────────────────────────────────

PARSERS = {
    '.wm': parse_math,
    '.wp': parse_physics,
    '.wl': parse_programming,
    '.we': parse_elements,
    '.wg': parse_logic,
    '.ws': parse_music,
    '.wd': parse_dna,
    '.wk': parse_lambda,
    '.wn': parse_language,
}

def main():
    if len(sys.argv) < 2:
        exts = ', '.join(PARSERS.keys())
        print(f'usage: phos input.{{{exts}}} [-o output.w]', file=sys.stderr)
        sys.exit(1)

    infile = sys.argv[1]
    outfile = None
    for i in range(2, len(sys.argv) - 1):
        if sys.argv[i] == '-o':
            outfile = sys.argv[i + 1]

    ext = os.path.splitext(infile)[1]
    if ext not in PARSERS:
        print(f"phos: unknown extension '{ext}'", file=sys.stderr)
        sys.exit(1)

    with open(infile) as f:
        lines = f.readlines()

    p = Phos(infile)
    PARSERS[ext](p, lines)

    result = '\n'.join(p.output) + '\n'
    if outfile:
        with open(outfile, 'w') as f:
            f.write(result)
    else:
        sys.stdout.write(result)

    print(f'phos: {len(p.output)} lines, {p.next_offset} bytes scratch', file=sys.stderr)

if __name__ == '__main__':
    main()
