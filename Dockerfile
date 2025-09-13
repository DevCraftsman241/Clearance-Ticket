FROM python:3.11-slim

# System deps for Tesseract + basic fonts
RUN apt-get update && apt-get install -y --no-install-recommends \
    tesseract-ocr libglib2.0-0 libgl1 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Python deps
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# App code
COPY app ./app

# Port for Render/Railway etc.
ENV PORT=8000
EXPOSE 8000

# Start FastAPI
CMD ["sh","-c","uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000}"]

