#!/usr/bin/env bash
set -euo pipefail

GALLERY_DIR="assets/gallery"
HTML="gallery.html"

# Collect image files sorted by filename
FILES=()
while IFS= read -r f; do
  FILES+=("$f")
done < <(find "$GALLERY_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" \) | sort)

if [ ${#FILES[@]} -eq 0 ]; then
  echo "No images found in $GALLERY_DIR" >&2
  exit 1
fi

# Build photos array
PHOTOS_JS=""
for f in "${FILES[@]}"; do
  name=$(basename "$f")
  PHOTOS_JS+="      'assets/gallery/$name',\n"
done

# Strip trailing comma from last line
PHOTOS_JS=$(printf "%b" "$PHOTOS_JS" | sed '$ s/,$//')

PHOTOS_BLOCK="    /* BUILD:photos */\n    var photos = [\n${PHOTOS_JS}\n    ];\n    /* BUILD:end */"

# Replace between markers using Python (available on macOS without extra deps)
python3 - "$HTML" "$PHOTOS_BLOCK" <<'PYEOF'
import sys, re

html_file    = sys.argv[1]
photos_block = sys.argv[2]

text = open(html_file).read()

text = re.sub(
    r'[ \t]*/\* BUILD:photos \*/.*?/\* BUILD:end \*/',
    photos_block,
    text,
    flags=re.DOTALL
)

open(html_file, 'w').write(text)
print(f"Updated {html_file} with {photos_block.count('gallery/')} photos.")
PYEOF
