FROM python:3.11-slim

# System dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg libsndfile1 build-essential && \
    rm -rf /var/lib/apt/lists/*

# Create app user
RUN useradd -m -s /bin/bash appuser
WORKDIR /home/appuser
USER appuser

# Virtual environment + install
RUN python3 -m venv /home/appuser/venv
ENV PATH="/home/appuser/venv/bin:$PATH"
RUN pip install --upgrade pip setuptools wheel
RUN pip install fastapi uvicorn[standard] faster-whisper

# Copy app
COPY --chown=appuser:appuser app.py /home/appuser/app.py

# Expose internal port
EXPOSE 5100

# Start uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "5100", "--workers", "1"]
