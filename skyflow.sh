#!/usr/bin/env bash

# 0     6   10      18        28
# |     |   |       |         |
# 04fc711301f3c784d66955d98d399afb = md5(000001)
# 04    13  f3      69        9a   = 0413f3699a
# 768c1c687efe184ae6dd2420710b8799 = md5(000002)
# 76    68  fe      dd        87   = 7668fedd87

if [ $# -ne 1 ]; then
    echo "Renames Skyflow's coded image's filenames with regular numbers."
    echo ""
    echo "Usage: $0 <IMAGES-FOLDER>"
    echo ""
    echo "EXAMPLE:"
    echo "| $ ls -1R project"
    echo "| project:"
    echo "| config.plist"
    echo "| cover.jpg"
    echo "| frames.dat"
    echo "|"
    echo "| project/images:"
    echo "| [...]"
    echo "| SF_0413f3699a.jpg"
    echo "| [...]"
    echo "| SF_7668fedd87.jpg"
    echo "| [...]"
    echo "|"
    echo "| project/previews:"
    echo "| SF_000001.jpg"
    echo "| SF_000002.jpg"
    echo "| [...]"
    echo "|"
    echo "| $ cd project"
    echo "| $ $0 images"
    echo "| [...]"
    echo "| $ ls -1 images"
    echo "| SF_000001.jpg"
    echo "| SF_000002.jpg"
    echo "| [...]"
    exit
fi

if [[ ! -d "$1" ]]; then
    echo "Directory '$1' not found!"
    exit
fi

IMAGE_DIR="$1"

IMAGE_EXT=.jpg

FRAME_MAX=$(ls -1 "$IMAGE_DIR" | wc -l)
for FRAME_INDEX in $(seq 1 $FRAME_MAX); do
    FRAME_NAME=$(printf '%06d' $FRAME_INDEX)
    echo -n "FRAME $FRAME_NAME "

    # Compute code
    H=$(echo -n $FRAME_NAME | md5sum)
    FRAME_CODE=${H:0:2}${H:6:2}${H:10:2}${H:18:2}${H:28:2}
    echo -n "CODE $FRAME_CODE "

    # Build file name and path
    IMAGE_FILE_NAME=SF_$FRAME_NAME$IMAGE_EXT
    IMAGE_FILE_CODE=SF_$FRAME_CODE$IMAGE_EXT
    echo -n "FILE '$IMAGE_DIR/$IMAGE_FILE_CODE' "

    # Rename file
    if [ -f "$IMAGE_DIR/$IMAGE_FILE_CODE" ]; then
        mv "$IMAGE_DIR/$IMAGE_FILE_CODE" "$IMAGE_DIR/$IMAGE_FILE_NAME"
        echo -en "$IMAGE_FILE_NAME RENAMED\r"
    else
        echo "NOT FOUND"
        exit
    fi
done

echo ""
echo "$FRAME_MAX RENAMED"
