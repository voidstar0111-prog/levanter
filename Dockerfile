FROM node:20-bookworm

# Install system dependencies for media handling using active mirrors
RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  imagemagick \
  webp && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /root/bot
COPY package.json .

# Install bot dependencies
RUN npm install

# Copy the rest of the bot code
COPY . .

# Start the bot
CMD ["node", "index.js"]
