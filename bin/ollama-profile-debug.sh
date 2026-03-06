#!/usr/bin/env bash
set -euo pipefail

export OLLAMA_FLASH_ATTENTION=1
export OLLAMA_KV_CACHE_TYPE=q8_0
export OLLAMA_CONTEXT_LENGTH=16384
export OLLAMA_NUM_PARALLEL=2
export OLLAMA_MAX_LOADED_MODELS=1
export OLLAMA_KEEP_ALIVE=15m
export OLLAMA_DEBUG=1

exec ollama serve
