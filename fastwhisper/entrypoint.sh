#!/bin/bash
set -e

echo "FastWhisper starting..."
echo "Model: ${FW_MODEL:-openai/whisper-small}"
echo "Device: ${FW_DEVICE:-cpu}"
echo "Cache dir: ${HF_HOME:-/home/appuser/.cache/huggingface}"

# Check if cache directory exists and is writable
if [ ! -d "${HF_HOME}" ]; then
    echo "Creating HuggingFace cache directory..."
    mkdir -p "${HF_HOME}"
fi

if [ ! -w "${HF_HOME}" ]; then
    echo "ERROR: Cache directory ${HF_HOME} is not writable!"
    exit 1
fi

# Clean up any corrupted cache files (look for incomplete downloads)
echo "Checking for corrupted cache files..."
find "${HF_HOME}" -name "*.incomplete" -delete 2>/dev/null || true
find "${HF_HOME}" -name "*.lock" -delete 2>/dev/null || true

# Start uvicorn
echo "Starting uvicorn server on port 5100..."
exec uvicorn app:app --host 0.0.0.0 --port 5100 --workers 1
