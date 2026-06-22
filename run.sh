#!/usr/bin/env bashio

TARGET_URL="http://teehomeassistant.local:8000"

bashio::log.info "Starting Custom Fullscreen Kiosk v2.0..."
bashio::log.info "Target URL: $TARGET_URL"

# Give system time to initialize
sleep 2

# Set permissions for framebuffer and input devices
chmod 666 /dev/fb0 2>/dev/null || true
chmod 666 /dev/tty0 2>/dev/null || true
chmod 666 /dev/tty1 2>/dev/null || true

# Switch to tty1 to claim the display
chvt 1 2>/dev/null || true

bashio::log.info "Launching Chromium in Ozone/KMS mode (no X11 needed)..."

# Run Chromium directly on the framebuffer via Ozone DRM backend
exec chromium \
  --ozone-platform=drm \
  --kiosk \
  --no-sandbox \
  --disable-dev-shm-usage \
  --disable-gpu-sandbox \
  --use-gl=egl \
  --enable-gpu-rasterization \
  --use-fake-ui-for-media-stream \
  --allow-insecure-localhost \
  --unsafely-treat-insecure-origin-as-secure="${TARGET_URL}" \
  --disable-infobars \
  --noerrdialogs \
  --disable-session-crashed-bubble \
  --disable-translate \
  --autoplay-policy=no-user-gesture-required \
  --start-fullscreen \
  "${TARGET_URL}"
