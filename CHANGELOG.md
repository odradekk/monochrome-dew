# Change Log

All notable changes to the **Monochrome Dew** theme will be documented in this file.

## [1.0.1] - 2026-04-10

### Changed
- New circular-masked icon with transparent background
- Simplified README Design section
- Added language screenshots to README

### Chore
- Excluded `scripts/` and `examples/` from the published package

## [1.0.0] - 2026-04-10

### Initial release

#### Foundation
- Dark theme derived from [Monochrome](https://marketplace.visualstudio.com/items?itemName=anotherglitchinthematrix.monochrome)
- Base background `#18181c` with subtle cool tint
- Three-layer color philosophy: **blue** (structure), **pink-gray** (data), **pure gray** (neutral)
- Blue-tinted near-white `#c8cdd6` for H1 headings and type declarations

#### Language-specific refinements
- **C#** — access modifiers, LINQ, attributes, XML doc comments
- **C++** — type system, `const`/`constexpr` hierarchy, operator overloads, preprocessor, templates
- **Rust** — traits, lifetimes, macros, `unsafe`, mutable variables visually distinguished via subtle pink tint
- **Python** — decorators, f-strings, docstrings, `self`/`cls`, type hints
- **Markdown** — H1-H6 blue brightness hierarchy, markers dimmed
- **JSON / TOML / YAML** — key vs. value color separation
- **HTML / CSS** — tags, attributes, selectors, properties, units, `!important`

#### Additional features
- Terminal ANSI colors with functional low-saturation hues
- Semantic token colors for all supported languages
- Increased error visibility (`#c08a90`)
- Refined comment color (`#4a5568`) for WCAG-acceptable contrast
