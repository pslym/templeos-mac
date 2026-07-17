#!/bin/zsh
# Builds build/TempleOS.dmg — a classic drag-to-Applications installer.
# The app inside bundles the public-domain TempleOS ISO and sets up the
# QEMU VM on first launch (see installer/temple-launcher).
# Requires: brew install create-dmg
set -euo pipefail
cd "${0:A:h}"

APP="build/TempleOS.app"
rm -rf build
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources" build/temple.iconset build/dmg-src

cp installer/temple-launcher "$APP/Contents/MacOS/temple"
chmod +x "$APP/Contents/MacOS/temple"
cp installer/Info.plist "$APP/Contents/Info.plist"

python3 make_icon.py build/temple.iconset
iconutil -c icns build/temple.iconset -o "$APP/Contents/Resources/temple.icns"

# the ISO is public domain; use a local copy if present, else fetch it
for iso in TempleOS.ISO "$HOME/VMs/TempleOS/TempleOS.ISO"; do
  if [[ -f "$iso" ]]; then cp "$iso" "$APP/Contents/Resources/TempleOS.ISO"; break; fi
done
[[ -f "$APP/Contents/Resources/TempleOS.ISO" ]] ||
  curl -fL https://templeos.org/Downloads/TempleOS.ISO -o "$APP/Contents/Resources/TempleOS.ISO"

swift installer/make_dmg_background.swift build/dmg-background.png

cp -R "$APP" build/dmg-src/
cp "installer/READ ME FIRST.txt" build/dmg-src/

create-dmg \
  --volname "TempleOS" \
  --volicon "$APP/Contents/Resources/temple.icns" \
  --background build/dmg-background.png \
  --window-pos 200 120 \
  --window-size 600 400 \
  --icon-size 100 \
  --icon "TempleOS.app" 150 200 \
  --app-drop-link 450 200 \
  --icon "READ ME FIRST.txt" 300 330 \
  build/TempleOS.dmg \
  build/dmg-src/

echo "Built build/TempleOS.dmg"
