# TempleOS on macOS (Apple Silicon)

Run [TempleOS](https://templeos.org) — Terry A. Davis's public-domain 64-bit temple — under QEMU on a Mac, with a proper Dock icon.

RIP Terry A. Davis, 1969–2018.

## One-click install

Grab **TempleOS.dmg** from [Releases](https://github.com/pslym/templeos-mac/releases), open it, and drag the temple into Applications. First launch: right-click → **Open** (the app is unsigned; newer macOS may also want System Settings → Privacy & Security → "Open Anyway"). The app handles the rest — it offers to install QEMU via Homebrew if missing, creates the virtual machine, and walks you through TempleOS's one-time installer with dialogs. Every launch after that boots straight into the temple.

Build it yourself with `./build_dmg.sh` (needs `brew install create-dmg`).

courtesy of real nice™ and the Xenophora Corporation 2027.5

## What's here

- `temple.sh` — boots the VM by hand. `./temple.sh install` for the first run (installs the ISO onto a virtual disk), plain `./temple.sh` after that.
- `installer/` — source for the DMG: the self-setting-up app launcher, its Info.plist, and the DMG background painter (Swift).
- `build_dmg.sh` — assembles the app bundle (ISO included) and wraps it in a drag-to-Applications disk image.
- `make_icon.py` — stdlib-only Python script that draws the pixel-art gold-cross icon and emits the PNG iconset (compiled to `.icns` with Apple's `iconutil`).

## Setup

1. `brew install qemu`
2. Download `TempleOS.ISO` from [templeos.org](https://templeos.org) into this folder.
3. `qemu-img create -f qcow2 TempleOS.qcow2 2G`
4. `./temple.sh install` — answer **Y** to the installer's questions. When it asks to reboot, **quit QEMU instead** (the ISO would just boot the installer again).
5. `./temple.sh` — boots the installed system. `Tour;` for the walkthrough, `GodWord;` for the oracle.

## Notes

- `TempleOS.app/Contents/MacOS/temple` contains an absolute path to `temple.sh` — edit it to match where you cloned this.
- **F7** answers "Yes" to TempleOS dialogs quickly; **Ctrl+Alt+G** releases the mouse; **Cmd+F** toggles fullscreen.
- The disk image (`*.qcow2`) and ISO are gitignored — your temple's contents stay yours.
