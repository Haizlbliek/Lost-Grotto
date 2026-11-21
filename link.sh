#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="$SCRIPT_DIR/mod"

if [ ! -d "$SOURCE" ]; then
	echo "[ERROR] Could not find source folder: $SOURCE"
	exit 1
fi

STEAM_PATHS=(
	"$HOME/.local/share/Steam/steamapps/common/Rain World"
	"$HOME/.steam/steam/steamapps/common/Rain World"
	"$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/common/Rain World"
	"$HOME/snap/steam/common/.local/share/Steam/steamapps/common/Rain World"
)

GAME_DIR=""
for path in "${STEAM_PATHS[@]}"; do
	if [ -d "$path" ]; then
		GAME_DIR="$path"
		break
	fi
done

if [ -z "$GAME_DIR" ]; then
	echo "[ERROR] Could not automatically locate Rain World."
	exit 1
fi

TARGET="$GAME_DIR/RainWorld_Data/StreamingAssets/mods/Lost-Grotto"

mkdir -p "$(dirname "$TARGET")"

if [ -L "$TARGET" ]; then
	echo "Removing existing symlink at $TARGET..."
	rm "$TARGET"
elif [ -d "$TARGET" ]; then
	echo "Removing existing directory at $TARGET..."
	rm -rf "$TARGET"
fi

ln -s "$SOURCE" "$TARGET"
echo "[SUCCESS] Linked:"
echo "  $TARGET -> $SOURCE"
