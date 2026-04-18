# AGENTS.md -- plankton TikZ library

## Project overview

plankton is a LaTeX/TikZ library for drawing architectural floor plans
and site plans. It ships as a `.dtx`/`.ins` bundle that produces six
`.sty` packages.

## Directory structure

```
tikz-plankton/
  plankton.dtx          # literate source (docs + code for all 6 packages)
  plankton.ins          # docstrip installer
  Makefile
  README.md
  LICENSE               # LPPL 1.3c
  AGENTS.md             # this file
  CHANGELOG.md
  .gitignore
  examples/
    apartment-base.tex
    apartment-iec.tex
    apartment-us.tex
    complete-iec.tex
    complete-us.tex
    site-plan.tex
```

## Build commands

```bash
make sty        # extract .sty files from .dtx via .ins
make doc        # build plankton.pdf (3-pass pdflatex + makeindex)
make examples   # compile all example PDFs
make all        # sty + doc + examples
make ctan       # create plankton.zip for CTAN upload
make clean      # remove all generated files
```

## Compile a single example

```bash
cd examples
TEXINPUTS=".:..:" pdflatex -interaction=nonstopmode -halt-on-error apartment-iec.tex
```

The `TEXINPUTS=".:..:"` ensures pdflatex finds the `.sty` files in the
parent directory.

## How the .dtx works

`plankton.dtx` is a single literate source file. It contains:

1. **Driver block** (`%<*driver>` ... `%</driver>`) -- the LaTeX document
   that produces the documentation PDF when you run `pdflatex plankton.dtx`.

2. **User documentation** -- everything between the driver and
   `\StopEventually`. Written in `ltxdoc` format with `\DescribeMacro`
   entries for each user command.

3. **Implementation** -- the actual package code, wrapped in:
   - **Docstrip guards**: `%<*base>` ... `%</base>` (one per package)
   - **macrocode environments**: `\begin{macrocode}` ... `\end{macrocode}`

When `latex plankton.ins` runs, docstrip reads the `.dtx` and extracts
only the lines inside each guard block (stripping the leading `%`),
producing the corresponding `.sty` file.

### What to edit where

- **To change package code**: edit inside the `macrocode` environments
  within the appropriate guard block.
- **To change documentation**: edit the text outside `macrocode`
  environments, before `\StopEventually`.
- **To add a new package**: add a new guard block, update `.ins`, and
  add documentation sections.

## Package architecture

| Package | Guard | Options | Color | Macro prefix |
|---------|-------|---------|-------|-------------|
| plankton-base | `base` | `units=metric\|imperial` | black | `\floor*`, `\fp@*` |
| plankton-electrical | `electrical` | `standard=iec\|us` | `blue!70!black` | `\floor*`, `\fp@elec*` |
| plankton-plumbing | `plumbing` | `standard=iso\|us` | `cyan!60!black` | `\floor*`, `\fp@plumb*` |
| plankton-hvac | `hvac` | `standard=iec\|us` | `fp@hvaccolor` (RGB 51,102,51) | `\floor*`, `\fp@hvac*` |
| plankton-furniture | `furniture` | none | `fp@furncolor` (RGB 102,68,34) | `\floor*`, `\fp@*` |
| plankton-site | `site` | none | `fp@sitecolor` (RGB 34,102,34) | `\floor*`, `\fp@*` |

## How to add a new macro

1. **Define keys** (if the macro has options):
   ```latex
   \define@key{floornewmacro}{option}{\def\fp@newoption{#1}}
   ```

2. **Define the command**:
   ```latex
   \newcommand{\floornewmacro}[3][]{%
     \begingroup
     \def\fp@newoption{default}%
     \setkeys{floornewmacro}{#1}%
     \begin{scope}[shift={(#2)}, rotate=#3]
       % drawing code
     \end{scope}
     \endgroup
   }
   ```

3. **Add documentation** before `\StopEventually`:
   ```latex
   \DescribeMacro{\floornewmacro}
   |\floornewmacro[|\meta{options}|]{|\meta{x,y}|}{|\meta{rotation}|}|
   ```

4. **Add to an example** in `examples/`.

## How to add a new example

1. Create `examples/my-example.tex`.
2. Use `\documentclass[border=1cm]{standalone}`.
3. Load the needed `plankton-*` packages.
4. Compile: `cd examples && TEXINPUTS=".:..:" pdflatex my-example.tex`

## Naming conventions

- **User macros**: `\floor*` (e.g. `\floorwall`, `\floordoor`)
- **Internal macros**: `\fp@*` (e.g. `\fp@wallthickness`, `\fp@elecscale`)
- **Key families**: `floor*` (e.g. `floorwall`, `floordoor`)
- **Conditionals**: `\iffp@*` (e.g. `\iffp@imperial`, `\iffp@elecus`)

## LaTeX gotchas

- **OT1 encoding** (default in standalone): `\textquotedbl` and
  `\textquotesingle` are NOT available. Use `''` for double quotes
  and `'` for single quotes in text nodes.

- **xcolor mixing**: never write `\somemacro!N` where `\somemacro`
  expands to a mixed color like `gray!50`. Use `\colorlet` to create
  a named color first, or use opacity.

- **TikZ decorations**: the `bumps` decoration does NOT exist. Use
  `snake` from `decorations.pathmorphing` for wavy edges.

- **Font size warnings**: messages like `cmr/bx/n size 4 substituted
  by 5` are harmless and can be ignored.
