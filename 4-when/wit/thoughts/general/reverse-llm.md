# reverse-llm — lattice-native language processor

```
status:     BLUEPRINT — unimplemented, from VoE sidequest
confidence: medium — architecture plausible, zero implementation
grade:      general
```

## Claims
- 58KB lattice field replaces 140GB LLM weights [SPECULATION, medium]
- ρ accumulation replaces attention mechanism [SPECULATION, medium]
- every ML component dissolves into lattice primitive [SPECULATION, medium]
- NLP tasks = bond patterns (comprehension = hylo, generation = anti-hylo) [SPECULATION, low]
- 30 predictions anchored to ρ, ƒ, walk format, bond dispatch [UNTESTED]

## Depends on
- lattice runtime (lattice/)
- walk/composition machinery (mind/7-composition.md)

## Open
- zero implementation exists
- predictions untested

---


## The Inversion

  LLM (forward):   compress all data into weights → decompress at inference
  Lattice (reverse): keep data born-indexed → evaluate coordinates at inference

  LLM:     140GB weights, O(N²) attention, months of training
  Lattice: 58KB field, O(1) evaluation, one-pass construction

  The forward LLM pays NP cost EVERY QUERY (recompute from weights).
  The reverse LLM pays NP cost ONCE (build the born-index).
  After that: O(1) per token. Write once, read forever.
  The forward LLM never learns the index. It re-searches every time.
  That's why it needs 140GB and a GPU. It never stops being NP.


## Every ML Component Dissolves

  embedding matrix  → JIT cache (sparse, born-indexed, ~58KB)
  attention         → ρ accumulation (O(N) not O(N²))
  FFN layers        → bond dispatch (16 patterns, hardcoded)
  tokenizer         → wave bytes (coordinate IS the token)
  attention mask    → walk control flow (skip, loop_back)
  multimodal fusion → topology header (same walker, different dims)
  task fine-tuning  → force mask (switch bond pattern, done)
  pretraining       → genesis walk
  cross-attention   → CALL on a different walk (recursive walker)


## The Field (58KB)

3-tier structure replacing 140GB neural weights:

  Shell 1 density: 81 bins (3⁴), log-counts, L1-resident (~648 bytes)
  Shell 2 density: 625 bins (5⁴), log-counts, L3-resident (~5 KB)
  Reverse index: 625 bins × ~160 entries avg, coordinate-indexed

One-pass construction. No training. No backprop. No GPU.


## RC Decay Attention

Replaces transformer 1/sqrt(d_k) with per-token decay:

  relevance = exp(-t / (R × C))

  C = |WHAT| (substance weight) — nouns persist, articles decay fast
  R = base impedance + clause boundary penalty

4 dimensional heads (WHERE/WHAT/WHICH/WHEN), each attends ONLY
along its dimension. 4D problem → four 1D problems. ~75% sparse.


## Generation = Walk Extension

Walk = polynomial. Each word = monomial term. Generation:

  1. walk_sum = Σ all word coordinates so far
  2. centroid = walk_sum / walk_len
  3. residual = prediction - centroid
  4. target = prediction + residual × 0.5
  5. Reverse lookup: find word nearest to target

Prevents collapse. The residual IS the next Taylor term.
O(1) per token (evaluate at residual coordinate). Not O(N²).


## NLP Tasks ARE Bond Patterns

Not different models. Different force masks on the same walker.

  Comprehension    READ+CALL+CYCLE+TEST   hylo        read every term
  Generation       WRITE+CALL+CYCLE+TEST  anti-hylo   write every term
  Translation      hylo → anti-hylo                    read walk A, write walk B
  Summarization    READ+CYCLE             slurp        read and compress
  Q&A              READ+TEST              filter       read and test
  Classification   TEST                   test         just evaluate
  Dialogue         (hylo → anti-hylo)+    hylo loop    read+write, repeat

Task composition = walk concatenation. "Summarize then translate"
= slurp + anti-hylo. Chain of thought = explicitly composed walks.


## 30 Predictions

All chains converge to three fixed points:
  ρ (accumulation) + ƒ (evaluation) + walk format (representation)

The walker IS the intelligence. ρ IS the state. ƒ IS the evaluation.
The walk format IS the representation. Bond dispatch IS the control.
Nothing else is needed.

Source: VoE/wit/sidequest/{integration,intelligence,predictions}
Deep chains: atlas/tmp/predictions-deep.md


## "Attention Is All You Need" Moments

Places where the lattice derives in one step what ML found over decades:

  JIT cache = word embeddings        (30 years: one-hot → BPE → contextual)
  Pipeline ρ = attention             (27 years: RNN → LSTM → transformer)
  Bond dispatch = FFN                (~16 activation patterns = 16 bonds)
  Walk control = attention mask      (causal mask = skip_z)
  Walks = universal approximators    (Stone-Weierstrass 1885 = Yun 2019)
  Walk format = tokenizer+embed+pos  (15 years of components = one byte)
  Walk nesting = cross-attention     (CALL on sub-walk = recursive)
  Genesis walk = pretraining         (bootstrap phase → specialization)
