# Monochrome Dew

[![Version](https://img.shields.io/visual-studio-marketplace/v/odradekk.monochrome-dew?style=flat-square&label=Marketplace&color=18181c)](https://marketplace.visualstudio.com/items?itemName=odradekk.monochrome-dew)
[![Installs](https://img.shields.io/visual-studio-marketplace/i/odradekk.monochrome-dew?style=flat-square&color=8a9dbc)](https://marketplace.visualstudio.com/items?itemName=odradekk.monochrome-dew)
[![Rating](https://img.shields.io/visual-studio-marketplace/r/odradekk.monochrome-dew?style=flat-square&color=b0969c)](https://marketplace.visualstudio.com/items?itemName=odradekk.monochrome-dew&ssr=false#review-details)
[![Open VSX](https://img.shields.io/open-vsx/v/odradekk/monochrome-dew?style=flat-square&label=Open%20VSX&color=18181c)](https://open-vsx.org/extension/odradekk/monochrome-dew)
[![License](https://img.shields.io/github/license/odradekk/monochrome-dew?style=flat-square&color=8d8d8d)](./LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/odradekk/monochrome-dew?style=flat-square&color=c8cdd6)](https://github.com/odradekk/monochrome-dew/stargazers)

> A dark VS Code theme that extends **Monochrome Dark** with restrained blue and pink-gray accents — like morning dew on a gray stone.

Monochrome Dew keeps the calm, distraction-free gray foundation of [Monochrome](https://marketplace.visualstudio.com/items?itemName=anotherglitchinthematrix.monochrome) and adds the smallest amount of color necessary to create a semantic hierarchy — blue for structure, pink-gray for data, pure gray for the rest.

---

## Screenshots

<!-- Add your screenshots here -->
_Screenshots coming soon._

---

## Design Philosophy

Monochrome Dew is built on three color families layered over a near-black base (`#18181c`):

| Role | Color family | Used for |
|------|--------------|----------|
| **Structure / Control** | Blue `#6a7d99` → `#c8cdd6` | Keywords, types, functions, modules, declarations |
| **Data / Values** | Pink-gray `#907a82` → `#baa0a6` | Strings, numbers, constants, literals |
| **Neutral** | Pure gray `#555555` → `#aaaaaa` | Variables, operators, punctuation, comments |

The palette is intentionally **desaturated**: pink sits at ~15% saturation (reads as "tinted gray" rather than pink), blue sits at ~20% (reads as "cool gray" with just enough presence to carry semantic meaning). On a dark gray base, this creates a calm, minimally decorated appearance without becoming a pure black-and-white monochrome.

The brightest color in the theme — `#c8cdd6` (H1 headings and type declarations) — is a **blue-tinted near-white**, so the most important identifiers feel bright rather than colored.

---

## Language-Specific Refinements

Dedicated TextMate scopes and semantic token rules for:

### C# (178+ rules)
- Access modifiers (`public`/`private`/`protected`) visually dimmed
- LINQ query keywords distinguished from control flow
- XML doc comments as a separate brightness layer
- Attributes, generics, and preprocessor directives each in their own tier

### C++
- Built-in types (`int`, `auto`, `size_t`) separated from user types
- `const`/`constexpr`/`consteval` modifier hierarchy
- Operator overloads, destructors, cast operators distinctly colored
- Preprocessor directives and `#include <headers>` isolated
- Template angle brackets `<>` in dim blue

### Rust
- **Mutable variables visually distinguished** from immutable via subtle pink tint
- Traits in italic blue, distinct from structs
- Lifetimes (`'a`, `'static`) in their own pink-gray color
- Macros (`println!`) bold for visual anchoring
- `unsafe` blocks highlighted in bold

### Python
- Decorators dimmed so they don't overpower function definitions
- f-string interpolation braces `{}` highlighted in blue
- Docstrings (`"""..."""`) in their own darker tier
- `self`/`cls` parameters distinctly colored
- Type hints separated from regular identifiers

### Markdown
- H1 → H6 blue brightness hierarchy (brightest at H1)
- `**`/`*`/`#` markers dimmed to retreat from content
- Inline code, fenced code blocks, and links each colored by purpose

### JSON / TOML / YAML
- Key vs. value color separation (keys blue, strings pink-gray)
- TOML `[table]` headers highlighted
- YAML anchors/aliases dimmed

### HTML / CSS
- Tags, attributes, and values in distinct tiers
- CSS selectors, properties, and values separated
- `!important` in the error color to stand out

---

## Installation

### From VS Code Marketplace (Official VS Code)

1. Open the Extensions view (`Ctrl+Shift+X` / `Cmd+Shift+X`)
2. Search for `Monochrome Dew`
3. Click **Install**
4. Open Command Palette (`Ctrl+K Ctrl+T`) and select **Monochrome Dew**

### From Open VSX (VSCodium, Cursor, Gitpod, code-server)

```bash
# Command line
ovsx install odradekk.monochrome-dew

# Or search "Monochrome Dew" in your editor's extensions panel
```

### Manual Install (.vsix)

1. Download the latest `.vsix` from the [releases page](https://github.com/odradekk/monochrome-dew/releases)
2. Install via command line:
   ```bash
   code --install-extension monochrome-dew-1.0.0.vsix
   ```
   Or in VS Code: Command Palette → **Extensions: Install from VSIX...**

---

## Recommended Settings

For the full Monochrome Dew experience, pair it with these settings:

```jsonc
{
    // The theme is built for monospace code fonts with good ligature support
    "editor.fontFamily": "'Iosevka', 'JetBrains Mono', monospace",
    "editor.fontLigatures": true,

    // The theme's background is #18181c — these related settings look best
    "editor.renderLineHighlight": "line",
    "editor.bracketPairColorization.enabled": false,
    "editor.guides.bracketPairs": false,

    // Semantic highlighting is required for full C#/C++/Rust/Python refinement
    "editor.semanticHighlighting.enabled": true
}
```

---

## Credits & Acknowledgements

Monochrome Dew is built on the shoulders of other excellent work:

- **[Monochrome](https://marketplace.visualstudio.com/items?itemName=anotherglitchinthematrix.monochrome)** by anotherglitchinthematrix — the color philosophy and base UI palette come from this theme. Monochrome Dew is a derivative work that adds blue/pink-gray accents and extensive language-specific refinements while preserving Monochrome's calm foundation.
- **[eppz! Code](https://github.com/Geri-Borbas/VSCode.Extension.eppz_Code)** by Geri Borbás — the scope-matching patterns for C# (punctuation tiers, property accessors, type declarations vs. references) were inspired by this theme's fine-grained approach.

Not affiliated with or endorsed by either project — this is an independent reinterpretation.

---

## Contributing

Issues and pull requests welcome at [github.com/odradekk/monochrome-dew](https://github.com/odradekk/monochrome-dew).

When reporting a visual issue, please include:
- The language and a minimal code sample
- A screenshot
- Whether you have semantic highlighting enabled

---

## License

[MIT](./LICENSE) © odradekk
