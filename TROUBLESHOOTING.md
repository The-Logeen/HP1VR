# Troubleshooting and known limitations

[README](README.md) · [Controls](CONTROLS.md) · [Settings](SETTINGS.md)

## What has actually been checked

The packaged V31 binaries passed 58 CPU regressions before packaging. Release
checks cover hashes, required input versions, a complete offline installation,
portable paths, rejection of damaged payloads and protection of existing source
folders. Those checks are not a substitute for playing every scene in a headset.
No universal GPU, driver, controller or regional-game compatibility is promised.
The latest Hermione note readability change still needs in-headset confirmation.

## Setup cannot find or accept a dependency

- Select the game folder containing **System** and **Maps**, not System itself.
- Extract the renderer archive; select the folder containing **Common** and
  **Harry Potter 1**. Only the supported HP1 1.6.2 files pass validation.
- Extract ESRGAN v3; select the folder containing **System** and **Textures**.
- A ZIP/7z archive is not an extracted folder. Use the exact pages in the README.
- VC++ 2010 must include **x86**, even on 64-bit Windows. Modern VC++ runtimes
  do not replace it. DirectX June 2010 needs DXSETUP after extraction.
- Keep the destination new/empty and outside the game, dependencies and kit.
- A hash mismatch is meaningful: keep the named filename and error text. Do not
  bypass the check or mix similarly named DLLs from different game renderers.
- Setup reads paths as UTF-8, including accented texture filenames. Re-extract a
  damaged/incomplete pack if its exact file names or hashes differ.

Download buttons open websites; they do not install dependencies automatically.
The setup is unsigned. Do not disable antivirus globally or install random
DLL-download-site files. If security software flags a file, retain the report
and verify the download before proceeding.

If installation stops after copying starts, originals remain untouched. Partial
output is left for inspection. Retry into another empty folder. The installer
will not silently overwrite an existing installation.

## Launch, blank desktop window or no headset image

1. Confirm another SteamVR application works with the headset and controllers.
2. Launch **Launch-HP1-VR-V31.exe**, not HP.exe or the host executable directly.
3. Keep Runtime beside the launcher and the configured Runtime path intact.
4. Check the logs below before repeating a failed launch.

The VR output and desktop mirror are different paths. A white desktop window
does not alone identify the failure. Report whether the headset is also blank,
whether audio continues and whether the mirror ever displayed an image. Launch
focus and mirror handling are implemented, but unusual window/headset stacks
still need actual device testing.

## Code 7, game crash or critical SteamVR error

Code 7 means the run did not finish cleanly; it does **not** by itself mean
SteamVR failed. Open `Runtime/VR/compositor.log` and inspect its final `hostExit=`
entry. Then inspect the end of `Runtime/System/HP1VRHost.log`.

| Result | Interpretation |
|---|---|
| `hostExit=0` | Host reported a normal exit; inspect surrounding shutdown messages if the session still failed |
| `hostExit=3221225477` | Windows access violation (0xC0000005), a game/host-side crash |
| Another nonzero value | Preserve the exact code and surrounding log; do not guess its meaning |
| No final entry | Incomplete logging or abrupt termination; report that too |

For a SteamVR critical error include SteamVR's own error number/report as well.
For a whole-PC restart/lockup, distinguish it from a game closing and retain
Windows reliability/event information. Stop repeated crash loops. Do not assume
an application exception proves a GPU-driver or hardware cause.

Procedural water/mirror compatibility guards are included, but a new mirror,
wet texture or menu-close crash is still a bug worth reporting. Include the map,
object, spell/action and whether both eyes showed an artifact first.

## Fuzzy image, sparkling windows or GPU stalls

- Verify the supported texture pack was installed; the mod kit itself does not
  contain it. Upscaling cannot make every face true native 4K.
- Begin with SteamVR global and per-app resolution at 100%. Compare the actual
  requested dimensions before increasing any resolution setting.
- Test `WorldSize=1024` versus default 1280 with the game closed between edits.
  Higher resolution is a cost, not a universal quality/performance improvement.
- Adjust World sharpness modestly. Excess sharpening can accentuate shimmer.
- Keep the stable default projection/stereo options. Do not enable diagnostic
  off-axis, reversed-eye or yaw-only modes as a general quality upgrade.
