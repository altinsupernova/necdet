#!/bin/bash
# Üçüncü parti APT kaynaklarını ve GPG anahtarlarını yeni sisteme kurar
# Kullanım: sudo bash setup-apt-sources.sh
#
# Desteklenen kaynaklar:
#   - Docker CE (docker.list)
#   - Google Chrome (google-chrome.list)
#   - NodeSource Node.js 20.x (nodesource.sources)

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Hata: Bu script root yetkisiyle çalıştırılmalıdır."
    echo "Kullanım: sudo bash setup-apt-sources.sh"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCES_DIR="$SCRIPT_DIR/apt-sources"
KEYS_DIR="$SCRIPT_DIR/apt-keys"

echo "=== APT anahtarları kuruluyor ==="

# Docker GPG anahtarı
mkdir -p /etc/apt/keyrings
cp "$KEYS_DIR/docker.asc" /etc/apt/keyrings/docker.asc
chmod 644 /etc/apt/keyrings/docker.asc
echo "  [+] Docker anahtarı -> /etc/apt/keyrings/docker.asc"

# Google Chrome GPG anahtarı
cp "$KEYS_DIR/google-chrome.gpg" /etc/apt/trusted.gpg.d/google-chrome.gpg
chmod 644 /etc/apt/trusted.gpg.d/google-chrome.gpg
echo "  [+] Google Chrome anahtarı -> /etc/apt/trusted.gpg.d/google-chrome.gpg"

# NodeSource GPG anahtarı
cp "$KEYS_DIR/nodesource.gpg" /usr/share/keyrings/nodesource.gpg
chmod 644 /usr/share/keyrings/nodesource.gpg
echo "  [+] NodeSource anahtarı -> /usr/share/keyrings/nodesource.gpg"

echo ""
echo "=== APT kaynak dosyaları kuruluyor ==="

cp "$SOURCES_DIR/docker.list" /etc/apt/sources.list.d/docker.list
echo "  [+] Docker -> /etc/apt/sources.list.d/docker.list"

cp "$SOURCES_DIR/google-chrome.list" /etc/apt/sources.list.d/google-chrome.list
echo "  [+] Google Chrome -> /etc/apt/sources.list.d/google-chrome.list"

cp "$SOURCES_DIR/nodesource.sources" /etc/apt/sources.list.d/nodesource.sources
echo "  [+] NodeSource -> /etc/apt/sources.list.d/nodesource.sources"

echo ""
echo "=== APT paket listesi güncelleniyor ==="
apt update

echo ""
echo "APT kaynakları ve anahtarları başarıyla kuruldu!"
echo "Artık 'sudo bash install-packages.sh' ile paketleri kurabilirsiniz."
