# V31 release history

[README](README.md)

## October 18, 2026 — Steam Frame bindings and independent aiming

- Explicit Steam Frame profile; existing Touch/Index/Vive binding files unchanged.
- Controller Aim / Frame category: independent wand pitch/yaw, pointer yaw and existing pointer pitch; aim-only reset and saved settings. Old pointer pitch/default retained.
- Wand calibration shared by visible shaft, spell direction, spell-lesson tip and Wingardium aiming. Raw tracking, holster position and movement unchanged.
- Matched runtime rebuilt; CPU bridge incremented to 45, GPU transport remains 28. Do not mix runtime binaries across releases.
- Installer component table, row-specific repair advice, explicit original-texture fallback, Open installed folder and smaller-screen scrolling. Detailed diagnostics and dependency hash checks retained.
- Process-only PowerShell execution policy in Install.cmd. No persistent policy or antivirus changes.
- New FRAME-CONTROLS.md, VALIDATION.md and SETUP-GUIDE.html, copied to the installation.
- Side-by-side installation only. HP1 save/settings transfer is documented manual copying.

See VALIDATION.md. This is a prerelease until headset and Frame acceptance.

## October 13, 2026 — installer diagnostics

Added persistent per-operation logs, live progress, Open full log/Copy result
details controls, bootstrap failure reporting, stage/operation context, full
PowerShell exception records, actionable error codes, expected/actual file
hashes and verified per-file copies. Logs stay outside the distributable kit;
no telemetry or automatic upload. Game binaries and gameplay are unchanged.

## October 11, 2026 — consistent V31 runtime names

Launcher, compositor, host, staged probe, startup/renderer/calibration filenames
and controller binding filenames now use V31. Existing calibration values and
saves are preserved. Missing-file messages now recommend package repair rather
than telling release users to run an unavailable V30 build script. Engine-required
unversioned DLL names and the internal calibration schema remain unchanged.

## October 7, 2026 — consolidated V31 release snapshot

This is a consolidated description of the current work, not a claim that all
systems were introduced on this date. Internal V30 filenames remain for binary
and configuration compatibility. The packaged executable build is unchanged by
this documentation update.

### VR foundation and visuals

- Tracked stereoscopic world view, controller input and a desktop mirror path.
- Stable stereo output and procedural-effect compatibility work for water and
  mirror content; retained material/stereo protections rather than enabling a
  separate experimental GPU test build.
- Supported external DX11 1.6.2 / ESRGAN v3 installation and adjustable sharpness.
- Isolated launch/configuration, focus handling and normal quit integration.

### Movement, body and scenes

- Analog movement, smooth/snap turning, stair smoothing and wall protection.
- Native ledge traversal adaptations; global character-pawn climb exclusion and
  extra guards for the final potion table.
- Optional tracked Harry body, visual knee bending and independent eye height,
  body scale, hip offset and head-forward calibration.
- Cinematic Body, Free Movement and Free + Guide modes; old automatic nudge
  replaced by guidance. Cinematic cameras remain a separate preference.
- Final potion scene movement/turning and room-retention corrections.

### Spells and physical gameplay

- Spell-specific lesson runes, selectable drawing hand and tunable assistance.
- Contextual wand casting and hold-trigger Wingardium manipulation.
- Four broom steering modes, pitch/control tuning, one-hand continuation,
  synchronized broom/pivot height and native-eligible reaching/catching support.
- Flute grip/face/trigger interaction and default hip stow.
- Optional grip potion selection with native wrong-choice results; third mode
  additionally requires the final correct potion to be brought to the face.
- Stabilized held potion pose and correct-success progression handling.
- Grounded wizard cracker grip pickup, native-arc trigger throw or optional
  physical swing/grip-release throw.

### Menus, HUD and quality of life

- VR menu pause ownership, audio recovery and complete HP1-session quit handling.
- Relevance-based health/bean fading with rolling event timers and scene hiding.
- UI placement catalog, wrist anchors, supported counter scaling and optional
  body-mode dialogue position/scale controls.
- Left-hand Hermione reminder plane; latest text readability change still
  awaiting headset acceptance.
- Animation/log-noise cleanup and scene-specific compatibility fixes.

### Packaging and documentation

- Separate private playable snapshot and small mod-only distribution kit.
- Button-driven setup with exact dependency links and folder pickers.
- Input/payload SHA-256 validation, protected original folders, empty-destination
  requirement, portable runtime paths and no personal saves in the mod kit.
- Full README, controls/settings guides, troubleshooting, credits, release copy
  and publication checklist.

### Verification and limits

58 CPU regression checks passed for the packaged build. Offline installation,
hash integrity, damaged-payload rejection and source-folder safety were checked.
These are not exhaustive end-to-end headset tests.
