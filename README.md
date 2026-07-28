# Open in VS Code (Finder Quick Action)

A macOS Finder Quick Action — right-click any folder and choose **"Open in VS Code"** to open it directly as a VS Code project.

## Requirements

- macOS (tested on macOS 26)
- [Visual Studio Code](https://code.visualstudio.com/) installed at `/Applications/Visual Studio Code.app`

## Install

```bash
git clone https://github.com/Crypto69/vscodeshortcut.git
cd vscodeshortcut
./install.sh
```

This copies `Open in VS Code.workflow` into `~/Library/Services/` and restarts Finder so it picks it up.

### Alternative: install by double-clicking

Download or clone the repo, then double-click `Open in VS Code.workflow`. macOS will prompt to install it as a Quick Action. Since the file isn't signed, Gatekeeper may block it first — if so, either right-click the `.workflow` and choose **Open**, or run:

```bash
xattr -dr com.apple.quarantine "Open in VS Code.workflow"
```

then double-click it again.

## Use it

Right-click a folder in Finder and look for **"Open in VS Code"** (top-level or under a **Quick Actions** submenu). If it doesn't show up right away:

- Run `killall Finder` to force Finder to re-scan installed Services, or
- Check **System Settings → General → Login Items & Extensions → Extensions** and enable it there, or
- Right-click a folder → **Quick Actions → Customize...** and toggle it on.

## How it works

It's a standard Automator "Quick Action" (a `.workflow` bundle under `Contents/`) scoped to folders only (`public.folder`), running a single Run Shell Script action:

```bash
for f in "$@"; do
  open -a "Visual Studio Code" "$f"
done
```

Using `open -a` instead of the `code` CLI avoids relying on `$PATH`, since Automator's shell scripts run without sourcing your shell profile.

## Uninstall

```bash
rm -rf ~/Library/Services/"Open in VS Code.workflow"
killall Finder
```
