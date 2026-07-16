#!/usr/bin/env python3
"""Pixel-art TempleOS icon: gold cross on DOS-blue rounded square, stdlib only."""
import struct, sys, zlib

GRID = 16  # design on a 16x16 grid, scale up per size

BLUE = (0, 0, 170, 255)      # classic DOS/TempleOS blue
GOLD = (255, 255, 85, 255)   # CGA bright yellow
WHITE = (255, 255, 255, 255)
CLEAR = (0, 0, 0, 0)

# 16x16 design: . = blue, X = gold cross, o = white outline, ' ' = transparent corner
DESIGN = [
    "  ............  ",
    " .............. ",
    "................",
    "......oXXo......",
    "......oXXo......",
    "...ooooXXoooo...",
    "...oXXXXXXXXo...",
    "...oXXXXXXXXo...",
    "...ooooXXoooo...",
    "......oXXo......",
    "......oXXo......",
    "......oXXo......",
    "......oooo......",
    "................",
    " .............. ",
    "  ............  ",
]
COLORS = {'.': BLUE, 'X': GOLD, 'o': WHITE, ' ': CLEAR}

def render(size):
    scale = size // GRID
    rows = []
    for gy in range(GRID):
        row = b''.join(struct.pack('4B', *COLORS[DESIGN[gy][gx]]) for gx in range(GRID) for _ in range(scale))
        rows.extend([b'\x00' + row] * scale)
    return b''.join(rows)

def write_png(path, size):
    raw = render(size)
    def chunk(tag, data):
        c = tag + data
        return struct.pack('>I', len(data)) + c + struct.pack('>I', zlib.crc32(c))
    ihdr = struct.pack('>2I5B', size, size, 8, 6, 0, 0, 0)
    with open(path, 'wb') as f:
        f.write(b'\x89PNG\r\n\x1a\n')
        f.write(chunk(b'IHDR', ihdr))
        f.write(chunk(b'IDAT', zlib.compress(raw)))
        f.write(chunk(b'IEND', b''))

outdir = sys.argv[1]
for size in (16, 32, 128, 256, 512):
    write_png(f'{outdir}/icon_{size}x{size}.png', size)
    write_png(f'{outdir}/icon_{size//2}x{size//2}@2x.png', size)
print('iconset written')
