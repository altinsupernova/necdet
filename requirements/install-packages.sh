#!/bin/bash
# Sistem paketlerini yeni bir makineye kurmak için kullanılır
# Kullanım: sudo bash install-packages.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== APT paketleri kuruluyor ==="
apt update
xargs -a "$SCRIPT_DIR/apt-packages.txt" apt install -y

echo ""
echo "=== NPM global paketleri kuruluyor ==="
if command -v npm &> /dev/null; then
    xargs -a "$SCRIPT_DIR/npm-packages.txt" npm install -g
else
    echo "npm bulunamadı, önce nodejs kurulmalı."
fi

echo ""
echo "Kurulum tamamlandı!"
