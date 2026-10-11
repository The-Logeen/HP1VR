# Settings reference

[Back to README](README.md) · [Playing and controls](CONTROLS.md)

Open VR settings with the controller menu button plus right grip (Touch: Y +
right grip). Use the right-hand pointer and trigger, or the left stick to select
and adjust. The VR menu pauses gameplay. Close it before testing a change.
Settings save to `Runtime/VR/V30Calibration.ini`; back this up before resetting.
V30 in internal filenames is intentional, not an older release.

Defaults below describe a fresh mod-kit installation, not an existing player's
saved calibration. Some rows are contextual or read-only. Distances are virtual
VR distances, not a measurement of the player's real height.

## Comfort and turning

| Setting | Default / range | What it changes |
|---|---|---|
| Turning | Smooth; optional 30° snap | Right-stick turning |
| Smooth turn speed | 90°/s; 30–180°/s | Turning rate, not hand tracking |
| Comfort vignette | Off; 0–100% | Peripheral comfort masking |
| Stair smoothing | On | Smooths small vertical steps |
| Virtual eye height | 170.5 cm; 80–240 cm | Camera height reference; independent of body scale |
| Free rotation | Always available | Informational compatibility row |

Stand upright when calibrating. Calibration establishes the standing reference;
lowering your real head afterward drives visual knee bending when the avatar is
enabled. Do not use body scale to compensate for a bad standing reference.
Virtual eye height is not a command to make Harry an adult-sized world character.
Tune it while comparing against the world and other characters.

## Scenes and control

| Setting | Choices / default | Effect |
|---|---|---|
| Scene movement | Cinematic Body (default), Free Movement, Free + Guide | Native body staging, manual movement, or manual movement with an expected-position marker |
| Cinematic cameras | On by default | Allows authored external shots; turn off to remain in Harry's body |

The guide is a destination hint, not a handle to grab or climb. Move into its
trigger area. The old automatic steering/nudge is no longer a scene mode.
External cinematic shots can temporarily hold movement when cinematic cameras
are enabled. Special gameplay states still obey their own rules. The final
potion-table sequence suppresses unwanted table-facing auto-turns.

## Wand, body and calibration

| Setting | Fresh default | Range / notes |
|---|---|---|
| Visible avatar | Off | Enables Harry's body and tracked limbs |
| Body scale | About 113.7% | 65–160%; independent of eye height |
| Hip offset | 0 cm | −30 to +15 cm; leg reach can limit the result |
| Head forward | 11.5 cm | −15 to +35 cm; moves the body relative to the eyes |
| Holster side | +25 cm | −45 to +45 cm; choose your preferred side |
| Holster forward | 0 cm | −35 to +35 cm |
| Holster drop | 82 cm below head | 35–115 cm; smaller puts the holster higher |
| Pointer pitch | +15° | −30 to +45°; pointer alignment |
| Wand light | Off | Experimental visual option |

Use eye height for your viewpoint, body scale for body proportions, hip offset
for standing/knee alignment, and head forward for how far into or ahead of the
neck the viewpoint sits. Positive head forward places the body farther behind
your eyes. Visual knee bending does not add a new crouch/stealth collision mode.
For recenter instructions and held-object safeguards see [controls](CONTROLS.md).

## Spell lessons

| Setting | Default | Adjustment |
|---|---|---|
| Drawing gain | 100% | 50–150% |
| Cursor source | Wand tip | Fixed tip reference; 28 cm lever |
| Board distance | 55 cm | 35–85 cm |
| Board height | 138 cm | 80–190 cm |
| Drawing hand | Auto | Auto, Left, Right |
| Path assistance | Off | 0–100% |

Each lesson uses its spell's own rune. Assistance is optional; changing hand or
board placement does not replace the required pattern with Flipendo's pattern.

## Climbing and collision

| Setting | Default | Adjustment |
|---|---|---|
| Extra climb headroom | 25 cm | 0–250 cm above normal jump allowance |
| Solid-wall pushback | On | Anti-clipping guard |
| Extra bottom trim | 0% (automatic only) | 0–20% |

Climbing remains the game's ledge traversal, not a general hand-over-hand system.
Character pawns are blocked as climb targets throughout the game. The final
potion table has additional traversal guards. Large climb allowances do not
make those excluded targets valid.

## Broomstick flight

| Setting | Default | Adjustment |
|---|---|---|
| Steering | Stick | Stick, Point, Broom, Lean |
| Sensitivity | 100% | 20–200% |
| Pitch inversion | Normal | Normal / inverted |
| Deadzone | 15% | 0–40% |
| Broom height offset | −15 cm | −30 to +20 cm; menu may show resulting shaft height |

Height moves the visible broom and actual steering pivot together. There is no
independent cosmetic offset that leaves the flight pivot elsewhere. Set it near
the seated/between-leg position you want, then re-establish a comfortable neutral
pose. See [flight controls](CONTROLS.md) for neutral calibration, one-hand use,
boost/brake and native-eligible snitch/key catching.

