# Notes for M1 Pro 16 GB

These presets are intentionally tuned for a laptop-class Apple Silicon machine with 16 GB unified memory.

## Practical assumptions

- one main coding model loaded at a time
- OpenCode and Aider are the primary local clients
- large-repo understanding matters, but not at the cost of constant swapping

## Why the profiles are split

### `m1-balanced`
Use this as the daily default when you want the safest overall experience.

### `m1-opencode`
OpenCode often benefits from a bit more room for repo context and a longer warm period.
That is why this preset uses:
- more context than the balanced preset
- a longer keep-alive
- still conservative parallelism

### `m1-aider`
Aider usually feels best when repeated edits stay fast and the model remains warm across several short cycles.
That is why this preset uses:
- moderate context instead of pushing max context
- conservative parallelism
- a long keep-alive

## Suggested order of testing

1. `m1-balanced`
2. `m1-opencode`
3. `m1-aider`
4. `m1-max-context`

If the system starts swapping heavily or feels worse rather than better, drop back one profile.
