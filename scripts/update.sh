
#!/bin/bash

OUTPUT="playlist.m3u"
echo "#EXTM3U" > $OUTPUT

while IFS="|" read -r NAME URL GROUP
do
  [[ -z "$NAME" ]] && continue

  STREAMS=$(yt-dlp -g -f "best/best[height<=720]/best[height<=480]" "$URL" 2>/dev/null)
  STREAM=$(echo "$STREAMS" | head -n 1)

  if [[ -n "$STREAM" ]]; then
    TVG_ID=$(echo "$NAME" | tr ' ' '_' | tr '[:upper:]' '[:lower:]')

    echo "#EXTINF:-1 tvg-id=\"$TVG_ID\" group-title=\"$GROUP\",$NAME" >> $OUTPUT
    echo "$STREAM" >> $OUTPUT
    echo "" >> $OUTPUT
  fi
done < channels.txt