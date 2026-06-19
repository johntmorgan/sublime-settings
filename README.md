# sublime-settings

My Sublime Text config, tracked so it reinstalls itself on a new machine.

## What's here

- `User/` — the real config files, symlinked into Sublime's `Packages/User/` dir:
  - `Default (OSX).sublime-keymap` — keybindings
  - `Preferences.sublime-settings` — editor preferences
  - `Package Control.sublime-settings` — the list of packages to install
- `install.sh` — backs up any existing config, then symlinks the files above into place.
- `sublimenotes.md` — the original by-hand checklist, kept for reference.

## Install on a fresh machine

1. Install Sublime Text and launch it once (so the config dir exists), and install
   [Package Control](https://packagecontrol.io/installation).
2. Clone and run the installer:

       git clone https://github.com/Nissl/sublime-settings.git && cd sublime-settings && ./install.sh

3. Launch Sublime Text. Package Control auto-installs any package listed in
   `installed_packages` (currently `SublimeLinter`, `TrailingSpaces`).

## How auto-install works

Because the files are **symlinked** (not copied), editing settings inside Sublime
edits this repo directly — so `git commit` captures your changes and there's no
sync step. Package Control's auto-install of missing packages does the rest: keep
`installed_packages` in `User/Package Control.sublime-settings` up to date and new
machines pull the packages down on first launch.

To add a package to the synced set, install it normally in Sublime (Package Control
updates that file), then commit the change here.
