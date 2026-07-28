# Open in VS Code (Finder Quick Action)

A macOS Finder Quick Action — right-click any folder and choose **"Open in VS Code"** to open it directly as a VS Code project.

## Requirements

- macOS (tested on macOS 26)
- [Visual Studio Code](https://code.visualstudio.com/) installed at `/Applications/Visual Studio Code.app`

## Method 1: Install from this repo

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

## Method 2: Build it yourself in Automator

Prefer not to run someone else's script? You can build the same Quick Action from scratch using Apple's built-in [Automator](https://support.apple.com/guide/automator/welcome/mac) app — no repo needed.

1. Open **Automator** via Spotlight (`⌘ + Space`, then type "Automator").
2. Choose **New Document**, then select **Quick Action**.
3. At the top, set **Workflow receives current** to `files or folders` in `Finder.app`.
4. In the search bar on the left, type **"Open Finder Items"** and drag that action into the workflow panel on the right.
5. In the **Open with** dropdown of that action, select **Visual Studio Code**.
6. Save (`⌘ + S`) and name it **"Open in VS Code"**.

Automator saves this straight into `~/Library/Services/`, the same place Method 1's installer copies to — so from here on, both methods behave identically.

## Method 3: Terminal

Don't want a Finder Quick Action at all? If your terminal has the `code` command available, you can open any folder as a VS Code project directly:

```bash
cd /path/to/your/project
code .
```

If `code` isn't recognized, enable it first: open VS Code, press `⌘ + ⇧ + P`, run **Shell Command: Install 'code' command in PATH**, then restart your terminal.

## Use it (Methods 1 & 2)

Right-click a folder in Finder and look for **"Open in VS Code"** (top-level or under a **Quick Actions** submenu). If it doesn't show up right away:

- Run `killall Finder` to force Finder to re-scan installed Services, or
- Check **System Settings → General → Login Items & Extensions → Extensions** and enable it there, or
- Right-click a folder → **Quick Actions → Customize...** and toggle it on.

## How it works (Methods 1 & 2)

Both methods produce a standard Automator "Quick Action" (a `.workflow` bundle) scoped to folders. They just get there differently:

- **Method 1** (this repo) runs a single Run Shell Script action:

  ```bash
  for f in "$@"; do
    open -a "Visual Studio Code" "$f"
  done
  ```

  Using `open -a` instead of the `code` CLI avoids relying on `$PATH`, since Automator's shell scripts run without sourcing your shell profile.

- **Method 2** (built in Automator) uses the built-in **Open Finder Items** action instead of a shell script, pointed at Visual Studio Code — no scripting involved.

## Uninstall (Methods 1 & 2)

```bash
rm -rf ~/Library/Services/"Open in VS Code.workflow"
killall Finder
```
