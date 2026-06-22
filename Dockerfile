ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base:7.3.3
FROM $BUILD_FROM

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# Install Chromium and minimal dependencies only (no X11 needed)
RUN apt-get update && apt-get install -y --no-install-recommends \
    chromium \
    chromium-sandbox \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    fonts-liberation \
    udev \
    && rm -rf /var/lib/apt/lists/*

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
