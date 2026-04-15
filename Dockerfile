FROM node:22-bookworm

# Dipendenze di sistema per canvas (modulo nativo)
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

# Prima installa canvas esplicitamente con compilazione nativa
RUN npm install canvas

# Poi installa il resto
RUN npm install

COPY . .

EXPOSE 3000
EXPOSE 3001

CMD ["node", "index.js"]
