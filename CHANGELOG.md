# Changelog

All notable changes to the plankton TikZ library will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Fixed
- `\plandimension`: `offset` is now a distance in plan units (or an
  explicit length such as `3mm`) instead of a fraction of the measured
  length, so dimension lines sit at the same distance regardless of size.

### Added
- `\planlabel` accepts optional node options, e.g. `[font=\tiny]`.
- `make test` target and regression tests in `tests/`, run in CI.

## [0.2.0] - 2026-04-18

### Changed
- Renamed all user-facing macros from `\floor*` to `\plan*`
  (e.g. `\floorwall` is now `\planwall`).
- Renamed internal macro prefix from `\fp@*` to `\plan@*`
  (e.g. `\fp@wallthickness` is now `\plan@wallthickness`).
- Key families renamed accordingly (`floorwall` -> `planwall`, etc.).

### Added
- Showcase site (`docs/index.html`) with SVG previews of all examples.
- GitHub Actions CI workflow (`.github/workflows/ci.yml`).
- `make svgs` target for generating SVG previews via dvisvgm.

## [0.1.0] - 2026-04-18

### Added
- Initial release of the plankton TikZ floor plan library.
- **plankton-base**: Walls, wall paths, rooms, labels, doors, windows, stairs,
  dimensions, and scale indicators. Supports `units=metric|imperial`.
- **plankton-electrical**: Outlets, switches, light fixtures, electrical panels,
  and wiring runs. Supports `standard=iec|us`.
- **plankton-plumbing**: Sinks, toilets, bathtubs, showers, shutoff valves,
  supply lines, and drain lines. Supports `standard=iso|us`.
- **plankton-hvac**: Diffusers, ducts, thermostats, exhaust fans, dampers,
  and mini-splits. Supports `standard=iec|us`.
- **plankton-furniture**: Beds, tables, chairs, sofas, stoves, fridges,
  desks, and shelving units. Drawn at real-world scale (1 unit = 1 m).
- **plankton-site**: Trees, shrubs, hedges, lawns, garden beds, patios,
  walkways, driveways, fences, retaining walls, pools, ponds, utility lines,
  utility poles, property boundaries, and building setbacks.
- Six example documents demonstrating all packages.
- CTAN-ready `.dtx`/`.ins` distribution format.
