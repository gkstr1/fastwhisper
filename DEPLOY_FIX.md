# FastWhisper Deployment Fix

## Problem Summary
- Container in restart loop due to corrupted HuggingFace model cache
- Missing volume mount for persistent cache storage
- No retry logic for model loading failures

## Changes Made

### 1. Updated Dockerfile
- Added HuggingFace cache directory with proper permissions
- Added `HF_HOME` environment variable
- Created entrypoint script for cache validation and cleanup

### 2. Created entrypoint.sh
- Validates cache directory exists and is writable
- Cleans up corrupted/incomplete cache files on startup
- Provides better logging for troubleshooting

### 3. Updated app.py
- Added retry logic (3 attempts) for model loading
- Automatic cleanup of corrupted cache files between retries
- Better error logging and diagnostics

### 4. Updated docker-compose.yml
- Added named volume `fastwhisper_hf_cache` for persistent storage
- Proper volume mount to `/home/appuser/.cache/huggingface`
- Added `HF_HOME` environment variable

## Deployment Steps on VPS

### Step 1: Stop and Remove Current Container
```bash
cd /root/docker/openclaw-1gzv
docker compose down fastwhisper
docker rm -f fastwhisper 2>/dev/null || true
```

### Step 2: Remove Corrupted Cache Volume
```bash
# List volumes to confirm it exists
docker volume ls | grep fastwhisper

# Remove the corrupted cache volume
docker volume rm openclaw-1gzv_fastwhisper_hf_cache 2>/dev/null || true
docker volume rm fastwhisper_hf_cache 2>/dev/null || true
```

### Step 3: Pull Latest Code from GitHub
```bash
cd /root/docker/openclaw-1gzv

# Backup current fastwhisper directory
mv fastwhisper fastwhisper.backup.$(date +%s) 2>/dev/null || true

# Download latest from GitHub
curl -L https://github.com/gkstr1/fastwhisper/archive/refs/heads/main.zip -o fastwhisper.zip
unzip -o fastwhisper.zip
mv fastwhisper-main fastwhisper
rm fastwhisper.zip

# Copy docker-compose.yml to project root if needed
cp fastwhisper/docker-compose.yml ./docker-compose.yml
```

### Step 4: Rebuild and Start Container
```bash
cd /root/docker/openclaw-1gzv

# Rebuild the image with new fixes
docker compose build --no-cache fastwhisper

# Start the container
docker compose up -d fastwhisper
```

### Step 5: Monitor Startup
```bash
# Watch logs in real-time
docker logs -f fastwhisper

# You should see:
# - "FastWhisper starting..."
# - "Loading model openai/whisper-small..."
# - Model download progress (first time only)
# - "Model openai/whisper-small loaded successfully!"
# - "Starting uvicorn server on port 5100..."
```

### Step 6: Test the Service
```bash
# Check if container is running
docker ps | grep fastwhisper

# Test the health endpoint
curl http://localhost:5100/

# Expected response:
# {"status":"ok","model":"openai/whisper-small","device":"cpu"}
```

## Troubleshooting

### If container still crashes:
```bash
# Check detailed logs
docker logs fastwhisper --tail 100

# Check cache directory permissions inside container
docker exec fastwhisper ls -la /home/appuser/.cache/huggingface

# Manually clear cache and restart
docker compose down fastwhisper
docker volume rm fastwhisper_hf_cache
docker compose up -d fastwhisper
```

### If model download is slow:
- First download takes 5-10 minutes for `whisper-small` (~500MB)
- Check download progress in logs
- Volume persists the model, so subsequent starts are instant

### If you need to switch models:
```bash
# Edit docker-compose.yml and change FW_MODEL
# Options: openai/whisper-tiny, small, medium, large-v3
nano docker-compose.yml

# Rebuild and restart
docker compose down fastwhisper
docker compose up -d fastwhisper
```

## Expected Behavior After Fix

1. **First Start**: Downloads model (~5-10 min), then starts server
2. **Subsequent Starts**: Loads cached model instantly (<30 seconds)
3. **Retry Logic**: If cache corrupted, auto-cleans and retries 3 times
4. **Persistence**: Model cached in Docker volume, survives container restarts

## Resource Usage

- **CPU**: ~10-20% idle, 80-100% during transcription
- **Memory**: ~1.5GB for small model
- **Disk**: ~500MB for model cache
- **Port**: 5100 (mapped to host)
