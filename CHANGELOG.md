# V31 release history

[README](README.md)

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
