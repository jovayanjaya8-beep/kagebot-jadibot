FROM node:22-slim
ENV PUPPETEER_SKIP_DOWNLOAD=true NODE_ENV=production
RUN apt-get update && apt-get install -y --no-install-recommends \
    git ffmpeg imagemagick webp python3 ca-certificates curl unzip \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
ARG APP_URL="https://drive.usercontent.google.com/download?id=12Oui_lzkqLX4qNbzWiyUnPGokuzCM8VE&export=download&confirm=t"
ARG APP_SHA256="776730a89859e2ad9b7120a0e2ffc45b87dd0bea52a6b350adbde41bd4cccb29"
RUN curl -fsSL "$APP_URL" -o /tmp/app.zip \
    && echo "$APP_SHA256  /tmp/app.zip" | sha256sum -c - \
    && unzip -q /tmp/app.zip -d /app \
    && rm /tmp/app.zip
RUN npm install --omit=dev --no-audit --no-fund
EXPOSE 3000
CMD ["npm", "start"]
