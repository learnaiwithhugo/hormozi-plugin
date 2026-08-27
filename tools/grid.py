#!/usr/bin/env python3
"""grid.py <src.jpg> <out.jpg>: overlays a labelled 100px grid to make coordinates easy to read off."""
import sys
from PIL import Image, ImageDraw
im = Image.open(sys.argv[1]).convert("RGB"); d = ImageDraw.Draw(im); W, H = im.size
for x in range(0, W, 100):
    d.line([(x,0),(x,H)], fill=(255,0,0), width=1); d.text((x+2,2), str(x), fill=(255,0,0))
for y in range(0, H, 100):
    d.line([(0,y),(W,y)], fill=(0,0,255), width=1); d.text((2,y+2), str(y), fill=(0,0,255))
im.save(sys.argv[2], quality=80)
