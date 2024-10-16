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
    libjpeg-dev \      # Required for image processing
    zlib1g-dev \       # Required for image processing
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Set up a virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy and install Python dependencies
COPY requirements.txt .

# Upgrade pip and install fastai directly
RUN python -m pip install --no-cache-dir --upgrade pip setuptools wheel \
    && python -m pip install --no-cache-dir fastai==1.0.61

# Install other dependencies from requirements.txt
RUN python -m pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY app app/

# Expose the application port
EXPOSE 8080

# Default command to run the app
CMD ["python", "app/server.py", "serve"]
