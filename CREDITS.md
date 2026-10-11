# Credits and third-party components

[README](README.md) · [License status](LICENSE-STATUS.md)

Attribution is not a substitute for redistribution permission. This list names
verified component authors without asserting ownership of unverified assets.

| Component | Credit | Distribution in this kit |
|---|---|---|
| Original 2001 PC game, characters, story, audio and game art | Their respective original creators and rights holders | Not included; user supplies a compatible installation |
| HP1 DX11 renderer 1.6.2 | darknovismc / Marcin Nowicki | Not included; separately downloaded |
| ESRGAN Upscale Pack v3 | Akven | Not included; separately downloaded |
| OpenVR client libraries | Valve Corporation | Included; [OpenVR license](OPENVR-LICENSE.txt) retained |
| VC++ 2010 and DirectX June 2010 runtimes | Microsoft | Official installers linked; not bundled in this public kit |
| SteamVR | Valve Corporation | Installed separately through Steam |
| 7-Zip | 7-Zip project | Optional extraction tool; linked, not bundled |
| V31 VR integration and packaging | The-Logeen | Mod binaries/configuration/scripts included; [MIT License](LICENSE) |

## Asset provenance still to confirm

The avatar was brought into the VR implementation from a rigged Harry
model/Unity asset workflow. The maintainer reports the avatar and wand are free
assets; add each one's source page, author and license below so users can see
the redistribution terms. Avatar geometry is embedded in the probe
binary as well as associated atlas files; simply removing an image is not a
complete provenance resolution.

The maintainer must also identify and record the source/license or original
authorship of the wand atlas, lesson/rune art and replacement-effect art:

- `payload/System/AvatarAtlas.bin` and `AvatarAtlas.pcx`, plus embedded geometry
- `payload/System/WandAtlas.pcx`
- `payload/System/LessonRunes.pcx` and `Rune_FlipPattern.pcx`
- `payload/System/SafeWater.pcx`

Do not infer a right to redistribute from possession of a source file or from
its appearance in a private build. Add verified author names, license notices
and permission records before publishing; replace or remove restricted material
through a rebuilt and retested package if necessary.

## Project status

This is an unofficial fan project, not an official release or an endorsement by
the game, franchise, renderer or platform owners. Nothing in the documentation
relicenses the original game or another creator's work. See the exact component
download pages in the [README](README.md) for their own terms and documentation.
