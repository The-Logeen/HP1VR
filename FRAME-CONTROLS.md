# HP1VR V31: Frame bindings and independent aiming

October 18, 2026 release candidate. Windows PCVR through SteamVR/OpenVR, not a native headset app. Frame hardware acceptance remains pending. Existing V31 features and Touch/Index/Vive binding files are retained.

## Install safely

Extract the entire mod ZIP, run Install.cmd and use Full instructions. Select the complete HP1 game, HP1 renderer 1.6.2, and HP1 ESRGAN v3 (or explicitly check Use original textures). The HP1 MagiPack from MyAbandonware is the tested source reference, NOT HP2's MagiPack. No game files or game download link are included. Nearby compatible renderer layouts resolve automatically; exact binary checks remain enforced.

Choose a NEW destination. Keep your working installation and launcher. This HP1 installer does not implement HP2's automatic Update from migration. To retain progress, close both copies, back up and copy your previous Runtime/Save contents to the new Runtime/Save. You can also copy Runtime/VR/V31Calibration.ini; absent new keys use defaults. Do not copy old EXEs, DLLs or the entire old Runtime over this installation. Saves do not synchronize afterward.

Start SteamVR and both controllers, then the new installed Launch-HP1-VR-V31.exe. In SteamVR's VR controller bindings, choose the running HP1VR app and **HP1VR V31 - Steam Frame (experimental)**. Selection is based on controller type, not headset brand. An old custom binding may override the new default. Do not edit a flat-game Steam Input layout instead.

## Shipped Frame mapping

| Control | Action |
| --- | --- |
| Left stick | Movement; selection/adjustment in VR settings |
| Right stick | Turn, using existing smooth/snap setting |
| Right trigger | Menu selection; equipped wand hold to charge/draw, release to cast/end stroke |
| Left trigger | Jump |
| Left/right grip click | Corresponding hand grab, including wand pickup at hip |
| Left View | Game menu |
| Hold right grip and press left View | VR settings |
| Right A | Existing skip-dialog action, with existing contextual restrictions |
| Left/right raw tracked pose | Corresponding hand tracking |
| Left/right haptic output | Corresponding vibration |

The profile is `payload/VR/bindings_v31_frame_controller.json`, installed under `Runtime/VR`; the manifest registers `frame_controller`. Unlisted controls have no new mapping. No D-pad center click is assumed. Cast/jump use analog vector1 trigger pull, not a digital button substitute. Grips use click, not merely touch. Pose actions must be bound too.

After leaving the SteamVR dashboard, release triggers/grips/buttons and center sticks before trying again so input can rearm.

## Controller Aim / Frame category in VR settings

Open VR settings (Touch: Y + right grip; Frame: View + right grip). Expand **Controller Aim / Frame**. Use the left stick to select a row and adjust left/right; trigger operates the reset button. Stick navigation also works when pointer alignment makes pointing difficult.

| Setting | Default | Positive value |
| --- | --- | --- |
| Menu pointer pitch | 15 degrees | DOWN, preserving HP1's existing convention |
| Menu pointer yaw | 0 | Controller-local right |
| Wand pitch | 0 | Up |
| Wand yaw | 0 | Controller-local right |

Angles adjust in 2-degree steps over -90 to +90. **Reset aim angles only** restores these four defaults without resetting other preferences. No guessed +25/-40 correction is forced for Frame. Pointer and wand are independent. Wand calibration is applied consistently to ordinary spell aiming/visuals, lesson tip tracking and Wingardium direction. Hip pickup position, avatar hands, locomotion and raw input poses are not rotated.

Settings belong to the installation, not separate controller profiles. Reset/recalibrate when switching controllers. Unlike HP2, HP1 retains the old pointer pitch sign/default for compatibility.

### Recovery without using the pointer

Close the game. Back up `Runtime/VR/V31Calibration.ini`. Under its existing `[V30Calibration]` section (the historical section name is intentional), update these keys without duplicates:

```ini
pointerPitchDegrees=15
pointerYawDegrees=0
wandPitchDegrees=0
wandYawDegrees=0
```

Save and relaunch. These restore previous aiming behavior. If needed, change only one pointer axis a few degrees per attempt.

## Troubleshooting

- No hands: check SteamVR tracking, active profile and pose actions. Angle settings cannot restore missing tracking.
- Hands track but pointer appears at odd angles: calibrate pointer; test both main menu and VR options. Off-panel rays can hide the pointer without tracking being broken.
- Pointer visible but no selection: check trigger pull action, input activity and neutral rearming after dashboard use.
- Sound but no effect: equip the wand, hold on a valid spell target and fully release. Check analog trigger returns to zero; a digital rebind is not automatically equivalent.
- Changes seem ineffective: verify the new launcher/settings path, not another installation.
- Setup blocked by script policy: use Install.cmd. It sets Bypass for that process only; saved policies/antivirus are unchanged. Managed Group Policy can still prevent execution; contact the administrator rather than disabling security.

Report SteamVR version, headset/controller model, active binding JSON, four angle values, whether hands track, trigger hold/release behavior, and relevant logs under Runtime/VR. Use Open full log / Copy result details for setup errors. Review personal paths before sharing.

## Headset acceptance checklist

1. Full stationary main menu; point and select New/Load.
2. Open/close game and VR menus; test pointing and stick navigation.
3. Draw wand, charge and RELEASE at a valid target; verify actual spell effect.
4. Test a spell lesson and Wingardium with calibrated wand.
5. Verify movement/strafe/turn/jump remain normal.
6. Change each angle independently, relaunch to check persistence, then aim-only reset.
7. Test previously working controllers at default angles if available.

Rollback: close this installation and use the old launcher; restore the old SteamVR custom binding if necessary. Do not run both copies simultaneously.

Reference: [Valve Frame input](https://partner.steamgames.com/doc/steamhardware/steamframe/input), [OpenVR input profiles](https://github.com/ValveSoftware/openvr/wiki/Input-Profiles).
