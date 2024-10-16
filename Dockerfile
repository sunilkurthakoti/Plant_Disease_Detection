# Use the official fastai image as the base
FROM fastai/fastai:latest

# Set working directory
WORKDIR /usr/src/app

# Install any additional packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Copy requirements.txt
COPY requirements.txt .

# Upgrade pip and install dependencies
RUN python -m pip install --no-cache-dir --upgrade pip setuptools wheel \
    && python -m pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY app app/

# Expose the application port
EXPOSE 8080

# Default command to run the app
CMD ["python", "app/server.py", "serve"]
