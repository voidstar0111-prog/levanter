FROM node:20-bookworm

# Install system dependencies including git
RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  imagemagick \
  webp \
  git && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /root/bot
COPY package.json .

# Install bot dependencies
RUN npm install --legacy-peer-deps

# Copy the rest of the bot code
COPY . .

# Initialize git and link it to the upstream repository to satisfy the updater
RUN git init && \
  git config --global user.email "bot@levanter.internal" && \
  git config --global user.name "LevanterBot" && \
  git checkout -b master && \
  git add . && \
  git commit -m "Deploy patch" && \
  git remote add origin https://github.com/lyfe00011/levanter.git && \
  git fetch origin master

# Start the bot
CMD ["node", "index.js"]
