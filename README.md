# plankton

TikZ macros for architectural floor plans and site plans.

**[Live showcase](https://jlswea.github.io/tikz-plankton/)** with SVG previews of all examples.

## What it is

**plankton** is a collection of six LaTeX/TikZ packages for drawing
professional-quality floor plans and site plans:

| Package | Purpose | Options |
|---------|---------|---------|
| `plankton-base` | Walls, doors, windows, stairs, dimensions | `units=metric\|imperial` |
| `plankton-electrical` | Outlets, switches, lights, panels, wiring | `standard=iec\|us` |
| `plankton-plumbing` | Sinks, toilets, tubs, showers, supply/drain lines | `standard=iso\|us` |
| `plankton-hvac` | Diffusers, ducts, thermostats, exhaust fans, dampers | `standard=iec\|us` |
| `plankton-furniture` | Beds, tables, chairs, sofas, stoves, fridges, desks | -- |
| `plankton-site` | Trees, fences, pools, walkways, utilities, boundaries | -- |

All packages default to IEC/ISO symbol standards. US symbols are
available via the `standard=us` option. Scale convention: **1 TikZ
unit = 1 metre**.

## Quick install

```bash
latex plankton.ins          # extract .sty files from .dtx
```

Copy the six `.sty` files to a directory in your TeX search path
(e.g. `texmf-local/tex/latex/plankton/`) and run `mktexlsr`.

## Quick start

```latex
\documentclass[border=1cm]{standalone}
\usepackage{plankton-base}
\usepackage{plankton-electrical}
\usepackage{plankton-plumbing}
\usepackage{plankton-hvac}
\usepackage{plankton-furniture}
\usepackage{plankton-site}

\begin{document}
\begin{tikzpicture}[x=1cm, y=1cm]
  % Walls
  \planwall{0,0}{6,0}
  \planwall{6,0}{6,4}
  \planwall{6,4}{0,4}
  \planwall{0,4}{0,0}

  % Door and window
  \plandoor{1,0}{0}
  \planwindow{2,4}{4,4}

  % Label
  \planlabel{3,2}{Room}
\end{tikzpicture}
\end{document}
```

## Examples

| File | Description |
|------|-------------|
| `examples/apartment-base.tex` | Basic apartment with base, electrical, and plumbing layers |
| `examples/apartment-iec.tex` | Apartment with all layers using IEC/ISO symbols |
| `examples/apartment-us.tex` | Apartment with all layers using US symbols |
| `examples/complete-iec.tex` | Full house with site plan, IEC/ISO symbols |
| `examples/complete-us.tex` | Full house with site plan, US symbols |
| `examples/site-plan.tex` | Standalone site plan with all site elements |

## Documentation

Full documentation is built from the `.dtx` source:

```bash
make doc    # or: pdflatex plankton.dtx (three passes)
```

## Building

```bash
make sty        # extract .sty files
make doc        # build documentation PDF
make examples   # compile all example PDFs
make all        # all of the above
make svgs       # generate SVG previews in docs/img/
make ctan       # create plankton.zip for CTAN upload
make clean      # remove generated files
```

## License

This work is licensed under the
[LaTeX Project Public License, version 1.3c](https://www.latex-project.org/lppl.txt)
or later.
