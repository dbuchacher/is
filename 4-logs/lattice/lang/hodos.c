/*
 * wasm — walk assembler
 *
 *   physics:    compiles quantum state descriptions into wave packets
 *   math:       maps symbolic notation to byte representation
 *   programmer: assembles walk files into raw binary blobs
 *   english:    turns bond symbols into the bytes the walker reads
 *
 * Usage: hodos input.w [-o output.bin]
 *
 * Input format:
 *   add  θ¹¹ρ  16  0            bond  flags  arg0  arg1
 *   : label_name                label definition
 *   skip_z label_name           conditional skip
 *   # comment                   ignored
 *
 * Output: raw bytes. Same bytes NASM would produce.
 * This tool dissolves on a trit processor — hardware reads walks natively.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#define MAX_LABELS  256
#define MAX_FIXUPS  256
#define MAX_OUTPUT  65536
#define MAX_LINE    1024
#define MAX_TOKEN   128

/* ── output buffer ─────────────────────────────────────────── */

static uint8_t  out[MAX_OUTPUT];
static int      pos = 0;

static void emit8(uint8_t v)  { out[pos++] = v; }
static void emit32(uint32_t v) {
    out[pos++] = v & 0xFF;
    out[pos++] = (v >> 8) & 0xFF;
    out[pos++] = (v >> 16) & 0xFF;
    out[pos++] = (v >> 24) & 0xFF;
}
static void emit64(uint64_t v) {
    emit32(v & 0xFFFFFFFF);
    emit32(v >> 32);
}

/* ── labels ────────────────────────────────────────────────── */

static struct { char name[MAX_TOKEN]; int pos; } labels[MAX_LABELS];
static int nlabels = 0;

static struct { char name[MAX_TOKEN]; int pos; uint8_t ctrl; } fixups[MAX_FIXUPS];
static int nfixups = 0;

static int find_label(const char *name) {
    for (int i = 0; i < nlabels; i++)
        if (strcmp(labels[i].name, name) == 0)
            return labels[i].pos;
    return -1;
}

/* ── bond symbol → wave byte(s) ────────────────────────────── */

struct bond { const char *sym; uint8_t bytes[4]; int len; };

/*
 * Bond symbols, English. Each name compiles to a fixed wave byte (or
 * pair). Bit positions in a wave byte correspond to the 4 framework
 * axes in canonical order:
 *
 *   bits [7:6] = A (WHERE / POSITION / space)     force: memory
 *   bits [5:4] = B (WHAT  / SUBSTANCE / matter)   force: call
 *   bits [3:2] = C (WHICH / SIGNAL / signal)      force: loop
 *   bits [1:0] = D (WHEN  / TIME / time)          force: test
 *
 * (Per wit/mind/3-force.md — "READ on WHERE. CALL on WHAT. CYCLE on
 * WHICH. TEST on WHEN.")
 *
 * Each bond symbol maps one operation (read, write, add, and, mul...)
 * to the wave-byte encoding that fires its handler in core.asm. The
 * byte values are inherited verbatim from VoE — only the symbol names
 * are renamed. Dispatch logic is unchanged.
 */
