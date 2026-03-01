FROM python:3.11-slim

# System dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg libsndfile1 build-essential && \
    rm -rf /var/lib/apt/lists/*

# Create app user
RUN useradd -m -s /bin/bash appuser

# Create HuggingFace cache directory with proper permissions
RUN mkdir -p /home/appuser/.cache/huggingface && \
    chown -R appuser:appuser /home/appuser/.cache

WORKDIR /home/appuser
USER appuser

# Virtual environment + install
RUN python3 -m venv /home/appuser/venv
ENV PATH="/home/appuser/venv/bin:$PATH"
RUN pip install --upgrade pip setuptools wheel
RUN pip install fastapi uvicorn[standard] faster-whisper

# Set HuggingFace cache environment variable
ENV HF_HOME=/home/appuser/.cache/huggingface

# Copy app files
COPY --chown=appuser:appuser app.py /home/appuser/app.py
COPY --chown=appuser:appuser entrypoint.sh /home/appuser/entrypoint.sh
RUN chmod +x /home/appuser/entrypoint.sh

# Expose internal port
EXPOSE 5100

# Start with entrypoint
ENTRYPOINT ["/home/appuser/entrypoint.sh"]
