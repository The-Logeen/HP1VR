# HP1 VR — V31

Step into Hogwarts in the original 2001 PC adventure, with tracked head and hand
movement, a physical wand, VR spell lessons, configurable broom flight and
scene-specific interactions. V31 adapts the original game rather than replacing
its story, puzzle rules or progression with a separate VR remake.

**Unofficial Windows PC VR conversion. Original game required.** This is the
mod-only release kit, not a free copy of the game and not a standalone Quest app.

| Release | Details |
|---|---|
| Build | V31, October 7, 2026 snapshot |
| Platform | Windows 10/11 x64; SteamVR/OpenVR |
| Game | Compatible 2001 PC Philosopher's Stone / Sorcerer's Stone files |
| Distribution | VR binaries, installer, configuration, bindings and VR assets |
| Compatibility | Exact engine/script hashes checked by setup |
| Verification | 58 CPU regressions passed; installation/hash checks passed |
| Remaining acceptance | Latest Hermione note text fix needs headset confirmation |

**License:** The-Logeen's own V31 work in this kit is released under the
[MIT License](LICENSE). That does not cover the original game, the DX11 renderer,
the texture pack or Valve's OpenVR files, which keep their own terms. This kit
ships binaries; the C++ source tree is not included. See
[license status](LICENSE-STATUS.md) and [credits](CREDITS.md).

## What V31 adds

- Stereoscopic first-person VR with independent tracked head-look and hand aiming.
- Analog walking, smooth or snap turning, collision protection and native ledge
  traversal adapted to VR. Character pawns cannot become climbable ledges.
- Grip-held wand with adjustable hip holster, contextual charge/release casting,
  spell-specific rune lessons and wand-directed Wingardium movement.
- Optional visible Harry body: tracked arms/hands, walk blending, visual knee
  bending and independent eye-height/body/hip/neck-forward adjustments.
- Four selectable broom steering modes, adjustable sensitivity, synchronized
  visible broom/pivot height, one-hand continuation and eligible catching input.
- Cinematic Body, Free Movement, or Free Movement with a guide dot, plus a
  separate choice to use cinematic cameras or remain in Harry's body.
- Grip-and-face flute interaction, optional potion selection/drinking, and
  grounded wizard-cracker pickup with native-arc or physical throws.
- Health/bean relevance fading, configurable HUD placement, selected scaling,
  wrist anchors, optional body subtitles and left-hand Hermione notes.
- VR settings that pause gameplay, native menu/quit integration, audio recovery,
  isolated saves/configuration and a desktop mirror path.
- Compatibility work for procedural water/mirror effects, stable stereo output,
  adjustable sharpness and support for separately supplied enhanced textures.

These are implemented systems, not a guarantee that every scene, headset or
third-party game build has been fully playtested. See [known issues](TROUBLESHOOTING.md).

## Start here

1. Download **HP1-VR-V31-….zip** from this repository's **Releases** page
   (or use **Code → Download ZIP**). Right-click the ZIP → Extract All. Do not
   run anything from inside the ZIP.
