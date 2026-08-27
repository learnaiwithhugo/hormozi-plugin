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
```

Offers is what you sell. Leads is who you sell it to. Money Models is the order you
sell it in. Real questions usually touch more than one, and the skill reads across them.

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
   cover it, it says so and answers from the principles anyway.
4. Ends with one next action, not ten.
5. When a diagram explains it faster, it opens the diagram.

## Contributing

Corrections to the notes welcome. Do not open a PR that adds book text.

## Takedown

If you hold the rights to these books and want anything removed, open an issue and it
comes down.

## Licence

MIT for the notes, routing and code in this repo. The books are copyright Alex
Hormozi / Acquisition.com / Bumble IP, LLC.
