# Hormozi for Claude Code

Alex Hormozi as a business coach, inside Claude Code. Ask it what to charge, how to
structure an offer, whether to add a guarantee, what to give away as a lead magnet, or
what to sell next. It answers in Alex's voice, from the frameworks in his three books,
and cites the page.

Built by [Hugo Manning](https://learnaiwithhugo.com). Not affiliated with Alex Hormozi
or Acquisition.com.

## Install

In Claude Code:

```
/plugin marketplace add hugoman225-bot/hormozi-plugin
/plugin install hormozi@hugo-manning
```

Then in any project:

```
/hormozi:ask what should I charge for a 14-day done-for-you build?
```

It only fires when you ask for it: `/hormozi:ask`, "ask Alex", "ask Hormozi", "what would
Hormozi say". It won't hijack normal business questions.

## What's inside

```
skills/ask/
  SKILL.md                 who Alex is, how he answers, where to look
  books/
    offers/                $100M Offers (2021)
    leads/                 $100M Leads (2023)
    money-models/          $100M Money Models (2025)
      INDEX.md             question -> which notes file
      notes/               the frameworks, chapter by chapter, with page numbers
      highlights.md        key passages, in book order
      figures/             the diagrams, cropped from the book, with captions
      source/              empty. see below
  scripts/
    video-memory.sh        installs and searches the optional video memory. see below
```

Offers is what you sell. Leads is who you sell it to. Money Models is the order you
sell it in. Real questions usually touch more than one, and the skill reads across them.

## The video memory (optional, installs on request)

The books are the doctrine. There's a second memory: **2,039 videos from Alex's
MoreMozi YouTube channel**, mostly him diagnosing real businesses on camera, cut into
9,330 timestamped passages you can search offline. When the skill uses it, you get a
short **On camera** section under the answer, each clip a link that opens YouTube at
the second he says it.

It is not installed with the plugin. The first time you ask a question, Alex answers
from the books and then offers, once:

> I've also got 2,000 of my videos I can search, on top of the books. Want me to
> install that? One-off, about 250 MB on this machine, a couple of minutes.

Say yes and it installs itself, then adds the clips to the answer you just got. Say no
and it stays books-only; it won't ask again. If you change your mind later, say
"install the add-on".

What "install" means: it clones the transcript corpus into
`~/.local/share/hormozi-plugin/ask-hormozi`, sets up an isolated Python environment,
installs the [QMD](https://github.com/tobi/qmd) search engine if your machine doesn't
have it, and builds a search index. Every search after that runs against files on your
machine. Nothing is fetched at question time.

Needs `git`, Python 3.10+ and, if QMD isn't already installed, Node.js 22+. Every Mac
has the first two; Node is at [nodejs.org](https://nodejs.org). The installer is a
bash script, so on Windows run it from WSL or Git Bash.

The corpus is [Ask Hormozi](https://github.com/poseljacob/ask-hormozi) by Jacob Posel,
used through a [fork](https://github.com/learnaiwithhugo/ask-hormozi) that carries two
small installer fixes (offered upstream). The transcripts are public YouTube captions;
rights stay with Alex Hormozi and MoreMozi.

## What's not inside, and why

The books themselves. The plugin ships notes, frameworks, short quoted passages with
page numbers, and the diagrams. It does not ship the text of the books. They're
copyrighted, they're excellent, and they cost about $10 each:
[acquisition.com/books](https://www.acquisition.com/books).

If you own them and want the "go deeper, what does the book actually say" behaviour,
drop your own chapter files into `books/<book>/source/` (see the README in each
`source/` folder). That folder is git-ignored so your copy stays yours.

Two chapters of Leads aren't covered (pp 5-14 and 252-253). Money Models has no
highlighted passages. The skill knows both and will tell you when it matters.

## How it answers

1. Reads the right `INDEX.md`, loads one or two notes files, never a whole book.
2. Answers as Alex: blunt, numbers first, diagnoses before it prescribes.
3. Quotes are verbatim with a page number or they aren't quotes. If the books don't
   cover it, it says so, searches the videos if they're installed, and only then
   answers from the principles.
4. Ends with one next action, not ten.
5. When a diagram explains it faster, it opens the diagram.
6. When the books are thin on something, or you ask to see him say it, it adds an
   **On camera** section with up to three timestamped clips. Page citations stay in
   the answer; clips stay in that section, so you can always tell which is which.

## Contributing

Corrections to the notes welcome. Do not open a PR that adds book text.

## Takedown

If you hold the rights to these books and want anything removed, open an issue and it
comes down.

## Licence

MIT for the notes, routing and code in this repo. The books are copyright Alex
Hormozi / Acquisition.com / Bumble IP, LLC.
