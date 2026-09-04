# Project guidance

## Theme changes

After changing theme colors or token styles, validate them in VS Code's Extension Development Host:

1. Run the `Preview Monochrome Dew` configuration from `.vscode/launch.json` (`F5`).
2. In the development-host window, select `Monochrome Dew` with `Ctrl+K Ctrl+T`.
3. Enable semantic highlighting and inspect representative C#, C++, Rust, and Python files.
4. After each theme edit, run `Developer: Reload Window` in the development-host window.
5. Confirm that static workbench surfaces are visually consistent, interaction states remain distinguishable, and readable text has sufficient contrast.
6. Confirm that bold styling marks only the intended control flow, structural declarations, and declaration names; calls, references, local bindings, and literals remain regular weight.
7. For any mismatch, run `Developer: Inspect Editor Tokens and Scopes` on the affected token and adjust the narrowest matching TextMate or semantic-token selector.

Visual acceptance requires all four languages to pass these checks without unintended bold or low-contrast readable text.

## Releases

When preparing, publishing, retrying, or verifying a release, follow [RELEASING.md](RELEASING.md). It is the source of truth for packaging, persisted marketplace credentials, GitHub releases, registry publication, and acceptance.