- Compare one scene at a time and report CPU/GPU frametime, headset refresh,
  SteamVR settings and whether reprojection is active if you can measure them.
- For flickering stained glass, identify the exact window and whether one eye
  differs. Per-material problems should not be hidden by indiscriminately
  changing the entire renderer.

This is an old game running through a VR adaptation and a separate renderer;
its release year does not guarantee modern VR frame budgets. No maximum-detail
setting is guaranteed safe on every modern GPU.

## Controls, scenes and interactions

**VR menu:** Touch Y + right grip; other controllers use the bound menu action.
Check the bundled SteamVR bindings. Close overlays that may consume inputs.
The VR menu pauses the game; if it resumes into silence or remains paused,
report which menu opened first and the precise order of closing them.

**Audio:** Choose the intended headset playback device before launch. Report
music and effects separately and whether the problem starts after the native
menu, VR menu, focus loss or a cinematic. Do not repeatedly switch devices while
trying to isolate the cause.

**Potions:** Fresh installs default to Flipendo-only. Choose Grip or Flipendo,
or Grip plus final drink in VR settings to enable the physical route. Use a free
hand and grip near the eligible bottle. In the third mode, the final correct
bottle must be held at your face for the drink interval; a grip alone is not
completion. Wrong bottles retain native failure behavior. Report the round,
hand, active mode and whether the bottle attached to the hand.

**Wizard crackers:** Grip a nearby grounded eligible cracker with a free hand;
native bump pickup is also supported. Default mode throws with trigger. Physical
mode throws by swinging and releasing grip. Airborne crackers still follow the
native hazard rules; arbitrary airborne pickup is not promised.

**Flute:** Hold grip, bring the flute to your face, then trigger. A face-position
check is intentional. Taking damage need not make you lose an actively gripped
flute, but you may need to restart playing. Release grip to stow it.

**Broom catching:** Native catch eligibility must be active. Reach with a free
hand with its grip released; the action-button fallback remains available.
Remembrall chase success is not a test of snitch-catching behavior.

**Progress/guide dot:** Step into the expected area; do not grab the marker.
Free movement does not bypass objectives. If a scene only advances after
switching to Cinematic Body, report the exact scene and marker. That is not an
intended requirement to keep switching modes.

**Height/climbing:** Recenter upright, then tune eye/body/hip separately.
Character pawns must never become climb targets. Final-potion-table climbing,
repeated bump/grunt sounds or forced turning there should be reported as bugs.

**Boss restart:** Use an actual save book before a boss. A test launch or run
without an appropriate save may not have a normal checkpoint to reload. Keep a
pre-fight save for reproduction rather than assuming the restart was verified.

## HUD and notes

Counters intentionally hide during dialogue/cinematics. Repeated gains extend
their visible time. Select the correct element in UI Layout before adjusting;
not every UI uses the same slot. Most UI remains native-size: scaling currently
applies to health, beans and Body-mode Messages, not every catalog entry.

Wrist placement follows a hand anchor; it is not a universal 3D physical panel.
Hermione's reminder page is a dedicated left-hand plane. If unreadable, report
whether the paper, text or both are mirrored, the active hand pose and a headset
capture if available. Its latest text change has not yet received headset sign-off.

## Saves, upgrades and uninstall

Close the game before copying saves. Back up `Runtime/Save` and
`Runtime/VR/V31Calibration.ini`. Install upgrades into a new empty destination;
migrate `Save*.usa` and their associated `GameSaveInfo*` files together. Do not
copy an entire old System directory over the new build. Keep the old installation
until you have checked the new one.

Exit to Main Menu does not quit. The main menu's Exit Game should close the HP1
VR session and its companion processes, leaving SteamVR itself running. Back up
saves, then delete only the mod's installed folder to uninstall. The source game
was not modified by setup.

## Reporting a useful bug

Include V31 release date, installation method, Windows version, GPU/driver,
headset/controller and PC connection type, SteamVR version/refresh, resolution
settings, map/scene/save, exact reproduction steps and expected versus actual
behavior. Include the relevant end of compositor.log and HP1VRHost.log.

Inspect attachments before posting: logs and installation manifests can contain
your Windows username or local paths. Redact private paths. Do not upload the
whole Runtime folder, copyrighted game packages, personal saves publicly or
unnecessary crash dumps. Arrange a private reproduction-file exchange only when
needed and permitted. Never post account credentials.
