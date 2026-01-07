#!/bin/bash

OUTPUT="playlist.m3u"

echo "#EXTM3U" > "$OUTPUT"
echo "Channels file:" >> "$OUTPUT"

cat channels.txt >> "$OUTPUT"
echo "" >> "$OUTPUT"

while IFS="|" read -r NAME URL GROUP
do
  echo "Processing $NAME"

  STREAM=$(yt-dlp -g "$URL" | head -n 1)

  if [ -n "$STREAM" ]; then
    echo "#EXTINF:-1 group-title=\"$GROUP\",$NAME" >> "$OUTPUT"
    echo "$STREAM" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
  fi
done < channels.txt