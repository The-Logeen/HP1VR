# October 18 candidate validation

Completed locally:

- Built matched x86 host/probe/renderer proxy and x64 compositor. CPU bridge 45; GPU protocol unchanged at 28.
- 25 test programs passed: calibration menu, bridge/persistence, new aim math, wand ownership, Wingardium ray/hold, lesson projection/continuity/catalogue, menu pointer/filter/policy/shape, settings writer, broom controls/grips, flight catch, avatar pose, movement facing/strafe, scene agency, climb policy/safety, eye copying and readback ordering.
- New aim test covers 8,281 pitch/yaw pairs, orthonormality, unchanged translation, exact zero/default compatibility, axis signs, independent menu adjustments, snapshot transfer and persisted settings.
- Rendered the expanded aim category and inspected its labels/values; this is not an in-headset interaction test.
- PowerShell parsing and Windows PowerShell 5.1 GUI construction checks passed. Actual dependency preflight resolved the compatible HP1 game, HP1 renderer and ESRGAN v3; missing inputs produced component-specific failures.
- Full isolated installation succeeded: 2,537 DDS textures copied, originals untouched. No game/headset was launched by this check.

Still required: Frame hardware pointing/casting, full menu interaction, spell lessons and Wingardium with nonzero calibration, existing-controller regression, and headset acceptance of the rebuilt runtime. Follow FRAME-CONTROLS.md. Publish as a prerelease, not as a newly headset-certified stable build.

No original HP1 development/runtime folder or previous release package was edited. Local source/build artifacts and private installation tests are outside this mod-only release folder; do not upload neighboring folders.
