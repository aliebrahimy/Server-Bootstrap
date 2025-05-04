#!/bin/bash

FILE_PATH="general-config/Server-Preparation.txt"
LAST_LINE=$(tail -n 1 "$FILE_PATH")
LAST_ID=$(echo "$LAST_LINE" | cut -d'|' -f1 | tr -d ' ')
LAST_HOST=$(echo "$LAST_LINE" | cut -d'|' -f2 | tr -d ' ')

# استخراج شماره عددی از هاست‌نیم (مثلاً 5226 از plva5226)
LAST_NUMBER=$(echo "$LAST_HOST" | grep -o '[0-9]*$')
NEW_NUMBER=$((10#$LAST_NUMBER + 1))
NEW_HOSTNAME="plva${NEW_NUMBER}"

# ورودی‌های جدید (این‌ها باید از survey یا متغیر پاس داده بشن)
NEW_IP=$1
OWNER=$2
DESCRIPTION=$3

# تولید ID جدید
NEW_ID=$((10#$LAST_ID + 1))

# افزودن به فایل
echo "$NEW_ID | $NEW_HOSTNAME | $NEW_IP | $OWNER | $DESCRIPTION" >> "$FILE_PATH"

# Commit & Push (در صورتی که گیت تنظیم شده باشه)
git add "$FILE_PATH"
git commit -m "Add $NEW_HOSTNAME with IP $NEW_IP"
git push
echo "hostname=$NEW_HOSTNAME"


