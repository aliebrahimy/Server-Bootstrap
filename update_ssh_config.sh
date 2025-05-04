#!/bin/bash

# پارامترها
SERVER_DESCRIPTION="$1"     # مثلاً: Oxygen-MinIO-Node01-158.53
TARGET_IP="$2"              # مثلاً: 172.29.158.53
ANSIBLE_USER="$3"           # مثلاً: root

# مسیر ریپوی گیت
GIT_DIR="/mnt/git/Linux Team"
FILE="$GIT_DIR/ssh-config"

# بلاک موردنظر برای اضافه شدن
BLOCK=$(cat <<EOF
Host Linux-$SERVER_DESCRIPTION
HostName $TARGET_IP
User $ANSIBLE_USER
Port 22
EOF
)

# بررسی وجود بلاک
if grep -q "Host Linux-$SERVER_DESCRIPTION" "$FILE"; then
  echo "Entry already exists for Linux-$SERVER_DESCRIPTION"
  exit 0
fi

# افزودن بلاک
echo -e "\n$BLOCK" >> "$FILE"

# Commit و Push
cd "$GIT_DIR"
git add ssh-config
git commit -m "Add SSH config for Linux-$SERVER_DESCRIPTION"
git push

echo "Added SSH config for Linux-$SERVER_DESCRIPTION"

