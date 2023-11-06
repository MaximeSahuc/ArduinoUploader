#/bin/bash

if [ $# -lt 3 ]; then
    echo "Usage: $0 <device port> <board name> <sketch path>"
    exit 1
fi

PORT="$1"
BOARD_NAME="$2"
SKETCH_PATH="$3"

board_fqbn=$(arduino-cli board listall | grep "$BOARD_NAME" | grep -oP '\S+\s+\K\S+:\S+:\S+')

echo "board name: $BOARD_NAME"
echo "board type: $board_fqbn"

echo "Compiling sketch"
arduino-cli compile --fqbn $board_fqbn $SKETCH_PATH
echo "Done compiling"

echo "Uploading.."
arduino-cli upload -p $PORT --fqbn $board_fqbn $SKETCH_PATH
echo "Done!"
