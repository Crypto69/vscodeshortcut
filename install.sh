#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKFLOW_NAME="Open in VS Code.workflow"
SRC="$SCRIPT_DIR/$WORKFLOW_NAME"
DEST="$HOME/Library/Services/$WORKFLOW_NAME"

if [ ! -d "$SRC" ]; then
  echo "Error: '$WORKFLOW_NAME' not found next to this script." >&2
  exit 1
fi

if [ ! -d "/Applications/Visual Studio Code.app" ]; then
  echo "Warning: /Applications/Visual Studio Code.app not found. The Quick Action will install but won't do anything until VS Code is installed there." >&2
fi

mkdir -p "$HOME/Library/Services"
rm -rf "$DEST"
cp -R "$SRC" "$DEST"

echo "Installed '$WORKFLOW_NAME' to $DEST"
echo "Restarting Finder to register it..."
killall Finder

echo "Done. Right-click any folder in Finder and look for 'Open in VS Code'."
echo "If it's not there, check System Settings > General > Login Items & Extensions > Extensions."
