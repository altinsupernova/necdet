#!/bin/bash
# Yeni bir sistemi sıfırdan kurar
# Sırasıyla: Hostname -> APT kaynakları -> Paketler -> SSH anahtarları -> Ortam değişkenleri
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

# 1. Hostname ayarla (IP'nin son okteti + "pc")
echo "[1/5] Hostname ayarlanıyor..."
echo "--------------------------------------------"
IP_LAST_OCTET=$(hostname -I | awk '{print $1}' | awk -F. '{print $4}')
if [ -n "$IP_LAST_OCTET" ]; then
    NEW_HOSTNAME="pc${IP_LAST_OCTET}"
    hostnamectl set-hostname "$NEW_HOSTNAME"
    sed -i "s/127\.0\.1\.1.*/127.0.1.1\t$NEW_HOSTNAME/" /etc/hosts
    echo "Hostname '${NEW_HOSTNAME}' olarak ayarlandı."
else
    echo "Uyarı: IP adresi alınamadı, hostname değiştirilmedi."
fi
echo ""

# 2. APT kaynakları ve anahtarları
echo "[2/5] APT kaynakları ve anahtarları kuruluyor..."
echo "--------------------------------------------"
bash "$SCRIPT_DIR/setup-apt-sources.sh"
echo ""

# 3. Paket kurulumu
echo "[3/5] Sistem paketleri kuruluyor..."
echo "--------------------------------------------"
bash "$SCRIPT_DIR/install-packages.sh"
echo ""

# 4. SSH anahtarları (kullanıcı yetkisiyle çalıştır)
echo "[4/5] SSH anahtarları kuruluyor..."
echo "--------------------------------------------"
sudo -u "${SUDO_USER:-$USER}" bash "$SCRIPT_DIR/setup-ssh-keys.sh"
echo ""

# 5. Ortam değişkenleri
echo "[5/5] Ortam değişkenleri ayarlanıyor..."
echo "--------------------------------------------"
sudo -u "${SUDO_USER:-$USER}" bash "$SCRIPT_DIR/setup-env.sh"
echo ""

echo "============================================"
echo "  Kurulum tamamlandı!"
echo "============================================"
