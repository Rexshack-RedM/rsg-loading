# rsg-loading

A clean, configurable loading screen for RedM servers running the RSG Framework.

![RedM](https://img.shields.io/badge/RedM-rdr3-red) ![Lua](https://img.shields.io/badge/Lua-5.4-blue) ![Version](https://img.shields.io/badge/version-1.0.0-green)

## Features

- Custom background image with adjustable dim
- Branded title and subtitle
- Live progress bar driven by RedM's native `loadFraction` events
- Rotating tips with fade transition and configurable interval
- Status text and in-game clock
- Simulated progress fallback, so it previews correctly in a normal browser
- Safety net auto-close after 45 seconds if the game never signals completion
- Everything configured through JSON — no Lua edits needed

## Installation

1. Place the `rsg-loading` folder in your server's `resources` directory.
2. Add it to your `server.cfg`:
   ```cfg
   ensure rsg-loading
   ```
3. Restart the server.

> Only one resource can provide a `loadscreen`. Remove or stop any other loading screen resource.

## Configuration

All settings live in `html/config.json`:

```json
{
  "background_image": "images/background.jpeg",
  "background_dim": 0.45,
  "text": {
    "brand_title": "RSG Framework",
    "brand_subtitle": "R E D E M P T I O N  A W A I T S",
    "status_loading": "Saddling up…",
    "status_ready": "Ready.",
    "footer_resource_name": "rsg-loading",
    "tips": [
      "Tip: Community is everything, be part of it."
    ]
  },
  "tip_interval_seconds": 5
}
```

| Key | Description |
| --- | --- |
| `background_image` | Path relative to `html/`, or a full URL. Falls back to a dark gradient if missing. |
| `background_dim` | Darkness overlay on the background, `0` (none) to `1` (black). |
| `text.brand_title` | Main heading. |
| `text.brand_subtitle` | Line under the heading. |
| `text.status_loading` | Status text while loading. |
| `text.status_ready` | Status text when loading completes. |
| `text.footer_resource_name` | Text shown in the footer. |
| `text.tips` | Array of tips rotated during loading. |
| `tip_interval_seconds` | Seconds between tip changes. |

### Text priority

Text is merged in this order (later wins):

1. Built-in fallback in `script.js`
2. `html/locales/en.json`
3. The `text` block in `html/config.json`

For a simple setup, just edit `config.json`. Use `locales/en.json` as your base language file and leave keys out of `config.json` if you want the locale to apply.

### Changing the background

Drop your image into `html/images/` and update `background_image` in `config.json`. Any file in `html/images/` is included automatically by the manifest. Keep images reasonably sized (a compressed 1920×1080 JPEG is ideal) so the screen appears quickly.

## How it closes

The manifest sets `loadscreen_manual_shutdown 'yes'`. The screen closes when:

- it receives an `endLoading` NUI message (`eventName` or `type`), or
- the 45-second safety timeout fires.

It then calls `shutdownLoadingScreenNui` itself. If you'd rather close it from Lua once the player has spawned or picked a character, add a client script such as:

```lua
AddEventHandler('RSGCore:Client:OnPlayerLoaded', function()
    ShutdownLoadingScreenNui()
end)
```

## Custom status messages

Any NUI message containing a `statusText` string updates the status line, e.g. from a client script:

```lua
SendLoadingScreenMessage(json.encode({ statusText = 'Loading world…' }))
```

## Previewing

Open `html/index.html` in a browser (via a local web server so `fetch` can read the JSON files, e.g. `npx serve html`). Progress will be simulated.

## File structure

```
rsg-loading/
├── fxmanifest.lua
└── html/
    ├── index.html
    ├── style.css
    ├── script.js
    ├── config.json
    ├── locales/
    │   └── en.json
    └── images/
        └── background.jpeg
```

## Credits

Created by **RexShack** for the RSG Framework.
