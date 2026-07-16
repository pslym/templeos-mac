# TempleOS on macOS (Apple Silicon)

Run [TempleOS](https://templeos.org) — Terry A. Davis's public-domain 64-bit temple — under QEMU on a Mac, with a proper Dock icon.

RIP Terry A. Davis, 1969–2018.

## What's here

- `temple.sh` — boots the VM. `./temple.sh install` for the first run (installs the ISO onto a virtual disk), plain `./temple.sh` after that.
- `TempleOS.app` — a minimal macOS app bundle that wraps `temple.sh`, so you can keep TempleOS in your Dock. Pixel-art gold-cross icon included.
- `make_icon.py` — stdlib-only Python script that draws the icon and emits the PNG iconset (compiled to `.icns` with Apple's `iconutil`).

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
