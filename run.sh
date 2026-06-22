#!/usr/bin/env bashio

TARGET_URL="http://teehomeassistant.local:8000"

bashio::log.info "Starting Custom Kiosk Add-on..."
bashio::log.info "URL to display: $TARGET_URL"

# Clear old X locks
rm -f /tmp/.X0-lock

# Start X server using framebuffer
Xorg -nocursor -s 0 -dpms &
export DISPLAY=:0

# Wait for X to load
sleep 3

# Start Openbox Window Manager
openbox-session &
sleep 1

bashio::log.info "Launching Chromium with camera unlock flags..."
exec chromium \
  --kiosk \
  --no-sandbox \
  --disable-dev-shm-usage \
  --disable-gpu \
  --disable-software-rasterizer \
  --use-fake-ui-for-media-stream \
  --allow-insecure-localhost \
  --unsafely-treat-insecure-origin-as-secure="${TARGET_URL}" \
  --autoplay-policy=no-user-gesture-required \
  "${TARGET_URL}"
