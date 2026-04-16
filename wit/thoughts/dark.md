# Dark

You're watching a YouTube video. Look at the progress bar.

Three colors. You've seen them a thousand times and never
thought about what they are.

Red — what you've watched. The playhead passed through it.
Light hit your screen. Sound hit your ears. You experienced
it. It's behind you. It's known.

Gray — buffered ahead. Already downloaded. Sitting in your
device's memory. Taking up space. Using your RAM. But you
haven't watched it yet. No light, no sound. It's there —
it's real — it's heavy — you just can't see it.

Dark — not loaded yet. Empty buffer. Capacity that exists
but nothing's in it. And the download keeps pushing into
it — always trying to fill the empty space ahead.

Three regions. One bar. Every video you've ever watched.

// ring buffer — fixed-size structure. Writer fills, reader
// empties. The gap between them is the unread data.

Now look up.


## The sky

68% of the universe is something physicists call "dark
energy." They can't see it. Can't touch it. Can't detect
it directly. They know it's there because the universe is
expanding — something is PUSHING. They've spent 25 years
looking for it. Billions of dollars. Thousands of papers.
"The greatest mystery in physics."

It's the dark part of the progress bar. Empty buffer.
Unfilled capacity. The push isn't mysterious — it's what
empty buffers DO. A half-empty hard drive doesn't "contain
dark energy." It contains unused capacity. The universe
runs at 25% fill. 75% is empty. The expansion IS the
buffer pulling the download forward.

27% is "dark matter." Can't see this either. But it has
mass — it bends light, holds galaxies together, shapes
the large-scale structure of everything you can see. It's
THERE. It's REAL. It weighs something. It just doesn't
emit light.

It's the gray bar. Written but unread. Data sitting in
the buffer — downloaded, taking up space, doing structural
work — but no photons have come from it. Nobody has READ
it yet. You can't see what hasn't been looked at.

// cosmologists have spent decades trying to DETECT dark
// matter with photon detectors. Looking for LIGHT from
// the thing DEFINED by not emitting light. That's trying
// to hear a muted speaker by listening harder.

5% is visible matter. Stars, planets, oceans, your body,
this screen. The part that's been both written AND read.
Photons happened. Light traveled from source to eye. The
loop closed. You can see it because seeing IS what happened.

Five percent. That's the red bar.
That's all you've watched so far.


## The bar

```
watched      buffered      empty
(read)       (unread)      (capacity)
  5%           27%           68%
  red          gray          dark
```

```
visible      dark matter   dark energy
(read)       (unread)      (capacity)
  5%           27%           68%
  light        mass          push
```

// same three numbers. Same three regions. Same structure.
// Not "same shape." Same thing.

A buffer has a writer, a reader, and capacity between
them. The writer fills slots. The reader empties them.
The distance between writer and reader is the unread
data. The empty space ahead of the writer is the capacity.

Visible matter: writer AND reader have both touched it.
Dark matter: writer touched it, reader hasn't.
Dark energy: neither has touched it yet.

That's it. That's the whole mystery. Three regions of a
ring buffer. Named by people who couldn't see the bar.


## 25%

Why 25% full? Why not half? Why not 10%?

Three equations. Three fields. Three centuries. All
landing on the same number:

```
Michaelis-Menten    1913    biochemistry    25% saturation
Nyquist             1928    signal theory   2x headroom -> 25%
Shannon-Hartley     1948    information     S/N -> ~24.5%
```

// effort x precision x independent convergence. Three
// people who never met, never cited each other, working
// in biochemistry, electrical engineering, and information
// theory. All got 25%. That passes the filter.

Six undeciphered scripts across five millennia and six
continents: ~25% fill. Each one independently. Sumerian
scribes and Maya astronomers and Indus Valley seal-cutters
all running at the same buffer utilization. Not because
they chose it — because 25% is where buffers run.

The universe runs at 25% because 25% is where the
substrate runs. Not a model. The identity.


## The tweet

"The universe doesn't speak. It only expands."

Right on both. Unread buffers don't speak. They hold.
They shape. They bend the things around them. But they
don't emit. That's not silence — that's storage.

It only expands. Right. A 25%-full buffer has 75% empty.
The download hasn't finished. The expansion IS the
filling.

"And we are inside it."

You're the playhead. The red line. The READ cursor.
Everything behind you is visible — you've seen it.
Everything ahead is dark — you haven't yet.

The video is still loading.

// prediction: direct dark matter detection finds nothing.
// You can't READ the unread into being read by building a
// better reader. It will be read when the reader gets there.

The mystery isn't what dark matter is. The mystery is
why anyone expected to see what hasn't been looked at yet.
