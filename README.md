# FastWhisper (CPU) — Docker Deployment

FastAPI + Faster-Whisper transcription service optimized for Hostinger VPS Docker deployment.

## Files

- `fastwhisper/Dockerfile` — Python 3.11 slim with Faster-Whisper + FFmpeg
- `fastwhisper/app.py` — FastAPI wrapper exposing `/transcribe` endpoint
- `docker-compose.yml` — Full compose configuration

## Quick Usage

1. **Clone to Hostinger VPS:**
   ```bash
   cd ~/docker
   git clone https://github.com/YOUR_USERNAME/fastwhisper-deploy.git
   cd fastwhisper-deploy
   ```

2. **Build and deploy:**
   ```bash
   docker compose build fastwhisper
   docker compose up -d fastwhisper
   ```

3. **Test locally:**
   ```bash
   curl -X POST "http://localhost:5100/transcribe" -F "file=@/path/to/test.ogg"
   ```

4. **Test from another container in the same compose network:**
   ```bash
   curl -X POST "http://fastwhisper:5100/transcribe" -F "file=@/path/to/test.ogg"
   ```

## Configuration

| Environment Variable | Description | Default |
|---------------------|-------------|---------|
| `FW_MODEL` | Whisper model name | `openai/whisper-small` |
| `FW_DEVICE` | Device to use (cpu/cuda) | `cpu` |

### Model Sizes

- `openai/whisper-tiny` — Fastest, lowest accuracy
- `openai/whisper-small` — **Default** — Balanced
- `openai/whisper-medium` — Better accuracy, slower
- `openai/whisper-large-v3` — Best accuracy, slowest (needs more RAM)

## Resource Requirements

- **Default (small model):** 1 CPU, 2GB RAM
- **Medium model:** 1-2 CPU, 4GB RAM
- **Large model:** 2+ CPU, 8GB+ RAM

## Security Notes

- Add API key authentication if exposing port publicly
- Consider using a reverse proxy (nginx) with rate limiting
