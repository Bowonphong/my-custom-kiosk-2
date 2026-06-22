ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base:7.3.3
FROM $BUILD_FROM

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# Install X11, Openbox, and Chromium
RUN apt-get update && apt-get install -y --no-install-recommends \
    xserver-xorg-core \
    xserver-xorg-video-fbdev \
    xserver-xorg-input-all \
    xserver-xorg-legacy \
    x11-xserver-utils \
    openbox \
    chromium \
    && rm -rf /var/lib/apt/lists/*

# Allow anyone to start X
RUN sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config || echo "allowed_users=anybody" > /etc/X11/Xwrapper.config

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
