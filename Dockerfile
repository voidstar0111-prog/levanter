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

# Initialize a local git repository so the bot doesn't crash
RUN git init && \
  git config --global user.email "bot@levanter.internal" && \
  git config --global user.name "LevanterBot" && \
  git add . && \
  git commit -m "Deploy patch"

# Start the bot
CMD ["node", "index.js"]
