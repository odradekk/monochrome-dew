# Release SOP

Run this procedure only after the user authorizes the release and its external writes. `VSCE_PAT` and `OVSX_PAT` are already persisted in the Windows User environment; load them without printing their values. PAT provisioning is not part of a release.

## 1. Prepare and commit

1. Choose the next semantic version. Update `package.json`, `CHANGELOG.md`, and any versioned installation example in `README.md`.
2. If theme visuals changed, complete the visual acceptance checks in `AGENTS.md`.
3. Confirm `generated-images/` is ignored by Git and `.vscodeignore`.
4. Commit and push only the release changes.

This stage is complete when `git status --short --branch` shows `main` synchronized with `origin/main`.

## 2. Build the canonical artifact

From the repository root, build one VSIX and inspect its actual contents:

```powershell
$releaseVersion = (Get-Content -Raw package.json | ConvertFrom-Json).version
$releaseVsix = "monochrome-dew-$releaseVersion.vsix"
vsce package --out $releaseVsix
tar -tf $releaseVsix
Get-FileHash -Algorithm SHA256 $releaseVsix
```

The archive must exclude `generated-images/`, agent documents, `.vscode/`, local scripts, Git metadata, and earlier VSIX files. Use this exact artifact for every remaining step.

## 3. Create the GitHub release

```powershell
$releaseVersion = (Get-Content -Raw package.json | ConvertFrom-Json).version
$releaseVsix = "monochrome-dew-$releaseVersion.vsix"
git tag -a "v$releaseVersion" -m "Release v$releaseVersion"
git push origin "v$releaseVersion"
gh release create "v$releaseVersion" $releaseVsix --title "v$releaseVersion" --generate-notes
```

This stage is complete when the annotated tag is on the release commit and the GitHub release contains the canonical VSIX.

## 4. Publish both registries

Load the persisted credentials into the current process, then publish the canonical VSIX:

```powershell
$releaseVersion = (Get-Content -Raw package.json | ConvertFrom-Json).version
$releaseVsix = "monochrome-dew-$releaseVersion.vsix"
$env:VSCE_PAT = [Environment]::GetEnvironmentVariable('VSCE_PAT', 'User')
$env:OVSX_PAT = [Environment]::GetEnvironmentVariable('OVSX_PAT', 'User')
if ([string]::IsNullOrWhiteSpace($env:VSCE_PAT) -or [string]::IsNullOrWhiteSpace($env:OVSX_PAT)) {
    throw 'Persisted marketplace credentials are unavailable.'
}
vsce publish --packagePath $releaseVsix
ovsx publish $releaseVsix
```

If either result is ambiguous or unsuccessful, inspect the registry before retrying so the same version is not submitted twice.

## 5. Verify acceptance

```powershell
$releaseVersion = (Get-Content -Raw package.json | ConvertFrom-Json).version
gh release view "v$releaseVersion"
(vsce show odradekk.monochrome-dew --json | ConvertFrom-Json).versions[0].version
(ovsx get odradekk.monochrome-dew --metadata | ConvertFrom-Json).version
git status --short --branch
```

The release is accepted when both publish commands succeeded, GitHub holds the matching VSIX, generated assets are absent from Git and the archive, and `main` is clean and synchronized. Registry metadata can temporarily show the previous version while indexes propagate; report propagation separately from publishing success.
