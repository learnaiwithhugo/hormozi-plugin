#!/usr/bin/env python3
"""Replace skills/hormozi/books/*/figures with the verified crops; update _captions.json,
notes/INDEX/SKILL figure references for cut pages."""
import json, glob, os, re, shutil, pathlib
ROOT = pathlib.Path(__file__).resolve().parent.parent
CW = ROOT / ".cropwork"; SK = ROOT / "skills/hormozi/books"
dec = {d["file"]: d for d in json.load(open(CW/"decisions_all.json"))}
for f in glob.glob(str(CW/"verify_*.json")):
    for v in json.load(open(f)):
        if v["result"] == "cut": dec[v["file"]]["action"] = "cut"
keep = {k for k, d in dec.items() if d["action"] == "crop"}
cut = {k for k in dec if k not in keep}
for book in ("offers", "leads", "money-models"):
    fdir = SK/book/"figures"
    for jpg in fdir.glob("*.jpg"): jpg.unlink()
    caps = json.load(open(fdir/"_captions.json"))
    newcaps = []
    for c in caps:
        key = f"{book}/{c['file']}"
        if key in keep:
            shutil.copy(CW/book/"out"/c["file"], fdir/c["file"]); newcaps.append(c)
    json.dump(newcaps, open(fdir/"_captions.json", "w"), indent=1)
    cutpages = sorted(int(re.search(r"p(\d+)", k).group(1)) for k in cut if k.startswith(book+"/"))
    # strip references to cut figures in notes + INDEX
    for md in list((SK/book/"notes").glob("*.md")) + [SK/book/"INDEX.md"]:
        s = md.read_text(); o = s
        for p in cutpages:
            s = re.sub(rf"\(figure p{p}\)", "", s)            # "(figure p12)"
            s = re.sub(rf", figure p{p}\b", "", s)            # "(p66, figure p66)"
            s = re.sub(rf"figure p{p}\b,? ?", "", s)
            s = re.sub(rf"(figures:[^\n]*?)\bp{p}\b,? ?", r"\1", s)  # frontmatter list
            s = re.sub(rf"\bp{p}\.jpg\b,? ?", "", s)
        s = re.sub(r"figures: *,? *\n", "figures: none\n", s)
        s = re.sub(r"figures:([^\n]*?),\s*\n", r"figures:\1\n", s)
        s = re.sub(r"\(\s*\)", "", s)
        if s != o: md.write_text(s)
    print(book, "kept", len(newcaps), "cut", cutpages)
print("done")
