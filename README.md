# HP1 VR — V31

Step into Hogwarts in the original 2001 PC adventure, with tracked head and hand
movement, a physical wand, VR spell lessons, configurable broom flight and
scene-specific interactions. V31 adapts the original game rather than replacing
its story, puzzle rules or progression with a separate VR remake.

**Unofficial Windows PC VR conversion. Original game required.** This is the
mod-only release kit, not a free copy of the game and not a standalone Quest app.

| Release | Details |
|---|---|
| Build | V31, October 11, 2026 naming update |
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

## Quick start

1. Get the required items in [What you need](#what-you-need).
2. Extract this mod, run **Install.cmd**, select your four folders, then click
   **Verify inputs** → **Install V31**.
3. Start SteamVR and run **Launch-HP1-VR-V31.exe** from the new installation folder.

Full instructions: [Install, step by step](#install-step-by-step).

## Documentation

- [Controls and how to play](CONTROLS.md)
- [Complete settings reference](SETTINGS.md)
- [Troubleshooting, known issues and reporting bugs](TROUBLESHOOTING.md)
- [Release history](CHANGELOG.md)
- [Credits and third-party components](CREDITS.md)
- [Copy-ready mod-page descriptions](MOD-PAGE.md)
- [GitHub publishing checklist](PUBLISHING.md)
- [License (MIT)](LICENSE) and [license status](LICENSE-STATUS.md)

## Install, step by step

You do every step once. After that you just start SteamVR and launch the game.

### What you need

Get every **required** item before you start. The installer checks each one and
stops with a clear message if something is missing or the wrong version.

| | Item | Where it comes from |
|---|---|---|
| Required | Windows 10 or 11, 64-bit, VR-capable PC | — |
| Required | PC VR headset with two tracked controllers (Quest works only through Link/Air Link/Virtual Desktop) | — |
| Required | **SteamVR**, installed and working with your headset | [Steam](https://store.steampowered.com/app/250820/SteamVR/) |
| Required | Your own **2001 PC Harry Potter and the Philosopher's Stone / Sorcerer's Stone**, installed (English engine 433 files) | Your own copy; not supplied here |
| Required | **HP1 DirectX 11 renderer 1.6.2** (`hp1dx11renderer162.zip`) | [gamepressure.com](https://www.gamepressure.com/download/harry-potter-and-the-sorcerers-stone-directx11-renderer-v162-mod/zb12ae2) |
| Required | **ESRGAN Upscale Pack v3** (`Harry_Potter_and_the_Sorcerers_Stone_ESRGAN_Upscale_Pack_v3.7z`) | [moddb.com](https://www.moddb.com/addons/harry-potter-and-the-sorcerers-stone-esrgan-upscale-pack-v3) |
| Required | **Visual C++ 2010 SP1 runtime, x86** (`vcredist_x86.exe`) | [microsoft.com](https://www.microsoft.com/en-us/download/details.aspx?id=26999) |
| Required | **DirectX End-User Runtimes, June 2010** (`directx_Jun2010_redist.exe`) | [microsoft.com](https://www.microsoft.com/en-us/download/details.aspx?id=8109) |
| Required | **7-Zip**, to open the texture pack's `.7z` file | [7-zip.org](https://www.7-zip.org/) |
| Required | Several GB of free disk space (the finished install is about 1.7 GB, plus downloads) | — |

Not supported: the PlayStation version, Chamber of Secrets, Hogwarts Legacy,
Linux, or installing directly on a standalone headset.

### Step 1 — Check your game folder

Find the folder where HP1 is installed. It must contain a **System** folder and a
**Maps** folder, and `System` must contain `HP.exe`, `Engine.dll` and
`HarryPotter.u`. Write down this folder's path; you will select it in step 6.
The installer only reads from it and never changes it.

### Step 2 — Install the two Microsoft runtimes

1. Download `vcredist_x86.exe` from the Visual C++ 2010 link. Choose **x86**
   even on 64-bit Windows. Run it and click through to finish. (Newer
   "2015–2022" runtimes do **not** replace this one.)
2. Download `directx_Jun2010_redist.exe` and run it. It only asks for a folder
   to unpack into: pick a new empty folder, such as `C:\DXTemp`.
3. Open that folder and run **DXSETUP.exe**. Click through to finish. You can
   delete `C:\DXTemp` afterwards. (Having DirectX 12 does **not** include these
   older files.)

Only use the Microsoft links above. Never download single DLL files from
"DLL download" sites.

### Step 3 — Download and extract the DX11 renderer

1. Download `hp1dx11renderer162.zip` (version **1.6.2**, the HP1 build).
2. Right-click it → **Extract All…** into a folder such as
   `C:\HP1VR-Downloads\hp1dx11renderer162`.
3. Open that folder. The folder you will select later is the one that directly
   contains both **Common** and **Harry Potter 1**. If you see a single folder
   instead, go one level deeper until you see those two.

Do not copy anything into your game folder, and ignore the renderer's own
instructions to delete `HP.ini`. The VR installer handles all of this.

### Step 4 — Download and extract the texture pack

1. Download the ESRGAN v3 `.7z` file.
2. Right-click it → **7-Zip → Extract to "…\"** into a folder such as
   `C:\HP1VR-Downloads\ESRGAN-v3`.
3. The folder you will select later is the one that directly contains
   **System** and **Textures**.

### Step 5 — Download and extract this mod

1. On this repository's **Releases** page, download **HP1-VR-V31-….zip**
   (or click **Code → Download ZIP** on the main page).
2. Right-click the ZIP → **Extract All…** into a normal folder you can write to,
   such as `C:\HP1VR-Downloads\HP1 VR V31 Mod`. Do not run anything from inside
   the ZIP, and do not extract it into your game folder.

### Step 6 — Run the installer

1. In the extracted mod folder, double-click **Install.cmd**. If Windows says
   "Windows protected your PC", click **More info → Run anyway**; the mod is not
   code-signed. No administrator rights are needed.
2. A window titled **HP1 VR V31 – Install into a separate folder** opens. Fill in
   the four boxes with **Browse**:

   | Box | Select the folder that contains… | Example |
   |---|---|---|
   | Your compatible HP1 game folder | `System` and `Maps` (step 1) | `D:\Games\Harry Potter` |
   | Extracted HP1 renderer 1.6.2 folder | `Common` and `Harry Potter 1` (step 3) | `C:\HP1VR-Downloads\hp1dx11renderer162` |
   | Extracted ESRGAN v3 folder | `System` and `Textures` (step 4) | `C:\HP1VR-Downloads\ESRGAN-v3` |
   | New / empty installation folder | nothing; it must be new or empty | `C:\Users\you\Documents\HP1 VR V31 Installed` (the default) |

   The installation folder must not be inside any of the other three folders.
3. Click **Verify inputs**. This reads and checks every file and can take
   several minutes because of the texture pack. Wait for the result in the
   text box at the bottom.
4. When it finishes without "FAILED", click **Install V31**. This copies
   everything into the installation folder. Your original game, the downloads
   and the mod folder are left untouched.

### Step 7 — Play

1. Turn on your headset and start **SteamVR**. Wait until SteamVR shows the
   headset and both controllers as connected (green).
2. Open your **installation folder** from step 6 (not the mod download folder)
   and double-click **Launch-HP1-VR-V31.exe**. Never start `HP.exe` directly.
3. Put on the headset and stand up straight while the game starts.
4. Squeeze both grips to recenter. Open VR settings with the **game-menu button
   + right grip** (left Y on Touch, left B on Index, left menu button on Vive)
   and follow [first-run calibration](CONTROLS.md#first-run-calibration).

Your saves and settings live inside the installation folder. To move it, move
the whole folder; it no longer needs the original game folder.

### If the installer stops

| Message | What to do |
|---|---|
| `Required file missing: …\System\…` or `…\Maps\Lev_Tut1.unr` | The first box is not the game folder. Pick the folder that contains `System` and `Maps`. |
| `Unsupported engine/script build: …` | Your game files are a different version or are modded. This build only works with the tested English files; do not swap in random DLLs. |
| `This installer expects the HP1 DX11 renderer 1.6.2…` or `Renderer 1.6.2 component mismatch` | Re-download the renderer from the link above (version 1.6.2, HP1 build) and extract it fresh. |
| `Texture pack must contain its Textures folder` | Pick the folder that directly contains `System` and `Textures`. |
| `Texture pack version/file mismatch` | Re-download ESRGAN pack **v3** and extract it with 7-Zip into a new folder. |
| `Destination is not empty` | Choose a new folder name for the installation. Nothing was overwritten. |
| `Package file damaged or changed: …` | The mod download is incomplete or was edited. Download the release ZIP again and extract it fresh. |
| Game shows a missing `MSVCR100.dll`, `D3DX11_43.dll` or `D3DCompiler_43.dll` | Redo step 2. |

For crashes, "Code 7" and other problems after installing, see
[TROUBLESHOOTING.md](TROUBLESHOOTING.md).

### Installer logs and support

Setup now displays live progress and saves detailed logs for **Verify inputs**
and **Install V31**. Use **Open full log** or **Copy result details** after an
error. The path is always shown in the installer. Default log folder:
`%LOCALAPPDATA%\HP1VR\InstallerLogs` (TEMP fallback if unavailable).

Logs include the failing stage, exact paths, expected/actual SHA-256 hashes,
copy verification, timings, prerequisite versions, error identifiers, full
exceptions and recovery guidance. The GUI displays recent lines; the full log
retains the complete operation. No logs are automatically uploaded.

Install.cmd keeps a console open for startup failures and writes an additional
`%TEMP%\HP1VR-V31-launcher-*.log`. If no setup window opens, read that file.
This is installer-only; the game's normal console-free launch is unchanged.
See [installer troubleshooting](TROUBLESHOOTING.md#installer-diagnostic-logs).
Logs contain local paths/usernames: review and redact them before sharing.

CLI users may add `-LogPath 'D:\Support\HP1VR-install.log'`. Choose a path outside
the kit, sources and destination. Validation writes diagnostic logs but does not
create the destination or prove that a later copy will have permission/free space.

### Download reference

- The renderer's HP1 DLL (`Harry Potter 1\d3d11drv.dll`) must have SHA-256
  `0F5952AD10236AA5BCFCB8FC45E558E52E26F08CA0E2BF70F4B602D6A940DA55`. Renderer
  DLLs for other games, or modified mirrors labeled 1.6.2, will be rejected.
- The texture pack is Akven's v3 release of January 4, 2022, a 4x upscale.
- SteamVR is not pinned to a version; use Steam's current stable release.
- Download pages were checked on October 7, 2026. The installer's download
  buttons only open these pages in your browser; nothing is downloaded or run
  automatically.

### Supported scope

No minimum GPU or guaranteed frame rate has been established. Bundled controller
bindings cover Oculus Touch, Index/Knuckles and Vive; other controllers may need
remapping in SteamVR. Regional game versions, community script revisions and
other gameplay mods are not supported. This kit contains the VR code, VR art,
controller bindings and Valve's OpenVR DLLs; it contains no game files, renderer
or texture pack.

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

Settings: Runtime/VR/V31Calibration.ini. Renderer: Runtime/System/StereoV31VR.ini.
Input: Runtime/System/VRUser.ini. Startup: HP1VR-V31.ini beside the launcher.
The October 11 naming update uses V31 runtime/configuration filenames throughout.
An existing calibration's internal section name remains compatible; its values
are preserved when migrating to V31Calibration.ini.
Keep UseJoystick=False. Resolution defaults to the current 1280-square eye
rendering; lower WorldSize to 1024 if performance suffers. Do not stack aggressive
SteamVR global/per-app supersampling without checking total render resolution.

## Saves, troubleshooting, removal

New installations start without personal saves. To migrate while both games are
closed, copy your Save*.usa and associated GameSaveInfo* files into Runtime/Save;
back up destination saves first. Save at an actual save book before boss fights.
Back up Runtime/Save and V31Calibration.ini before replacing an installation.
When migrating from an earlier V31 package, copy its V30Calibration.ini as
V31Calibration.ini; do not change the internal section name or reset its values.

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
