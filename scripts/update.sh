#!/bin/bash

OUTPUT="playlist.m3u"
LOG="debug.log"

echo "#EXTM3U" > $OUTPUT
echo "Run started at $(date)" > $LOG

while IFS="|" read -r NAME URL GROUP
do
  [[ -z "$NAME" ]] && continue

  echo "Processing: $NAME" >> $LOG
  echo "URL: $URL" >> $LOG

  STREAM=$(yt-dlp \
    -f "best[protocol^=http]/best" \
    -g \
    --no-warnings \
    "$URL" 2>>$LOG | head -n 1)

  if [[ -n "$STREAM" ]]; then
    TVG_ID=$(echo "$NAME" | tr ' ' '_' | tr '[:upper:]' '[:lower:]')

    echo "#EXTINF:-1 tvg-id=\"$TVG_ID\" group-title=\"$GROUP\",$NAME" >> $OUTPUT
    echo "$STREAM" >> $OUTPUT
    echo "" >> $OUTPUT

    echo "✔ Stream OK" >> $LOG
  else
    echo "❌ No stream found" >> $LOG
  fi
done < channels.txt