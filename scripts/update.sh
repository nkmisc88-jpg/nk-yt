#!/bin/bash

OUTPUT="playlist.m3u"

echo "#EXTM3U" > "$OUTPUT"

URL="https://www.youtube.com/watch?v=9M02G5c6x6w"

STREAM=$(yt-dlp \
  --no-playlist \
  --live-from-start \
  -f "best[protocol^=http]/best" \
  -g "$URL" | head -n 1)

if [ -n "$STREAM" ]; then
  echo '#EXTINF:-1 tvg-id="sunnews" group-title="News | Tamil",Sun News LIVE' >> "$OUTPUT"
  echo "$STREAM" >> "$OUTPUT"
else
  echo "# Sun News stream not available at this time" >> "$OUTPUT"
fi