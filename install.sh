#!/usr/bin/env bash
#
# Symlink the tracked Sublime Text config from this repo into Sublime's
# User package directory. On next launch, Package Control auto-installs any
# package listed in "Package Control.sublime-settings" that isn't present.
#
# Existing files at the destination are backed up to <file>.bak before linking.
# Re-running is safe: an already-correct symlink is left alone.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$REPO_DIR/User"

# Sublime Text 4 (default), then Sublime Text 3 fallback.
ST4="$HOME/Library/Application Support/Sublime Text/Packages/User"
ST3="$HOME/Library/Application Support/Sublime Text 3/Packages/User"

if [ -d "$(dirname "$ST4")" ]; then
	DEST_DIR="$ST4"
elif [ -d "$(dirname "$ST3")" ]; then
	DEST_DIR="$ST3"
else
	echo "error: couldn't find a Sublime Text Packages directory." >&2
	echo "Is Sublime Text installed and launched at least once?" >&2
	exit 1
fi

mkdir -p "$DEST_DIR"
echo "Linking into: $DEST_DIR"

for src in "$SRC_DIR"/*; do
	name="$(basename "$src")"
	dest="$DEST_DIR/$name"

	# Already the correct symlink — nothing to do.
	if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
		echo "  ok      $name (already linked)"
		continue
	fi

	# Back up anything real that's in the way.
	if [ -e "$dest" ] || [ -L "$dest" ]; then
		backup="$dest.bak"
		mv "$dest" "$backup"
		echo "  backup  $name -> $name.bak"
	fi

	ln -s "$src" "$dest"
	echo "  link    $name"
done

echo
echo "Done. Launch Sublime Text — Package Control will install missing packages."
