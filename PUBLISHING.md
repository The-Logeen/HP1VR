# GitHub publication checklist

[README](README.md) · [Page copy](MOD-PAGE.md) · [Licensing](LICENSE-STATUS.md)

## Current answer: prepared, not unconditionally cleared

The mod-only folder is technically packaged for distribution: it has an
installer, checked dependency links, file manifests and documentation, without
base-game packages, personal saves or the third-party texture/renderer downloads.
Public asset redistribution permission and a maintainer license decision are
still unresolved. Do not describe the entire package as legally cleared.

## Resolve before uploading

- [x] Supply the maintainer's public credit name (The-Logeen).
- [ ] Confirm authorship/redistribution permission for the custom assets in
  CREDITS.md, including geometry inside the probe binary. Keep permission records.
- [x] Select an appropriate license for maintainer-owned work (MIT); retain separate
  third-party notices. Do not apply a blanket license to other people's assets.
- [x] Decide whether this is a binary-only release or a separate source release
  (binary kit, public repository).
  This kit alone is not an open-source repository.
- [ ] Complete or clearly disclose the pending headset check for Hermione note
  readability and any newly discovered gameplay issues.
- [x] Update README/LICENSE-STATUS/CREDITS to reflect the actual decisions.
- [x] Reseal the package manifest after any kit modification and verify it.

## What to upload

Create a separate staging repository from **HP1 VR V31 Final Mod only**. Do not
initialize/publish the development workspace as a shortcut. Preserve the kit's
relative layout: installer scripts, configuration, payload, launcher, dependency
records, notices and documents. Put the README at repository root.

Never upload **HP1 VR V31 Final Playable**, **HP1 VR V31 Production**, Runtime,
personal calibration/saves, development test folders, original game packages,
texture-pack archives or downloaded renderer/runtime installers. A .gitignore
is only a convenience, not a content/rights audit, and does not untrack files
already committed. Inspect the exact staged file list before a first commit.

Use MOD-PAGE.md for About/description/release copy, CONTROLS.md and SETTINGS.md
for detailed play documentation, and TROUBLESHOOTING.md for support. Add actual
repository issue/release links once the repository exists. Do not invent URLs.

## Integrity and release process

The kit's package-manifest.json records installer payload/document hashes; setup
checks it before copying. Editing a listed README or script without updating the
manifest makes setup reject that kit. Repository-only metadata should not be
confused with a newly validated release archive.

Automated: every push runs `tools/Test-Kit.ps1` on GitHub Actions, and pushing a
tag such as `v31.0.0` builds `HP1-VR-V31-v31.0.0.zip` plus its `.sha256` with
`tools/Build-Release.ps1` and publishes them as a GitHub release. Locally, run
`tools\Build-Release.ps1` to produce the same ZIP in `dist\`.
After deliberately editing a listed file, run `tools\Update-Manifest.ps1` to reseal
the manifest; it re-runs the kit check.

For each release, use the project's release tooling to generate an updated
manifest, validate exact dependencies and perform an installation check. Review
the staged contents again, then archive the mod kit with its folder layout
intact. Publish the archive and its SHA-256 alongside release notes. A hash
detects corruption against a trusted reference; it is not a digital signature
or independent proof of authenticity.

Users should download a matched release archive, not combine changing files
from a branch with a manifest from another revision. Keep a versioned release
and changelog, describe any outstanding headset checks, and do not claim full
QA from CPU tests alone.

## Suggested pre-release smoke test

On a suitable VR setup, separately from offline installer tests:

- [ ] Fresh install and launch without clicking a console for focus.
- [ ] Both eyes, tracking, audio, desktop mirror and all bound controllers used.
- [ ] Open/close native and VR menus in both orders; verify pause/audio recovery.
- [ ] Calibrate upright; walk, turn and use a valid ledge; NPCs not climbable.
- [ ] Lesson runes, contextual casting and eligible Wingardium manipulation.
- [ ] Broom neutral, pitch responsiveness, height/pivot sync and catching scene.
- [ ] Flute, both cracker throw modes and all selected potion modes.
- [ ] Final potion drinking, correct fire progression and wrong-choice behavior.
- [ ] HUD fades/rolling events, wrist placements and legible Hermione note.
- [ ] Save/reload, boss restart from a real save and main-menu Exit Game.

Stop and collect logs on a crash; do not repeat a whole-PC/SteamVR crash loop.
Publication is a separate explicit action. Preparing these documents does not
create a repository or upload any files.
