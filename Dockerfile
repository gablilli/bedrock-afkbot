FROM node:22

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
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./

# Installa canvas separatamente prima del resto
RUN npm install canvas --build-from-source
RUN npm install

COPY . .

EXPOSE 3000
CMD ["node", "index.js"]
