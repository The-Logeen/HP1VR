# License and redistribution status

[README](README.md) · [Credits](CREDITS.md) · [License](LICENSE)

## Decisions recorded October 11, 2026

1. **Maintainer-authored code and documentation:** released by The-Logeen under
   the [MIT License](LICENSE). This kit ships binaries; the C++ source tree is
   not part of it, so the MIT grant applies to what is included here.
2. **Avatar and wand art:** the maintainer reports these were obtained as free
   assets. Record each asset's source page and license in CREDITS.md; free to
   download is not always free to redistribute, and some free licenses require
   attribution. Avatar geometry is also compiled into the probe binary.
3. **Lesson rune and water art** (`LessonRunes.pcx`, `Rune_FlipPattern.pcx`,
   `SafeWater.pcx`): origin still to be recorded in CREDITS.md.
4. **OpenVR:** Valve's [license notice](OPENVR-LICENSE.txt) still applies to the
   bundled OpenVR DLLs. The MIT License does not replace it.
5. **Base game, renderer and texture pack:** not bundled. Users obtain their own
   copies and remain subject to those components' terms.
6. **Private installed game:** contains game content and may contain personal
   saves. It is not the distributable mod kit and must not be uploaded.

The repository is public so people can install and play the mod. Rerun package
validation (reseal package-manifest.json) whenever a listed file changes.
This file records the maintainer's decisions; it is not legal advice.