static const struct bond bonds[] = {
    /* ── memory (A axis, force bit 0) ───────────────── */
    {"read",    {0x40},       1},                /* +A: read qword */
    {"write",   {0xC0},       1},                /* -A: write qword */
    {"read8",   {0x80, 0x03}, 2},                /* +A=+3 ext: byte read */
    {"write8",  {0x80, 0xFD}, 2},                /* -A=-3 ext: byte write */
    {"read16",  {0x80, 0x05}, 2},                /* +A=+5 ext: word read */
    {"write16", {0x80, 0xFB}, 2},                /* -A=-5 ext: word write */
    {"read32",  {0x80, 0x07}, 2},                /* +A=+7 ext: dword read */
    {"write32", {0x80, 0xF9}, 2},                /* -A=-7 ext: dword write */

    /* ── call (B axis, force bit 1) ─────────────────── */
    {"call",    {0x10},       1},                /* +B: recursive walk call */
    {"return",  {0x30},       1},                /* -B: curry (return arg0) */

    /* ── loop (C axis, force bit 2) ─────────────────── */
    {"inc",     {0x0C},       1},                /* -C: increment (arg0+1) */
    {"fill32",  {0xC8, 0xFD}, 2},                /* -A -C ext: dword rep stos */

    /* ── test (D axis, force bit 3) + gate variants ── */
    {"test",    {0x01},       1},                /* +D=+1: equality (==) */
    {"guard",   {0x03},       1},                /* -D=-1: cmov on arg1 */
    {"and",     {0x02, 0x03}, 2},                /* +D=+3 ext: bitwise AND */
    {"or",      {0x02, 0xFD}, 2},                /* -D=-3 ext: bitwise OR */
    {"xor",     {0x02, 0x05}, 2},                /* +D=+5 ext: bitwise XOR */
    {"not",     {0x02, 0xFB}, 2},                /* -D=-5 ext: bitwise NOT */
    {"shl",     {0x02, 0x07}, 2},                /* +D=+7 ext: shift left */
    {"shr",     {0x02, 0xF9}, 2},                /* -D=-7 ext: shift right */
    {"mod",     {0x02, 0x09}, 2},                /* +D=+9 ext: remainder (a%b) */
    {"div",     {0x02, 0xF7}, 2},                /* -D=-9 ext: quotient (a/b) */
    {"lt",      {0x02, 0x0B}, 2},                /* +D=+11 ext: less-than */
    {"gt",      {0x02, 0xF5}, 2},                /* -D=-11 ext: greater-than */
    {"neg",     {0x02, 0x0D}, 2},                /* +D=+13 ext: negate */
    {"abs",     {0x02, 0xF3}, 2},                /* -D=-13 ext: absolute value */
    {"sread32", {0x02, 0x0F}, 2},                /* +D=+15 ext: read u32 from walk_scratch[offset] */
    {"swrite32",{0x02, 0xF1}, 2},                /* -D=-15 ext: write u32 to walk_scratch[offset] */
    {"sadd32",  {0x02, 0x11}, 2},                /* +D=+17 ext: pipeline += walk_scratch[offset] */
    {"ssub32",  {0x02, 0xEF}, 2},                /* -D=-17 ext: pipeline -= walk_scratch[offset] */
    {"smod32",  {0x02, 0x13}, 2},                /* +D=+19 ext: pipeline = pipeline mod walk_scratch[offset] */
    {"sread64", {0x02, 0x15}, 2},                /* +D=+21 ext: read qword from walk_scratch[offset] */
    {"swrite64",{0x02, 0xEB}, 2},                /* -D=-21 ext: write qword to walk_scratch[offset] */
    {"sadd64",  {0x02, 0x17}, 2},                /* +D=+23 ext: pipeline += walk_scratch qword */
    {"ssub64",  {0x02, 0xE9}, 2},                /* -D=-23 ext: pipeline -= walk_scratch qword */
    {"cd_mul_d2",{0x02, 0x19}, 2},               /* +D=+25 ext: CD base case (scalar complex multiply) */
    {"smod64",  {0x02, 0x23}, 2},                /* +D=+35 ext: pipeline = pipeline mod walk_scratch qword */
    {"sdiv64",  {0x02, 0xDD}, 2},                /* -D=-35 ext: pipeline = pipeline / walk_scratch qword */
    {"gcd64",   {0x02, 0x25}, 2},                /* +D=+37 ext: gcd(scratch[off_a], scratch[off_b]) → pipeline */
    {"siadd64", {0x02, 0x27}, 2},                /* +D=+39 ext: scratch[pipeline_offset] += delta (indirect) */
    {"is_prime_bit",{0x02, 0x29}, 2},            /* +D=+41 ext: primality lookup via C-side bit sieve */
    {"shell_phase1_c",{0x02, 0x2B}, 2},          /* +D=+43 ext: parallel phase 1 via C OpenMP */
    {"cd_mul_d4", {0x02, 0x2D}, 2},              /* +D=+45: quaternion multiply (walker-native) */
    {"cd_mul_d8", {0x02, 0x2F}, 2},              /* +D=+47: octonion multiply (walker-native) */
    {"cd_mul_d16",{0x02, 0x31}, 2},              /* +D=+49: sedenion multiply (walker-native) */
    {"cd_mul_d32",{0x02, 0x33}, 2},              /* +D=+51: pathion multiply (walker-native) */

    /* ── memory+test combinations (A and D both odd) ── */
    {"min",     {0x41},       1},                /* +A +D: min(arg0, arg1) */
    {"max",     {0x42, 0x03}, 2},                /* +A +D=+3 ext: max */
    {"add",     {0xC3},       1},                /* -A -D: arg0 + arg1 */
    {"sub",     {0xC2, 0xFD}, 2},                /* -A -D=-3 ext: arg0 - arg1 */

    /* ── compound ops (multiple axes odd) ───────────── */
    {"fold",    {0x50},       1},                /* A+B odd: fold (read + call) */
    {"fix",     {0x14},       1},                /* B+C odd: fix (call N times) */
    {"foldl",   {0x54},       1},                /* A+B+C odd: foldl over array */
    {"maybe",   {0x11},       1},                /* B+D odd: conditional call */
    {"map",     {0x51},       1},                /* A+B+D odd: map over array */
    {"until",   {0x05},       1},                /* C+D odd: scan to zero */
    {"scan",    {0x45},       1},                /* A+C+D odd: accumulate */
    {"bind",    {0x15},       1},                /* B+C+D odd: event loop */
    {"hylo",    {0x55},       1},                /* A+B+C+D all odd: full pipeline */

    /* ── atom: all coords even, evaluates Aᵃ·Bᵇ·Cᶜ·Dᵈ ─ */
    {"mul",     {0xA0, 0x02, 0x02}, 3},          /* A=+2, B=+2 ext: arg0·arg1 */

    {NULL, {0}, 0}
};

