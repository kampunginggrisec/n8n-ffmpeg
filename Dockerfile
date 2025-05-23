FROM node:18-bullseye

# Set up environment
ENV N8N_VERSION=1.88.0

# Install required packages
RUN apt-get update && \
    apt-get install -y ffmpeg curl ca-certificates gnupg && \
    curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp && \
    chmod a+rx /usr/local/bin/yt-dlp && \
    npm install -g n8n@${N8N_VERSION} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a user and switch to it
RUN useradd -m -s /bin/bash nodeuser
USER nodeuser
WORKDIR /home/nodeuser

EXPOSE 5678

CMD ["n8n"]