## HUD visibility

| Setting | Default | Range |
|---|---|---|
| Health/beans relevance fade | On | Relevance fade or always visible outside suppressed scenes |
| Visible hold time | 3 seconds | 0.5–15 seconds |
| Fade duration | 0.6 seconds | 0.1–3 seconds |
| Health screen X / Y | 20% / 16% | X: 0–80%; Y: 0–65% |
| Beans screen X / Y | 68% / 16% | X: 0–80%; Y: 0–65% |
| Fluffy meter raise | 20% | 0–55% higher |

X is measured from the left; Y is down from the top. Repeated bean/health changes
extend the visible deadline instead of restarting an out-and-in animation for
every item. These counters are suppressed during dialogue/cinematic moments,
including when the normal preference is always visible.

## UI layout catalog

Select the UI element first, then adjust its placement and supported controls:

1. Health lightning bolt
2. Beans
3. Fluffy sleep meters
4. Spell-lesson grade/pass text
5. Spell-lesson final result
6. Countdown
7. Enemy/boss health
8. House points
9. Challenge stars
10. Fire seeds
11. Dialogue/icon messages
12. Other popup text
13. Spell icon
14. Broom hoop counter

| Control | Availability |
|---|---|
| Placement | Screen, left wrist, right wrist; Messages also offers Body |
| Screen offset | Generally ±55%; special health/bean/sleep controls use the ranges above |
| Wrist X/Y | ±35 cm, in 2 cm steps |
| Body-message X/Y | Uses the corresponding position offsets |
| Scale | 60–200% for health/beans and Body-mode Messages |
| Other scale rows | Native size; not every UI element has independent scaling |
| Reset selected UI | Resets its position and scale, preserving placement choice |

Most wrist HUD items use a wrist-following projection anchor; do not confuse
that with a separate, fully physical 3D object for every counter. Hermione's
reminder note and Body-mode dialogue use dedicated planes. Lesson text starts
with a downward offset. Test placement in the relevant scene: not all elements
are visible at once, and a scene may use more than one element type.

## Physical interactions

| Setting | Choices |
|---|---|
| Wizard cracker throw | Trigger/native arc (default); physical swing and grip release |
| Potion interaction | Flipendo only (default); Grip or Flipendo; Grip plus final drink |

The third potion mode includes the second mode's selection behavior and adds a
required face/drinking pose for the final successful bottle. It is not a choice
between grip selection and drinking. Wrong choices retain the native outcome.
In physical cracker mode the throw comes from grip release, not the trigger.

## Sharpness, stereo and advanced compatibility

| Setting | Default | Range / purpose |
|---|---|---|
| World sharpness | 50% of available effect | 0–100% displayed; internal strength 0–0.6 |
| Eye separation | 100% | 0–125% multiplier; not hardware IPD in millimetres |
| Projection width | 100% | 100–150%; projection tuning, not texture resolution |
| Stereo inward shift | 0 | 0–0.25; diagnostic alignment |
| Stereo order | Normal | Reversed is for diagnosis |
| World scale | 40 units/metre | 20–80; changes spatial mapping, not image resolution |
| World projection | Legacy symmetric + crop | Old off-axis path is explicitly a test option |
| Head rotation | Full tracked | Yaw-only is a test option |
| Frontend screen | Rigid/world | Head-locked is a test option |
| Panel distance | 1.8 m | 1–3 m |

Leave diagnostic projection/stereo modes at their defaults unless investigating
a specific problem. Sharpness cannot reconstruct absent texture detail. The
separately installed ESRGAN pack is a 4× upscale, not uniform native 4K assets.
No DLSS/FSR integration is claimed.

`HP1VR-V30.ini` beside the launcher contains `WorldSize`: default 1280 square per
eye, supported range 640–1536. Exit the game before editing it. 1024 is a useful
performance comparison. SteamVR scaling is an additional factor: begin with
global and per-app resolution at 100%, check actual dimensions and frametime,
then change one factor at a time. More pixels can worsen stalls/reprojection.
`MaxTickHz=Auto` uses a half-headset-refresh engine cap, not a claim that the
headset itself runs at half refresh. Frontend rendering defaults to 1024×768.

## Extras, resets and configuration files

Extras expose native cheats: enable cheats, walk through walls, fly, return to
normal walking, and invulnerability. They are not needed for normal play and
can bypass scene triggers or invalidate progression. Use a separate save.

Reset-all requires confirmation. Back up calibration first; it affects your
personal setup, not just the currently selected row.

| File | Purpose |
|---|---|
| `HP1VR-V30.ini` | Launcher/runtime selection and eye-output settings |
| `Runtime/VR/V30Calibration.ini` | In-game VR preferences and calibration |
| `Runtime/System/StereoV30VR.ini` | Renderer/game VR configuration |
| `Runtime/System/VRUser.ini` | Native input configuration; keep `UseJoystick=False` |
| `Runtime/Save` | Your saves, independent of the original installation |

Avoid editing these while playing: the running process can save over changes.
