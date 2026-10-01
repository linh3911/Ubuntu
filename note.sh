#!/bin/bash
cd ~/my-journal
DIR="notes"
mkdir -p "$DIR"
DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M:%S")
TEMP_FILE="$DIR/$DATE.tmp.md"
FINAL_FILE="$DIR/$DATE.md.gpg"

echo "=== VIẾT NHẬT KÝ ($DATE lúc $TIME) ==="
echo "Nhập nội dung (Ấn Enter xuống dòng rồi ấn Ctrl+D để LƯU):"
echo "--------------------------------------------------------"

echo "## Ghi chú lúc $TIME" >> "$TEMP_FILE"
cat >> "$TEMP_FILE"
echo -e "\n---\n" >> "$TEMP_FILE"

gpg --symmetric --cipher-algo AES256 --batch --yes --passphrase-file ~/.diary_secret --output "$FINAL_FILE" "$TEMP_FILE"
rm -f "$TEMP_FILE"

echo "Đang đồng bộ lên GitHub..."
git add .
git commit -m "Cập nhật nhật ký ngày $DATE lúc $TIME"
git push origin main
echo "Thành công! Nhật ký đã được mã hóa an toàn trên GitHub."
