# Change Log

All notable changes to the **Monochrome Dew** theme will be documented in this file.

## [1.2.0] - 2026-09-07

### Changed
- Recolored the theme around three hue families on the unchanged near-black base: **blue** (structure: keywords, types, functions, modules, lifetimes), **pink** (data: strings, `self`/`this`, mutable variables), and **gold** (rare: numbers, booleans, enum members, macros, attributes, warnings)
- All hue families now share one lightness ramp (faint/dim/main/bright) with 28–45% saturation, replacing the previous ~15% tinted-gray accents
- Errors use an alarm pink `#db7698`; warnings use gold; diff and git decorations follow the family mapping (added = blue, deleted = pink, modified = gold)
- Workbench chrome stays neutral gray with blue as the single UI accent (links, focus border, buttons, progress bar); terminal ANSI red/yellow/blue/magenta aligned to the families
- Markdown headings moved from the blue hierarchy to a gold hierarchy

### Added
- `preview.html` — single-file palette preview with old/new comparison
## [1.1.0] - 2026-09-04

### Changed
- Replaced the extension icon with a new minimal dew-drop design
- Deepened all static workbench surfaces from `#18181c` to a uniform `#111113` while preserving interactive-state contrast
- Increased the contrast of ordinary variables and comment text without brightening structural punctuation
- Added restrained bold emphasis for control flow, structural declarations, and declaration names in C#, C++, Rust, and Python
- Corrected language-qualified semantic token selectors to use VS Code's `:language` syntax

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
