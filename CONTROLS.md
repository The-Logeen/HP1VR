# Controls and playing in VR

[Back to README](README.md) · [Settings](SETTINGS.md)

These are the bundled bindings. Custom SteamVR bindings can change them. The
binding filenames now use V31; the actual gameplay action paths are unchanged.
Context changes what an input does; triggers used for flying, a held object or
a menu are not ordinary walking/casting inputs at the same time.

## Controller reference

| Action | Oculus Touch / Quest through PC VR | Index / Knuckles | Vive |
|---|---|---|---|
| Move | Left stick | Left thumbstick | Left trackpad |
| Turn | Right stick horizontally | Right thumbstick horizontally | Right trackpad horizontally |
| Game menu | Left Y | Left B | Left application-menu button |
| VR settings | Game-menu button + right grip | Same chord | Same chord |
| Dialogue skip / contextual flight action | Right A | Right A | Right application-menu button |
| Right-hand trigger action | Right trigger | Right trigger | Right trigger |
| Left-hand trigger action | Left trigger | Left trigger | Left trigger |
| Grip | Grip on the relevant hand | Grip action on relevant hand | Grip button on relevant hand |

Touch X/B and stick clicks have no separate action assigned in the bundled
bindings. Game-menu inputs are different from the headset's SteamVR/system menu.

## First-run calibration

1. Set a safe play boundary and keep real-world furniture clear. Stand comfortably
   upright when tracking initializes. Do not calibrate while deliberately crouched.
2. Holster the wand, keep hands away from its socket, stop stick movement, then
   squeeze both grips to recenter. Recenter is guarded during traversal, flight
   and held-object interaction; do it while standing normally.
3. Open VR settings. Set **Eye height (independent of body)** for your desired
   in-world view/reach. This is not a field where you must enter your real height.
4. If using the visible body, enable **Harry body (experimental)** and adjust
   **Avatar proportional body scale**, **Hip offset**, and **Head forward / eyes
   in neck** independently. Increasing head-forward moves the body back relative
   to your tracked eyes; it does not artificially shove your camera forward.
5. Physically lower yourself: the visual knees should bend relative to the
   standing calibration. Visual crouch does not promise new crouch collision,
   stealth rules or full-body tracking.
6. Pick smooth or snap turning, adjust wand holster reach, then close settings
   with the same chord. Avoid altering Advanced/Compatibility controls casually.

Your settings save in Runtime/VR/V31Calibration.ini. New mod installations do
not ship someone else's calibration. The private playable snapshot does retain
its owner's settings. Defaults leave the experimental body OFF.

## Walking, jumping and climbing

The left stick moves relative to virtual body facing; looking sideways does not
by itself rotate the movement direction. Use the right stick to turn the body.
Smooth turning is the fresh-install default; snap turning uses 30-degree steps.

Jump uses the non-wand hand's trigger; with the wand holstered, use the left
trigger. Avoid holding both triggers when learning contextual interactions.

Climbing remains HP1's native ledge traversal: approach a valid ledge and use
movement/jumping as the game requires. This is **not hand-over-hand grip climbing**.
NPCs are excluded from climb targets. Particular scene furniture, including the
final potion table, has additional climb guards. More headroom is a tuning aid,
not permission to climb every object or walk through solid geometry.

## Wand and ordinary casting

1. Reach either hand near the wand's hip socket and hold that hand's grip.
2. Aim the wand at a valid game target. HP1 selects the appropriate learned spell;
   there is no general manual spell-cycle button in these bindings.
3. Hold the wand-hand trigger to charge, then release the trigger while retaining
   grip to cast. Let the trigger return to neutral before starting another cast.
4. Release grip to cancel/holster. Adjust the holster in Wand & Avatar if needed.

The original target rules, projectile effects, puzzle state and progression still
apply. Pointing at arbitrary scenery does not make every surface interactable.

### Spell lessons

Use the displayed spell-specific rune. Hold the lesson hand's trigger, trace with
the wand tip, then release for the native lesson judge to grade the stroke. Lesson
hand can be Auto, Left or Right; board distance/height, trace gain and path assist
are adjustable. Do not assume an old guide's fixed right-hand lesson layout is
mandatory. A lesson is a special interaction, not an ordinary projectile cast.

### Wingardium Leviosa

Aim at an eligible levitation target and keep the trigger held through acquisition
and lift. In the hold-trigger path, the charge is released internally after its
acquisition dwell so you can continue holding the control. Once acquired, move
and rotate the wand to steer the object along the wand-directed line. Releasing
the trigger requests the native drop when the puzzle permits it. Native locks,
collision and object lifetime remain authoritative; not every prop can levitate.

## Menus, dialogue and scene movement

Aim the right controller at menus and use right trigger to click. In VR settings,
left-stick up/down selects rows; left/right adjusts values; trigger opens groups
or activates the selected item. Reset-all requires confirmation. Menus suspend
movement; VR settings acquire/release the game's pause without clearing an
unrelated pre-existing pause. Release controls after tracking/focus interruptions.

Press the dialogue-skip/action button for the current supported spoken action;
it is not a universal skip-everything or bypass-puzzle button.

