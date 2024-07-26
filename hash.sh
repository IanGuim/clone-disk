#!/bin/bash

SOURCE_DISK="/dev/sdc"
DEST_FILE="clone_image.bin"

HASH_SOURCE="source_disk_md5.txt"
HASH_IMAGE="clone_image_md5.txt"

log_file="log_clone.txt"

dc3dd if="$SOURCE_DISK" of="$DEST_FILE" log="$log_file"

echo "Generating md5 of the $SOURCE_DISK..."
md5sum "$SOURCE_DISK" | awk '{print $1}' > $HASH_SOURCE
cat $HASH_SOURCE
echo ""

echo "Generating md5 of the $DEST_FILE..."
md5sum "$DEST_FILE" | awk '{print $1}' > $HASH_IMAGE
cat $HASH_IMAGE
echo ""

if diff source_disk_md5.txt clone_image_md5.txt; then
    echo "Hash values match. Image file is valid."
else
    echo "Hash values do not match. Image file may be corrupted."
fi
