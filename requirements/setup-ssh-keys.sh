#!/bin/bash
# Mevcut kullanıcının SSH authorized_keys dosyasına anahtarları ekler
# Kullanım: bash setup-ssh-keys.sh

set -e

SSH_DIR="$HOME/.ssh"
AUTH_KEYS="$SSH_DIR/authorized_keys"

KEYS=(
"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzEgsmVLMAxncrKkP2j04DOOhc2s9UAuT6mbluyD8MKO20AxQ6pQ/AQusenv0oWPPmw7BR8SKdc99cboex+yU/h5tAfzdL09BfQBX5sOFGgUiaKP05E4PIu4VAOUUgQRk5b32jaSsG5rYZ1xpOQJDBv1p3MCT9ZeEeN73v7C7vEzd8z3k5R1fiPjRKQz9Q6ykFUG19BW5XwAt8w3eqF5yxJMdSPODOCtu5tIisdZpbERtuJ9OuqvFuzIX2Akb9tf7hi5zD10uW2dDrgZYfRPf3UYRKhj6jlFOfSU1/dwQwuZW9RiXXQl1wFQJr6K7O4Vv9diYP24xKeIPUVby2XqAKtfZl8cex7RvhMv+RzWnBv8iPW0sS03ppnMnABmDg7pSmyRDalk8AUn4vdlflN5lFZZESxxXwZ9qr9QldXbefVawHB/BGoN2LCn3U5RoCJos4o+JTgmy8UVoOHDCl6w6Qe3siuEd66j3ptjlPoJDW91q2ohNqg0ux8ipW8dpwHvU= odoo@AhmetThinkpad"
)

# .ssh klasörünü oluştur
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

# authorized_keys dosyasını oluştur (yoksa)
touch "$AUTH_KEYS"
chmod 600 "$AUTH_KEYS"

ADDED=0
for KEY in "${KEYS[@]}"; do
    if ! grep -qF "$KEY" "$AUTH_KEYS" 2>/dev/null; then
        echo "$KEY" >> "$AUTH_KEYS"
        echo "Eklendi: ${KEY##* }"
        ADDED=$((ADDED + 1))
    else
        echo "Zaten mevcut: ${KEY##* }"
    fi
done

echo ""
echo "$ADDED anahtar eklendi. Toplam: $(wc -l < "$AUTH_KEYS") satır."
