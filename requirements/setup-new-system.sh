#!/bin/bash
# Yeni bir sistemi sıfırdan kurar
# Sırasıyla: APT kaynakları -> Paketler -> SSH anahtarları
#
# Kullanım: sudo bash setup-new-system.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SUDO_USER_HOME=$(eval echo ~"${SUDO_USER:-$USER}")

if [ "$EUID" -ne 0 ]; then
    echo "Hata: Bu script root yetkisiyle çalıştırılmalıdır."
    echo "Kullanım: sudo bash setup-new-system.sh"
    exit 1
fi

echo "============================================"
echo "  Yeni Sistem Kurulumu"
echo "============================================"
echo ""

# 1. APT kaynakları ve anahtarları
echo "[1/3] APT kaynakları ve anahtarları kuruluyor..."
echo "--------------------------------------------"
bash "$SCRIPT_DIR/setup-apt-sources.sh"
echo ""

# 2. Paket kurulumu
echo "[2/3] Sistem paketleri kuruluyor..."
echo "--------------------------------------------"
bash "$SCRIPT_DIR/install-packages.sh"
echo ""

# 3. SSH anahtarları (kullanıcı yetkisiyle çalıştır)
echo "[3/3] SSH anahtarları kuruluyor..."
echo "--------------------------------------------"
sudo -u "${SUDO_USER:-$USER}" bash "$SCRIPT_DIR/setup-ssh-keys.sh"
echo ""

echo "============================================"
echo "  Kurulum tamamlandı!"
echo "============================================"
