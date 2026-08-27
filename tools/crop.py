#!/usr/bin/env python3
"""crop.py <src.jpg> <out.jpg> x0 y0 x1 y1  (pixel coords on the original image)
Crops and writes out; prints the resulting size."""
import sys
from PIL import Image
src, out, x0, y0, x1, y1 = sys.argv[1], sys.argv[2], *map(int, sys.argv[3:7])
im = Image.open(src)
W, H = im.size
x0, y0 = max(0, x0), max(0, y0); x1, y1 = min(W, x1), min(H, y1)
im.crop((x0, y0, x1, y1)).save(out, quality=88)
print(f"{out}: {x1-x0}x{y1-y0} from {W}x{H}")
