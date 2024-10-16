FROM python:3.8-slim

# Set working directory
WORKDIR /usr/src/app

# Install dependencies and system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    python3-dev \
    gcc \
    libatlas-base-dev \
    libc6-dev \
    build-essential \
    libjpeg-dev \
    zlib1g-dev \       
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Set up a virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy and install Python dependencies
COPY requirements.txt .
RUN python -m pip install --no-cache-dir --upgrade pip setuptools wheel

# Install packages from requirements.txt one by one for debugging
RUN python -m pip install --no-cache-dir aiofiles>=0.4.0
RUN python -m pip install --no-cache-dir aiohttp>=3.5.4
RUN python -m pip install --no-cache-dir asyncio>=3.4.3
RUN python -m pip install --no-cache-dir fastai>=1.0.61 
RUN python -m pip install --no-cache-dir torch>=1.4.0
RUN python -m pip install --no-cache-dir torchvision>=0.5.0
RUN python -m pip install --no-cache-dir numpy>=1.16.3
RUN python -m pip install --no-cache-dir starlette>=0.12.0
RUN python -m pip install --no-cache-dir uvicorn>=0.7.1
RUN python -m pip install --no-cache-dir python-multipart>=0.0.5

# Copy application files
COPY app app/

# Expose the application port
EXPOSE 8080

# Default command to run the app
CMD ["python", "app/server.py", "serve"]
