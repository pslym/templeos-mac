#!/bin/zsh
# TempleOS under QEMU (x86-64 emulation on Apple Silicon)
# Usage:
#   ./temple.sh install   — first run: boots the ISO to install onto the virtual disk
#   ./temple.sh           — normal run: boots the installed system
#
# Inside the VM: F7 answers "Yes" to dialogs quickly; Ctrl+Alt+G releases the mouse.
# RIP Terry A. Davis, 1969-2018.

DIR="${0:A:h}"
DISK="$DIR/TempleOS.qcow2"
ISO="$DIR/TempleOS.ISO"

ARGS=(
  -machine pc,pcspk-audiodev=snd0
  -audiodev coreaudio,id=snd0
  -m 1024
  -smp 2
  -rtc base=localtime
  -drive file="$DISK",format=qcow2,if=ide
  -display cocoa,show-cursor=on,zoom-to-fit=on
  -name "TempleOS"
)

if [[ "$1" == "install" ]]; then
  ARGS+=(-cdrom "$ISO" -boot order=d)
else
  ARGS+=(-boot order=c)
fi

exec qemu-system-x86_64 "${ARGS[@]}"
