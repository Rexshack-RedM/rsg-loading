# rsg-loading

A clean, configurable loading screen for RedM servers running the RSG Framework.

![RedM](https://img.shields.io/badge/RedM-rdr3-red) ![Lua](https://img.shields.io/badge/Lua-5.4-blue) ![Version](https://img.shields.io/badge/version-2.0.0-green)

## Features

- Custom background image with adjustable dim
- Branded title and subtitle
- Live progress bar driven by RedM's native `loadFraction` events
- Rotating tips with fade transition and configurable interval
- Status text and in-game clock
- Simulated progress fallback, so it previews correctly in a normal browser
- Safety net auto-close after 45 seconds if the game never signals completion
- Seasonal themes for Easter, Halloween and Christmas with their own colours, backgrounds, tips and particle effects (snow, bats, petals)
- Automatic theme switching by date, including Easter's moving date
- Winter, spring, summer and autumn themes used the rest of the year when no holiday is active
- Text and layout configured through JSON, seasonal themes through `config.lua`

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

## Seasonal themes

Seasonal themes are configured in `config.lua` in the resource root. The loading screen reads this file directly, because it shows before any Lua scripts run. Keep it to plain values (strings, numbers, booleans and tables); functions and logic are not supported.

```lua
Config.Theme     = 'auto'   -- 'auto', 'default', 'easter', 'halloween' or 'christmas'
Config.Particles = true     -- falling snow / bats / petals
Config.MergeTips = true     -- true = add seasonal tips to your normal tips, false = replace them
```

| `Config.Theme` | Behaviour |
| --- | --- |
| `'auto'` | Uses the holiday theme whose date window contains today; if none, the matching season theme (when `Config.UseSeasons = true`); otherwise the normal look. |
| `'default'` | Never uses a seasonal theme. |
| `'easter'` / `'halloween'` / `'christmas'` | Forces that holiday theme all year. Useful for testing. |
| `'winter'` / `'spring'` / `'summer'` / `'autumn'` | Forces that season theme all year. |

### Default date windows

| Theme | Window | Background |
| --- | --- | --- |
| Easter | 7 days before Easter Sunday to 1 day after (calculated each year) | `images/easter.jpeg` |
| Halloween | `10-15` to `11-01` | `images/halloween.jpeg` |
| Christmas | `12-01` to `12-31` | `images/christmas.jpeg` |

Dates use the player's local clock in `MM-DD` format. A window can wrap the new year, e.g. `start = '12-01', finish = '01-06'`.

### Season themes

When no holiday is active, `Config.Seasons` is checked. Holidays always take priority (so Christmas wins over winter in December). Set `Config.UseSeasons = false` to show your normal look instead.

| Season | Window | Particles | Background |
| --- | --- | --- | --- |
| Winter | `12-01` to `02-28` (leap day included) | snow | `images/winter.jpeg` |
| Spring | `03-01` to `05-31` | petals | `images/spring.jpeg` |
| Summer | `06-01` to `08-31` | fireflies | `images/summer.jpeg` |
| Autumn | `09-01` to `11-30` | leaves | `images/autumn.jpeg` |

### Theme options

Holiday entries in `Config.Themes` and season entries in `Config.Seasons` support the same options:

| Key | Description |
| --- | --- |
| `enabled` | Set `false` to skip this theme in `auto` mode. |
| `start` / `finish` | Date window in `MM-DD`. |
| `easterDaysBefore` / `easterDaysAfter` | Easter only: days either side of Easter Sunday. |
| `subtitle` | Replaces the brand subtitle. |
| `seal` / `divider` | Symbols shown in the round seal and the divider. |
| `particles` | `'snow'`, `'bats'`, `'petals'`, `'leaves'`, `'fireflies'`, or `''` for none. |
| `background` | Image path inside `html/` or a URL. Blank keeps the normal background. |
| `backgroundDim` | Darkness overlay for this theme, `0` to `1`. |
| `colors` | `accent`, `accent2` (progress bar gradient and highlights), `border`, `panel`, `panel2`, `text`, `muted`. |
| `tips` | Seasonal tips. |

To use your own seasonal artwork, drop the image into `html/images/` and change that theme's `background` path.

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

Serve the resource folder with a local web server so `fetch` can read the config files (e.g. `npx serve .` from the resource root), then open `/html/index.html`. Progress is simulated. Set `Config.Theme` to a season to preview it.

## File structure

```
rsg-loading/
├── fxmanifest.lua
├── config.lua          # seasonal themes
└── html/
    ├── index.html
    ├── style.css
    ├── script.js
    ├── config.json
    ├── locales/
    │   └── en.json
    └── images/
        ├── background.jpeg
        ├── easter.jpeg
        ├── halloween.jpeg
        ├── christmas.jpeg
        ├── winter.jpeg
        ├── spring.jpeg
        ├── summer.jpeg
        └── autumn.jpeg
```

## Credits

Created by **RexShack** for the RSG Framework.
