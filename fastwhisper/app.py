from fastapi import FastAPI, File, UploadFile, HTTPException
from faster_whisper import WhisperModel
import tempfile
import shutil
import os
from typing import List, Dict, Any

app = FastAPI(title="FastWhisper HTTP Transcription (CPU)")

# Model configuration (change model size if you prefer a different whisper size)
MODEL_NAME = os.environ.get("FW_MODEL", "openai/whisper-small")
MODEL_DEVICE = os.environ.get("FW_DEVICE", "cpu")

# Load model once at startup
model = WhisperModel(MODEL_NAME, device=MODEL_DEVICE)

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