/* ── θ constants ──────────────────────────────────────────── */

struct theta { const char *sym; uint8_t val; int shells[3]; };

static const struct theta thetas[] = {
    {"θρρρ",   0x00, {0,0,0}},
    {"θ¹ρρ",   0x01, {1,0,0}},
    {"θ¹¹ρ",   0x05, {1,1,0}},
    {"θ¹¹¹",   0x15, {1,1,1}},
    {"θ²ρρ",   0x02, {2,0,0}},
    {"θ²¹ρ",   0x06, {2,1,0}},
    {"θ¹²ρ",   0x09, {1,2,0}},
    {"θ²²ρ",   0x0A, {2,2,0}},
    {"θ²²²",   0x2A, {2,2,2}},
    {"θ²³ρ",   0x0E, {2,3,0}},
    {"θ³ρρ",   0x03, {3,0,0}},
    {"θ³²ρ",   0x0B, {3,2,0}},
    {"θ³³ρ",   0x0F, {3,3,0}},
    {"θρ¹ρ",   0x04, {0,1,0}},
    {"θρ²ρ",   0x08, {0,2,0}},
    {"θρ²²",   0x28, {0,2,2}},
    {"θρ³ρ",   0x0C, {0,3,0}},
    {"θ²ρρ·",  0x82, {2,0,0}},  /* deref arg0 */
    {"θρ²ρ·",  0x48, {0,2,0}},  /* deref arg1 */
    {"θ³ρρ·",  0x83, {3,0,0}},  /* deref arg0 (u64) */
    {NULL, 0, {0,0,0}}
};

/* shell → byte count: 0=0, 1=1, 2=4, 3=8 */
static const int shell_bytes[] = {0, 1, 4, 8};

/* ── tokenizer ─────────────────────────────────────────────── */

static char *tokens[64];
static int  ntokens;

static void tokenize(char *line) {
    ntokens = 0;
    char *p = line;
    while (*p) {
        while (*p == ' ' || *p == '\t') p++;
        if (!*p || *p == ';' || *p == '\n') break;
        tokens[ntokens] = p;
        if (*p == '\'') {
            /* character literal */
            p++;
            tokens[ntokens] = p; /* point past quote */
            while (*p && *p != '\'') p++;
            if (*p) *p++ = 0;
        } else {
            while (*p && *p != ' ' && *p != '\t' && *p != '\n') p++;
            if (*p) *p++ = 0;
        }
        ntokens++;
    }
}

/* ── parse a value (hex, decimal, char) ──────────────────── */

static uint64_t parse_val(const char *s) {
    if (s[0] == '0' && s[1] == 'x')
        return strtoull(s, NULL, 16);
    if (s[0] == '-')
        return (uint64_t)(int64_t)strtoll(s, NULL, 10);
    return strtoull(s, NULL, 10);
}

/* ── assemble one line ─────────────────────────────────────── */

