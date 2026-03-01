from fastapi import FastAPI, File, UploadFile, HTTPException
from faster_whisper import WhisperModel
import tempfile
import shutil
import os
import time
import logging
from typing import List, Dict, Any

# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(title="FastWhisper HTTP Transcription (CPU)")

# Model configuration (change model size if you prefer a different whisper size)
MODEL_NAME = os.environ.get("FW_MODEL", "openai/whisper-small")
MODEL_DEVICE = os.environ.get("FW_DEVICE", "cpu")
HF_CACHE = os.environ.get("HF_HOME", "/home/appuser/.cache/huggingface")

# Load model with retry logic
def load_model_with_retry(max_retries=3, delay=5):
    """Load Whisper model with retry logic for corrupted cache handling"""
    for attempt in range(max_retries):
        try:
            logger.info(f"Loading model {MODEL_NAME} (attempt {attempt + 1}/{max_retries})...")
            
            # Force clean cache on retry attempts
            if attempt > 0:
                logger.info("Cleaning cache before retry...")
                cache_model_path = os.path.join(HF_CACHE, "models--openai--whisper-small")
                if os.path.exists(cache_model_path):
                    import shutil
                    shutil.rmtree(cache_model_path, ignore_errors=True)
                    logger.info(f"Removed cache directory: {cache_model_path}")
            
            # Load model - this will download if not present
            model = WhisperModel(
                MODEL_NAME, 
                device=MODEL_DEVICE, 
                download_root=HF_CACHE,
                compute_type="int8"  # Use int8 for CPU efficiency
            )
            logger.info(f"Model {MODEL_NAME} loaded successfully!")
            return model
        except Exception as e:
            logger.error(f"Failed to load model (attempt {attempt + 1}/{max_retries}): {e}")
            
            if attempt < max_retries - 1:
                logger.info(f"Retrying in {delay} seconds...")
                time.sleep(delay)
            else:
                logger.error("All retry attempts failed!")
                raise

model = load_model_with_retry()

@app.get("/")
async def root():
    return {"status": "ok", "model": MODEL_NAME, "device": MODEL_DEVICE}

@app.post("/transcribe")
async def transcribe(file: UploadFile = File(...)):
    if not file:
        raise HTTPException(status_code=400, detail="No file uploaded")

    # Save upload to temporary file
    tmpdir = tempfile.mkdtemp()
    try:
        tmp_path = os.path.join(tmpdir, file.filename)
        with open(tmp_path, "wb") as f:
            shutil.copyfileobj(file.file, f)

        # Run transcription
        segments, info = model.transcribe(tmp_path)

        # Build simple text + segments list
        text = " ".join([s.text.strip() for s in segments])
        segments_out = [{"start": float(s.start), "end": float(s.end), "text": s.text} for s in segments]

        return {"text": text, "segments": segments_out, "info": info}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        try:
            shutil.rmtree(tmpdir)
        except Exception:
            pass
