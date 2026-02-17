#!/bin/bash
# ~/.env dosyasındaki ortam değişkenlerini hem CLI hem masaüstü oturumları
# için yüklenecek şekilde ~/.profile içine ekler.
#
# ~/.profile hem login shell (terminal, SSH) hem de display manager
# (GDM, LightDM, SDDM) tarafından okunur, bu sayede değişkenler
# her iki ortamda da geçerli olur.
#
# Kullanım: bash setup-env.sh

set -e

ENV_FILE="$HOME/.env"
PROFILE_FILE="$HOME/.profile"
SOURCE_BLOCK='# ~/.env ortam değişkenlerini yükle
if [ -f "$HOME/.env" ]; then
    set -a
    . "$HOME/.env"
    set +a
fi'

if [ ! -f "$ENV_FILE" ]; then
    echo "Uyarı: $ENV_FILE bulunamadı, atlanıyor."
    exit 0
fi

if [ ! -f "$PROFILE_FILE" ]; then
    echo "$PROFILE_FILE bulunamadı, oluşturuluyor..."
    echo "$SOURCE_BLOCK" > "$PROFILE_FILE"
    echo "$PROFILE_FILE oluşturuldu ve .env kaynağı eklendi."
    exit 0
fi

if grep -qF '. "$HOME/.env"' "$PROFILE_FILE"; then
    echo ".env kaynağı zaten $PROFILE_FILE içinde mevcut, atlanıyor."
    exit 0
fi

echo "" >> "$PROFILE_FILE"
echo "$SOURCE_BLOCK" >> "$PROFILE_FILE"
echo ".env kaynağı $PROFILE_FILE dosyasına eklendi."