static void assemble_line(void) {
    if (ntokens == 0) return;
    int t = 0;

    /* label definition */
    if (strcmp(tokens[t], ":") == 0) {
        t++;
        if (t < ntokens) {
            strcpy(labels[nlabels].name, tokens[t]);
            labels[nlabels].pos = pos;
            nlabels++;
        }
        return;
    }

    /* walker control */
    if (strcmp(tokens[t], "skip_z") == 0 || strcmp(tokens[t], "skip_nz") == 0 ||
        strcmp(tokens[t], "loop_back") == 0) {
        uint8_t ctrl = 0xFE;
        if (strcmp(tokens[t], "skip_nz") == 0) ctrl = 0xFD;
        if (strcmp(tokens[t], "loop_back") == 0) ctrl = 0xFC;
        t++;
        emit8(ctrl);
        /* save fixup — resolve label on pass 2 */
        strcpy(fixups[nfixups].name, tokens[t]);
        fixups[nfixups].pos = pos;
        fixups[nfixups].ctrl = ctrl;
        nfixups++;
        emit32(0); /* placeholder */
        return;
    }

    /* bond symbol */
    for (const struct bond *b = bonds; b->sym; b++) {
        if (strcmp(tokens[t], b->sym) == 0) {
            for (int i = 0; i < b->len; i++)
                emit8(b->bytes[i]);
            t++;
            break;
        }
    }

    /* θ constant + args */
    if (t < ntokens) {
        for (const struct theta *th = thetas; th->sym; th++) {
            if (strcmp(tokens[t], th->sym) == 0) {
                emit8(th->val);
                t++;
                /* emit args based on shell levels */
                for (int a = 0; a < 3 && t < ntokens; a++) {
                    int sz = shell_bytes[th->shells[a]];
                    if (sz == 0) continue; /* pipeline — no bytes */
                    uint64_t v = parse_val(tokens[t]);
                    t++;
                    if (sz == 1) emit8(v);
                    else if (sz == 4) emit32(v);
                    else emit64(v);
                }
                break;
            }
        }
    }
}

/* ── resolve fixups ────────────────────────────────────────── */

static int resolve_fixups(void) {
    for (int i = 0; i < nfixups; i++) {
        int target = find_label(fixups[i].name);
        if (target < 0) {
            fprintf(stderr, "hodos: undefined label '%s'\n", fixups[i].name);
            return 1;
        }
        /* offset = target - (fixup_pos + 4) for skip_z/skip_nz
           offset = (fixup_pos + 4) - target for loop_back */
        int ref = fixups[i].pos + 4; /* past the u32 */
        int offset;
        if (fixups[i].ctrl == 0xFC) /* loop_back */
            offset = ref - target;
        else /* skip_z, skip_nz */
            offset = target - ref;
        uint32_t u = (uint32_t)offset;
        out[fixups[i].pos]     = u & 0xFF;
        out[fixups[i].pos + 1] = (u >> 8) & 0xFF;
        out[fixups[i].pos + 2] = (u >> 16) & 0xFF;
        out[fixups[i].pos + 3] = (u >> 24) & 0xFF;
    }
    return 0;
}

/* ── process file (recursive for @include) ────────────────── */

static int include_depth = 0;

static int process_file(const char *path) {
    if (include_depth > 8) {
        fprintf(stderr, "hodos: include depth > 8: %s\n", path);
        return 1;
    }

    FILE *f = fopen(path, "r");
    if (!f) { perror(path); return 1; }

    /* resolve directory of this file for relative includes */
    char dir[MAX_LINE] = ".";
    const char *slash = strrchr(path, '/');
    if (slash) {
        int dlen = (int)(slash - path);
        if (dlen >= MAX_LINE) dlen = MAX_LINE - 1;
        memcpy(dir, path, dlen);
        dir[dlen] = '\0';
    }

    char line[MAX_LINE];
    while (fgets(line, sizeof(line), f)) {
        tokenize(line);
        if (ntokens >= 2 && strcmp(tokens[0], "@include") == 0) {
            char inc_path[MAX_LINE];
            if (tokens[1][0] == '/')
                snprintf(inc_path, sizeof(inc_path), "%s", tokens[1]);
            else
                snprintf(inc_path, sizeof(inc_path), "%s/%s", dir, tokens[1]);
            include_depth++;
            int err = process_file(inc_path);
            include_depth--;
            if (err) { fclose(f); return err; }
            continue;
        }
        assemble_line();
    }
    fclose(f);
    return 0;
}

/* ── main ──────────────────────────────────────────────────── */

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "usage: hodos input.w [-o output.bin]\n");
        return 1;
    }

    const char *infile = argv[1];
    const char *outfile = "a.out.w";
    for (int i = 2; i < argc - 1; i++)
        if (strcmp(argv[i], "-o") == 0)
            outfile = argv[i + 1];

    if (process_file(infile)) return 1;

    if (resolve_fixups()) return 1;

    FILE *out_f = fopen(outfile, "wb");
    if (!out_f) { perror(outfile); return 1; }
    fwrite(out, 1, pos, out_f);
    fclose(out_f);

    fprintf(stderr, "hodos: %d bytes\n", pos);
    return 0;
}
