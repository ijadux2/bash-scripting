#!/usr/bin/bash

# ASCII Image Generator using jp2a or custom fallback
# Supports PNG and JPG formats
# Custom output options: width, height
#
# Usage: ./ascii-img-generator.sh [options] <image_file>
# Options:
#   -w <width>  : Set output width (default: 80)
#   -h <height> : Set output height (default: auto)
#   -c          : Use custom ASCII characters (fallback mode)
#
# --- ijadux2

# Default values
WIDTH=80
HEIGHT=""
CUSTOM=false

# Parse options
while getopts "w:h:c" opt; do
  case $opt in
  w) WIDTH="$OPTARG" ;;
  h) HEIGHT="$OPTARG" ;;
  c) CUSTOM=true ;;
  *)
    echo "Usage: $0 [-w width] [-h height] [-c] <image_file>" >&2
    exit 1
    ;;
  esac
done
shift $((OPTIND - 1))

# Check if image file is provided
if [ $# -ne 1 ]; then
  echo "Error: Please provide an image file (PNG or JPG)." >&2
  echo "Usage: $0 [-w width] [-h height] [-c] <image_file>" >&2
  exit 1
fi

IMAGE_FILE="$1"

# Check if file exists and is PNG or JPG
if [ ! -f "$IMAGE_FILE" ]; then
  echo "Error: File '$IMAGE_FILE' does not exist." >&2
  exit 1
fi

EXT="${IMAGE_FILE##*.}"
EXT_LOWER=$(echo "$EXT" | tr '[:upper:]' '[:lower:]')
if [ "$EXT_LOWER" != "png" ] && [ "$EXT_LOWER" != "jpg" ] && [ "$EXT_LOWER" != "jpeg" ]; then
  echo "Error: Unsupported format. Only PNG and JPG are supported." >&2
  exit 1
fi

# Check if jp2a is available
if command -v jp2a >/dev/null 2>&1; then
  # Use jp2a
  JP2A_CMD="jp2a --width=$WIDTH"
  if [ -n "$HEIGHT" ]; then
    JP2A_CMD="$JP2A_CMD --height=$HEIGHT"
  fi
  JP2A_CMD="$JP2A_CMD \"$IMAGE_FILE\""
  eval "$JP2A_CMD"
else
  # Fallback: Custom ASCII generator using ImageMagick and awk
  if ! command -v convert >/dev/null 2>&1; then
    echo "Error: jp2a and ImageMagick (convert) are not available. Cannot generate ASCII art." >&2
    exit 1
  fi

  # Use ImageMagick to get pixel data
  # Resize image to specified width, height auto if not set
  if [ -n "$HEIGHT" ]; then
    RESIZE="${WIDTH}x${HEIGHT}!"
  else
    RESIZE="${WIDTH}x"
  fi

  # Convert to grayscale and get pixel values
  convert "$IMAGE_FILE" -resize "$RESIZE" -colorspace Gray txt:- |
    awk '
  BEGIN {
    chars = " .:-=+*#%@"
    n = split(chars, char_array, "")
  }
  /^#/ { next }  # Skip comments
  {
    if (NF >= 4) {
      # Extract grayscale value (0-255)
      gray = $4
      # Map to ASCII char
      idx = int((gray / 255) * (n - 1)) + 1
      printf "%s", char_array[idx]
      col++
      if (col >= width) {
        printf "\n"
        col = 0
      }
    }
  }
  ' width="$WIDTH"
fi