2. Get your compatible original PC game and the [dependencies below](#exact-downloads),
   and extract the renderer and texture-pack archives.
3. Run **Install.cmd**, select the four folders, then Verify inputs → Install V31.
   If Windows SmartScreen says it protected your PC, choose More info → Run
   anyway; the mod is unsigned.
4. Connect your headset through SteamVR and launch **Launch-HP1-VR-V31.exe** from
   the new installation.
5. Stand upright, open VR settings with the game-menu button + right grip,
   and follow [first-run calibration](CONTROLS.md#first-run-calibration).

### Documentation

- [Controls and how to play](CONTROLS.md)
- [Complete settings reference](SETTINGS.md)
- [Troubleshooting, known issues and reporting bugs](TROUBLESHOOTING.md)
- [Release history](CHANGELOG.md)
- [Credits and third-party components](CREDITS.md)
- [Copy-ready mod-page descriptions](MOD-PAGE.md)
- [GitHub publishing checklist](PUBLISHING.md)
- [License (MIT)](LICENSE) and [license/provenance status](LICENSE-STATUS.md)

## Requirements and supported scope

A VR-capable Windows 10/11 x64 PC, compatible headset with two tracked controllers,
working SteamVR connection, and several GB of free space for the installed game
and texture pack are required. The measured private enhanced installation is
about 1.69 GiB; allow additional space for downloads and backups. No minimum GPU
model or guaranteed frame rate has been established. Quest requires a PC VR
connection; installing this folder directly on a headset will not work.

Bundled bindings cover Oculus Touch, Index/Knuckles and Vive controllers. Binding
availability is not certification of every headset/controller combination.
Other layouts may require SteamVR remapping. No Linux, standalone-headset,
multiplayer or universal regional-game compatibility is claimed.

Snapshot: October 7, 2026. Requires your own compatible 2001 Windows PC Harry
Potter and the Philosopher's Stone / Sorcerer's Stone installation. Not the
PlayStation game, Chamber of Secrets, or Hogwarts Legacy. This kit contains no
base-game packages, DX11 renderer or ESRGAN pack. It does include the VR code,
VR art, controller bindings and OpenVR client DLLs with Valve's license.

## Install with buttons

1. Extract this whole kit to a writable folder. Do not run from inside a ZIP.
2. Run **Install.cmd**. Windows PowerShell 5.1 and Windows Forms are built into
   supported Windows 10/11 x64 installations. This setup is unsigned; review the
   scripts if desired. It does not change machine execution policy, registry,
   antivirus settings or your original game. It does not require administrator
   rights for copying into your own writable folder.
3. Use the download buttons listed below. Extract the renderer ZIP and texture
   7z separately. Install the two Microsoft runtime packages using their own
   official installers. SteamVR and your headset's PC connection software must
   already work before playing.
4. Select your game folder (contains System and Maps); the extracted renderer
   folder (contains Common and Harry Potter 1); the extracted ESRGAN v3 folder
   (contains System and Textures); and a NEW/EMPTY destination outside all inputs.
5. Click **Verify inputs**, then **Install V31**. Hashing the texture pack takes
   time. Unsupported engine/script files are rejected, not silently installed.
6. Start SteamVR with the headset connected, then double-click
   **Launch-HP1-VR-V31.exe** in the NEW installed folder. Do not launch HP.exe.

## Exact downloads

- HP1 DirectX11 renderer **1.6.2**, archive `hp1dx11renderer162.zip`:
  https://www.gamepressure.com/download/harry-potter-and-the-sorcerers-stone-directx11-renderer-v162-mod/zb12ae2
  Creator: darknovismc / Marcin Nowicki. HP1-specific DLL SHA256:
  `0F5952AD10236AA5BCFCB8FC45E558E52E26F08CA0E2BF70F4B602D6A940DA55`.
  Other-game DLLs and modified mirrors are not interchangeable, even if labeled
  1.6.2. Installer checks the actual file, not just the archive name.
- Akven's **ESRGAN Upscale Pack v3**, January 4, 2022:
  https://www.moddb.com/addons/harry-potter-and-the-sorcerers-stone-esrgan-upscale-pack-v3
  Archive `Harry_Potter_and_the_Sorcerers_Stone_ESRGAN_Upscale_Pack_v3.7z`.
  The installer checks the extracted files against the supported pack hashes.
  This is a 4x upscale pack, not a promise every texture is 4096x4096.
- Microsoft **Visual C++ 2010 SP1 MFC Security Update**, choose **x86**:
  https://www.microsoft.com/en-us/download/details.aspx?id=26999
  Install `vcredist_x86.exe`, including on 64-bit Windows. The renderer needs
  MSVCR100/MSVCP100; installing only modern VC++ 2015-2022 does not provide these.
- Microsoft **DirectX End-User Runtimes (June 2010)**:
  https://www.microsoft.com/en-us/download/details.aspx?id=8109
  `directx_Jun2010_redist.exe` extracts a temporary folder; run **DXSETUP.exe**
  there afterward. Supplies D3DX11_43/D3DCompiler_43. Having DirectX 12 alone
  does not supply these legacy libraries. Never obtain individual DLLs from
  random DLL-download sites.
- **SteamVR**, current stable Steam-managed release:
  https://store.steampowered.com/app/250820/SteamVR/
  No specific SteamVR build is pinned or bundled. Steam installs/updates it.
- Optional extraction tool **7-Zip**: https://www.7-zip.org/
  No exact extraction-tool version required. Windows' ZIP extraction suffices
  for the renderer; the texture archive also needs 7z support.

Version-specific download pages verified October 7, 2026. Buttons open websites;
they do not silently download or execute third-party software. OS/headset drivers
and SteamVR cannot be made portable by copying a game folder.

## How the base game is connected

The installer COPIES required content into Destination/Runtime. It does not
symlink or modify your original game. Order: your game, optional compatible
overlays, DX11 1.6.2, ESRGAN v3, optional menu art, then V31 binaries/settings.
After installation the Runtime folder must remain beside the launcher. You can
move the installed folder as a unit; it no longer needs the source game folder.
Do not follow generic renderer instructions to delete your Documents HP.ini:
this VR mod uses isolated configuration files instead.

Supported inputs are the engine/script hashes listed in supported-inputs.json
(tested English engine 433 content). A matching title/version label alone does
not establish compatibility. Regional executables, community script revisions
and gameplay mods may differ. On a mismatch, stop and keep the named-file/hash
error; do not replace random DLLs or bypass the check. No base-game download or
unverified patch link is supplied. A different build needs a compatibility audit.

Optional compatible game-folder overlays can be supplied through the CLI's
GameModRoots parameter, in desired order. MenuAddonRoot/MenuLanguage accepts
an already-owned language-art overlay; it is not required and does not translate
dialogue. No arbitrary extra gameplay mod is necessary or certified here.
Existing enhanced art in your source game is retained. The kit cannot recreate
unidentified extras in a different person's base-game installation.

## Controls and tuning

- Open/close VR settings: **game-menu button + right grip** (left Y on Touch,
  left B on Index, left menu button on Vive). Point and trigger or use
  the left stick to select and adjust settings. Controller bindings included for
  Oculus Touch, Index/Knuckles and Vive; button names differ across devices.
- Stand upright for initial calibration/recenter. Set virtual eye height,
  independent avatar body scale, hip height and head-forward/neck placement in
  the VR menu. Another person's body calibration is deliberately not included.
- Scene choices: Cinematic Body, Free Move, and Free Move with a guide dot.
  The old automatic nudge has been replaced. Cinematic camera options are
  separate; body/free controls and scene-specific exceptions remain in V31.
- Draw lesson runes with the wand; normal contextual casting and Wingardium
  wand-ray manipulation remain. Broom steering modes, pitch sensitivity,
  synchronized broom/pivot height and catching controls remain adjustable.
- Flute: grip with either free hand, hold at face, trigger to play. Potions have
  native casting, grip-or-cast, and grip plus required final drinking modes.
  Grounded crackers: free-hand grip or native bump pickup; trigger gives the
  original throw arc, optional physical mode throws on grip release.
- HUD items have placement controls; health/beans support relevance fading and
  wrist choices. Dialogue can use authored screen placement or a body plane
  with position/scale controls. Hermione reminders use the left-hand page.
- Exit to main menu is distinct from Exit Game. Exit Game closes the HP1 VR
  session/host/companion, not the SteamVR runtime or other running VR games.

Settings: Runtime/VR/V30Calibration.ini. Renderer: Runtime/System/StereoV30VR.ini.
Input: Runtime/System/VRUser.ini. Startup: HP1VR-V30.ini beside the launcher.
Legacy V30 filenames are intentional internal names in this V31 build.
Keep UseJoystick=False. Resolution defaults to the current 1280-square eye
rendering; lower WorldSize to 1024 if performance suffers. Do not stack aggressive
SteamVR global/per-app supersampling without checking total render resolution.

## Saves, troubleshooting, removal

New installations start without personal saves. To migrate while both games are
closed, copy your Save*.usa and associated GameSaveInfo* files into Runtime/Save;
back up destination saves first. Save at an actual save book before boss fights.
Back up Runtime/Save and V30Calibration.ini before replacing an installation.

Code 7 is not automatically a SteamVR failure. Inspect the last hostExit= line
in Runtime/VR/compositor.log, then Runtime/System/HP1VRHost.log. Logs are generated
during normal play; no old development logs or test launchers ship in this kit.
The existing console-free launch and desktop mirror path are retained.
If installation fails after copying starts, source folders are still untouched;
use a different empty destination for retry. Partial output is not auto-deleted.

To remove V31, close it, back up your saves/settings, then remove only its
installed folder. No registry uninstall or original-game repair is required.
For an upgrade, install into another empty folder, then migrate saves/settings.

## Release scope and credits

This packages the current October 7 V31 code, not a new engine rebuild. All 58
CPU regressions passed for that build. New folder portability and installer
checks are tested separately. No guarantee of every headset/driver combination:
the latest note readability adjustment still needs in-headset acceptance.
All implemented movement/climbing, scenes, casting, interaction, flight, avatar,
HUD, crash guards, audio/menu pause and quit changes are retained.

OpenVR: Valve, see OPENVR-LICENSE.txt. Renderer: darknovismc / Marcin Nowicki.
ESRGAN textures: Akven. Original game/art/characters belong to their respective
owners. This unofficial fan mod conveys no rights to the underlying game or
third-party art. No general relicensing of those assets is asserted.

Share this MOD KIT, not your installed game folder or the private Final Playable
folder. Third-party license/readme terms still apply. The full playable copy
contains game content and personal saves and is for your private use.

CLI alternative (from this kit):

```powershell
.\Install.ps1 -GameRoot 'D:\Games\HP1' -RendererRoot 'D:\Downloads\hp1dx11renderer162' -TexturePackRoot 'D:\Downloads\Harry_Potter_and_the_Sorcerers_Stone_ESRGAN_Upscale_Pack_v3' -Destination 'D:\Games\HP1 VR V31'
```

Add -ValidateOnly for a read-only check. To check the kit itself before
installing (for example after copying it), run
`powershell -ExecutionPolicy Bypass -File tools\Test-Kit.ps1` from a Git clone.
Release ZIPs come with a `.sha256` file; compare it with
`Get-FileHash HP1-VR-V31-*.zip`. Explicit -TexturePackRoot '' selects
original-texture fallback through the CLI only; that does not match the enhanced
appearance. GUI requires the v3 pack to match the intended release.