| Scene mode | Intended experience |
|---|---|
| Cinematic Body | Native scripted positioning remains, with manual turning priority and scene-specific exceptions. |
| Free Movement | Ordinary scripted walking/turning yields to player movement; required transitions and gameplay restrictions still exist. |
| Free Move + Guide Dot | Free movement plus a visible staging cue for supported pending Harry positions; no former automatic nudge. |

Walk into the reachable guide area to continue a positioning-dependent moment.
Dots are guidance, not physical climbable objects or guaranteed quest markers
for every puzzle. Required dialogue/cues/rewards are still native game logic.

**Cinematic cameras** is a separate setting. Enabled external shots can suspend
locomotion during the shot; OFF keeps the view in Harry's body. This is not a
promise that every special minigame ignores its own gameplay constraints. The
final potion sequence has specific no-auto-turn and room-camera protections.

## Broom flight

Select the steering mode under Broomstick Flight before testing a difficult stage.

| Mode | Steering |
|---|---|
| STICK | Left/right steers; pull back to climb and push forward to dive unless pitch is inverted. |
| POINT | Right controller angle relative to captured neutral controls turning and pitch. |
| BROOM | Hold both grips on the shaft and orient it. Release one hand to reach while the other maintains steering. |
| LEAN | Head roll and hand-height input provide the alternative leaning control scheme; head yaw remains free look. |

Right trigger boosts; left trigger brakes. Brake wins if both are pressed.
The right action button invokes the native supported broom action. The original
flight physics keep forward motion: braking is not hovering, and native collision
avoidance/progression still apply.

For POINT/LEAN, hold both grips about 0.75 seconds to recapture neutral. In BROOM
mode, release both and re-grab to recapture. One-hand continuation does not offer
the same two-hand shaft measurement; re-grip with both hands for precise control.
Tune sensitivity, pitch direction and deadzone before changing rendering options.
The broom shaft height and actual steering pivot remain synchronized.

### Catching a Snitch or winged key

First reach the game's eligible catch phase. Then release one hand's grip and
reach into the catch cue with that free hand. The implementation detects a reach;
it does **not** require a grip squeeze to snatch. The right action button is the
accessible fallback once native catch eligibility is satisfied. Keep the other
hand controlling the broom in BROOM mode. The Remembrall chase is not converted
into a new catch minigame; it retains its own native objectives.

## Scene interactions

### Fluffy's flute

Approach the instrument, grip it with either free hand, bring it near your face,
then use that hand's trigger to play. Face proximity matters. Release the trigger
to stop. Releasing grip holsters it opposite the wand. Damage can interrupt
playing without forcing it out of a still-gripping hand; release and press the
trigger again after interruption. Do not expect arbitrary floor-drop behavior
to be a selectable menu option in this release.

### Potion selection and drinking — late-game puzzle spoilers

| Setting | Behavior |
|---|---|
| FLIPENDO ONLY | Original spell-based selection. Fresh-install default. |
| GRIP OR FLIPENDO | Adds physical bottle selection while retaining spell selection. |
| GRIP + FINAL DRINK | Same selection alternatives, plus mandatory face-position drinking for the final successful potion. |

In grip modes, reach close to the bottle with a free hand and squeeze grip.
Choosing a wrong bottle invokes the native wrong-choice outcome, not a harmless
preview. In mandatory-drink mode, the correct final bottle remains in hand:
bring it to your mouth/face and hold it there about 1.5 seconds. Its grabbed
rotation is stabilized; the successful native result opens the safe fire passage.
Do not climb the table to reach bottles. This scene has reach accommodations,
guide/arrival handling and no-auto-turn protections. Failures remain in the
potion room rather than deliberately switching to the later boss room.

### Wizard crackers

Grounded crackers can be picked up with a free hand's grip or the native body-bump
fallback. In default mode, pull the holding hand's trigger to throw using the
native arc; releasing grip alone is not the physical-throw command in this mode.
In optional PHYSICAL mode, swing and release grip; trigger does not throw.
Airborne crackers retain native collision/explosion behavior. Native fuse and
enemy damage rules remain. This is not universal physics grabbing for all props.

### HUD, letters, trade and subtitles

Health/beans can stay visible or appear on changes. Consecutive changes extend
the visible period rather than flashing each pickup. Those counters hide during
dialogue/cinematic states. Select individual elements under UI Layout for
position, supported scaling and screen/wrist placement.

Hermione's class reminders use a left-hand page with the original message
lifetime. The orientation was confirmed; the latest text-legibility adjustment
still needs confirmation. It is a display, not a separately grabbable item.
Fred/George retain native bean requirements and rewards. Ordinary dialogue uses
its authored placement unless adjusted; BODY subtitles provide a body-relative
world panel shared by both eye projections. External cinematic cameras use the
authored subtitle fallback so text is not left on an off-screen Harry.

## Saving and quitting

Use actual save books and preserve checkpoints before late-game encounters.
Exit to Main Menu returns to the game's front end. Exit Game closes this HP1 VR
session; SteamVR itself may remain open. Do not terminate unrelated SteamVR
processes to close the mod. Back up Runtime/Save and V31Calibration.ini regularly.
# Frame release candidate additions

See [Frame bindings and independent angle controls](FRAME-CONTROLS.md) for the complete new mapping, calibration and troubleshooting. Existing controls below remain in place.

