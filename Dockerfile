FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    pkg-config \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev \
    libpixman-1-dev \
    libx11-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./

# --ignore-scripts per evitare compilazione nativa e vedere altri errori
RUN npm install --ignore-scripts 2>&1 || true

# Ora prova la compilazione nativa separatamente
RUN npm rebuild canvas --build-from-source 2>&1 || echo "Canvas rebuild failed"

COPY . .

EXPOSE 3000
EXPOSE 3001

CMD ["node", "index.js"]
