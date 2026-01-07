#!/bin/bash

OUTPUT="playlist.m3u"

echo "#EXTM3U" > "$OUTPUT"

# Sun News Tamil LIVE
STREAM=$(yt-dlp -g -f "best" "https://www.youtube.com/watch?v=9M02G5c6x6w" | head -n 1)

if [ -n "$STREAM" ]; then
  echo '#EXTINF:-1 tvg-id="sunnews" group-title="News | Tamil",Sun News LIVE' >> "$OUTPUT"
  echo "$STREAM" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
else
  echo "# Sun News stream not available at this time" >> "$OUTPUT"
fi