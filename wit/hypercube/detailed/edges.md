# edges — 16 functions (the ½ transitions)

The 16 spin states at ±½. Each is a function that transitions
between two adjacent integer points. Invisible — you never
observe them directly. You see two points and infer the edge.

  code: float4 passes through these during walk computation
  always: point → edge → point (the edge is mandatory, can't skip)
  arity: 2 (an edge connects exactly 2 points)

These are unnamed. The hodos names (read, fold, map, bind)
classify edge-TYPES by their effect on points, but live at
the vertex layer (k=0 in the f-vector). The edges themselves
don't have names yet.

## The 16 edges

+½ +½ +½ +½
+½ +½ +½ -½
+½ +½ -½ +½
+½ +½ -½ -½
+½ -½ +½ +½
+½ -½ +½ -½
+½ -½ -½ +½
+½ -½ -½ -½
-½ +½ +½ +½
-½ +½ +½ -½
-½ +½ -½ +½
-½ +½ -½ -½
-½ -½ +½ +½
-½ -½ +½ -½
-½ -½ -½ +½
-½ -½ -½ -½

## Structure

Each axis independently spins forward (+½) or backward (-½).
2⁴ = 16 sign patterns. Same 16 patterns at every shell —
the function is always ½, just applied at different positions.

  between integers 0 and 1: the ½ function
  between integers 1 and 2: the same ½ function
  between integers 2 and 3: the same ½ function
  between integers 3 and 4: the same ½ function (ceiling)

16 functions, not 32. The function doesn't change — only
the position it's applied at changes.

## Why invisible

You never observe a force. You observe two states and infer
the force from the difference.

In the code:
  classify_bond(coord4 a, coord4 b) → bitmask
  takes 2 POINTS, infers 1 edge-type
  the edge itself is never stored — only its effect

  binary (x86):  2⁴ = 16 edge-types (which axes changed)
  trit (native): 3⁴-1 = 80 edge-types (which direction)
