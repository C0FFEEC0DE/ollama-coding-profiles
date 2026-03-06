# ollama-coding-profiles

Cross-platform Ollama launch profiles and coding-focused `Modelfile`s for **macOS** and **Linux**, tuned especially for **Apple Silicon laptops** and local agent workflows like **OpenCode** and **Aider**.

This repo is built for people who want to:

- start `ollama serve` with repeatable profiles instead of retyping env vars
- keep separate presets for **stable**, **daily coding**, **OpenCode**, **Aider**, and **max-context** use-cases
- version control recommended `Modelfile`s for programming workloads
- use the same wrappers on both macOS and Linux

## What is inside

```text
.
├── README.md
├── .gitignore
├── bin/
│   ├── ollama-profile
│   ├── ollama-profile-m1-stable.sh
│   ├── ollama-profile-m1-balanced.sh
│   ├── ollama-profile-m1-opencode.sh
│   ├── ollama-profile-m1-aider.sh
│   ├── ollama-profile-m1-max-context.sh
│   ├── ollama-profile-private.sh
│   └── ollama-profile-debug.sh
├── docs/
│   ├── parameters.md
│   └── m1-pro-16gb-notes.md
└── modelfiles/
    ├── qwen2.5-coder-7b-m1-balanced.Modelfile
    ├── qwen2.5-coder-7b-m1-opencode.Modelfile
    ├── qwen2.5-coder-7b-m1-aider.Modelfile
    ├── qwen2.5-coder-7b-m1-max-context.Modelfile
    ├── deepseek-coder-6.7b-m1-balanced.Modelfile
    ├── deepseek-coder-6.7b-m1-aider.Modelfile
    ├── glm4-9b-m1-balanced.Modelfile
    └── gemma3-12b-m1-careful.Modelfile
```

## Quick start

### 1) Make scripts executable

```bash
chmod +x bin/*.sh bin/ollama-profile
```

### 2) Run a profile directly

```bash
./bin/ollama-profile-m1-balanced.sh
```

### 3) Or use the generic launcher

```bash
./bin/ollama-profile m1-stable
./bin/ollama-profile m1-balanced
./bin/ollama-profile m1-opencode
./bin/ollama-profile m1-aider
./bin/ollama-profile m1-max-context
./bin/ollama-profile private
./bin/ollama-profile debug
```

## Profiles

### `m1-stable`
Safest preset for **M1 Pro 16 GB** when you care more about predictability than throughput.

### `m1-balanced`
Best daily default for local coding on **M1 Pro 16 GB**.

### `m1-opencode`
More aggressive preset for **OpenCode** style workflows where the tool may inspect more of the repo and keep slightly more context around.

### `m1-aider`
More aggressive preset for **Aider** style edit loops where you want fast repeated edits and quick follow-up requests.

### `m1-max-context`
Prioritizes context length over concurrency. Best when repo understanding matters more than throughput.

### `private`
Balanced preset plus cloud-disabled behavior.

### `debug`
Balanced preset with extra logs enabled.

## Recommended starting point on M1 Pro 16 GB

For most sessions:

```bash
./bin/ollama-profile m1-balanced
```

For OpenCode:

```bash
./bin/ollama-profile m1-opencode
```

For Aider:

```bash
./bin/ollama-profile m1-aider
```

## Build example models

```bash
ollama create qwen-coder-m1-balanced -f modelfiles/qwen2.5-coder-7b-m1-balanced.Modelfile
ollama create qwen-coder-m1-opencode -f modelfiles/qwen2.5-coder-7b-m1-opencode.Modelfile
ollama create qwen-coder-m1-aider -f modelfiles/qwen2.5-coder-7b-m1-aider.Modelfile
```

## Design choices

These presets are intentionally opinionated:

- `q8_0` KV cache is used as the default balance between memory and quality
- `MAX_LOADED_MODELS=1` avoids hidden memory spikes on laptops
- `NUM_PARALLEL` is kept conservative because raising it together with context can quickly destabilize a 16 GB machine
- `KEEP_ALIVE` stays long enough to make repeated agent calls feel fast without pinning everything forever

## Notes on compatibility

The wrappers are plain shell scripts and should work on both **macOS** and **Linux** as long as:

- `bash` is available
- `ollama` is on `PATH`

They only apply settings to the current `ollama serve` process.
They do not edit your shell profile or any system-wide launch settings.
