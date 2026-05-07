# pytyper

ALE linter that checks Python function definitions for missing type annotations.

## What it checks

For every `def` and `async def`, pytyper warns about:

- Missing return type (`-> type`)
- Untyped parameters (missing `: type`)

Parameters that are never flagged: `self`, `cls`, `*args`, `**kwargs`, `*`, `/`.

## How it works

Implemented as a native ALE linter. ALE feeds the buffer contents through
`cat` and the callback parses the output in vimscript — no external tool
required. Warnings appear in the gutter, as inline virtual text, and in the
location list, alongside other ALE linter results.

Handles multi-line signatures, `async def`, and nested brackets in defaults.

## Requirements

- [ALE](https://github.com/dense-analysis/ale)
- [vim-pathogen](https://github.com/tpope/vim-pathogen)
