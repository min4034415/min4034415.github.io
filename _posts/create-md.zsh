#!/bin/zsh
DATE=$(date '+%Y-%m-%d')
FILENAME="$DATE-"
echo -e "---\ntitle: \"\"\ndate: $DATE\ntags: []\nauthor: \"이의민\"\n---" > "$FILENAME.md"
