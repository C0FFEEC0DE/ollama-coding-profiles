# Parameters used in this repo

This document explains the variables used by the wrappers in this repository and how they relate to local coding workflows.

## Runtime variables

### `OLLAMA_FLASH_ATTENTION`
Enables Flash Attention when supported.

Why it matters:
- usually lowers memory pressure at larger contexts
- often improves responsiveness on long prompts
- one of the first switches worth testing for local coding

---

### `OLLAMA_KV_CACHE_TYPE`
Controls KV-cache quantization.

Common values:
- `f16` → highest quality, highest memory use
- `q8_0` → best general balance for laptop coding
- `q4_0` → much lower memory use, but more risk of quality loss on longer contexts

Repo default:
- `q8_0`

---

### `OLLAMA_CONTEXT_LENGTH`
Global default server context length.

Why it matters:
- more room for repo state
- more room for multi-file reasoning
- more room for tool output and edit history

Trade-off:
- context and parallelism multiply memory pressure very quickly

---

### `OLLAMA_NUM_PARALLEL`
How many parallel requests one loaded runner can handle.

Useful for:
- agent loops
- editor integrations
- several local clients at once

Trade-off:
- higher values can help throughput
- on a laptop they can also push you into swap and make the system worse

---

### `OLLAMA_MAX_LOADED_MODELS`
Maximum number of models kept loaded at once.

Repo default:
- `1`

Why:
- avoids hidden memory spikes on laptops
- keeps one active coding model hot instead of several half-idling in memory

---

### `OLLAMA_KEEP_ALIVE`
How long a model stays loaded after the last request.

Why it matters:
- reduces cold starts between repeated agent actions
- improves the feel of edit-heavy loops

Typical values in this repo:
- `10m`
- `15m`
- `20m`
- `30m`

---

### `OLLAMA_NO_CLOUD`
Disables cloud-related features.

Useful for:
- local-first setups
- privacy-sensitive work
- predictable behavior when you want everything to stay local

---

### `OLLAMA_DEBUG`
Enables more verbose logging.

Useful for:
- checking whether a profile is really applied
- troubleshooting load or latency issues
- confirming what backend and runner behavior you are actually getting

## Why different profiles exist

### M1 stable
Smallest risk of memory pressure.

### M1 balanced
Best day-to-day default on a 16 GB Apple Silicon laptop.

### M1 OpenCode
Slightly more context and a longer keep-alive for repo-scanning and multi-step flows.

### M1 Aider
Biased toward faster repeated edit loops, slightly lower context than the OpenCode preset, and warm model retention.

### M1 max-context
When the job is understanding more code at once and you accept lower concurrency.

## Modelfile parameters in this repo

### `num_ctx`
Per-model context size.

### `temperature`
Lower values make code output more deterministic.

### `top_p`
Probability mass cutoff for token selection.

### `top_k`
Limits selection to the top-k candidates.

### `repeat_penalty`
Helps reduce repetitive output.

### `num_predict`
Maximum number of output tokens.

### `seed`
Used when reproducibility matters.
