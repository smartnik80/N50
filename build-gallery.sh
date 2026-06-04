#!/usr/bin/env bash
set -euo pipefail

GALLERY_DIR="assets/gallery"
HTML="gallery.html"

COUNT=$(find "$GALLERY_DIR" -maxdepth 1 -type f -iname "*.jpg" | wc -l | tr -d ' ')

if [ "$COUNT" -eq 0 ]; then
  echo "No images found in $GALLERY_DIR" >&2
  exit 1
fi

python3 - "$HTML" "$COUNT" <<'PYEOF'
import sys, re
html_file = sys.argv[1]
count     = sys.argv[2]
text = open(html_file).read()
text = re.sub(
    r'/\* BUILD:total \*/.*?/\* BUILD:end \*/',
    '/* BUILD:total */\n    var TOTAL = ' + count + ';\n    /* BUILD:end */',
    text,
    flags=re.DOTALL
)
open(html_file, 'w').write(text)
print(f"Updated {html_file}: TOTAL = {count}")
PYEOF
