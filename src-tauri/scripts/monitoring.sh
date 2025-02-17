#!/bin/bash

MONITORED_DIR="$1"
OUTPUT_DIR="$1/test_subdirectory"

mkdir -p "$OUTPUT_DIR"

inotifywait -m -e create "$MONITORED_DIR" | while read DIR EVENT FILE
do
    echo "New file detected: $FILE"
    mv "$MONITORED_DIR/$FILE" "$OUTPUT_DIR"
    echo "File moved to $OUTPUT_DIR"
done