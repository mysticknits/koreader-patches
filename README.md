# koreader-patches

User patches for [KOReader](https://github.com/koreader/koreader). Drop these into the `koreader/patches/` directory on your device.

## Patches

### UI & Theming

| Patch | Description |
|-------|-------------|
| `2--ui-font.lua` | Custom UI font override. **Must be the first patch executed** (naming ensures load order). |
| `2--disable-all-PT-widgets.lua` | Disables Project: Title UI elements — progress icons, status widgets, cover borders, and series indicators. |
| `2-pt-mm-noborders.lua` | Removes borders/lines from MosaicMenu (grid view) covers. |
| `2-pt-titlebar.lua` | Normalizes title bar center icon size and spacing. |
| `2-statusbar-better-compact.lua` | Improves compact status bar — better frontlight icons, adds battery percentage, better separator handling. |

### Cover Browser & File Manager

| Patch | Description |
|-------|-------------|
| `2-badge-series.lua` | Adds a series indicator badge to the right side of book covers. |
| `2-percent-badge.lua` | Adds a progress percentage badge to the bottom left corner of book covers. |
| `2-browser-folder-cover.lua` | Custom folder cover display in the file browser. |
| `2-book-receipt-frankenpatch.lua` | Book receipt-style display patch for cover browser. |
| `2-favorites-shows-collections.lua` | Makes the Favorites menu item show all collections instead of just Favorites. |
| `2-filemanager-menu-separator.lua` | Adds a visual separator to the last built-in item in the file manager settings menu, so plugin-added items are visually distinct. |

### Reader

| Patch | Description |
|-------|-------------|
| `2-customise-highlight-colors.lua` | Custom display text and hex values for highlight colors. |
| `2-readerrolling-position-fix.lua` | Fixes a bug where restoring from `last_percent` in page mode called `gotoPos(0)`, resetting to page 1 instead of the saved page. |

### Device

| Patch | Description |
|-------|-------------|
| `2-kobo-virtual-library-startup.lua` | Adds support for Kobo kepub files on startup via virtual library integration. |

## Installation

1. Copy the desired `.lua` files into `koreader/patches/` on your device.
2. Restart KOReader.

Patches prefixed with `2-` run at priority 2 (after KOReader core init). The `2--` prefix (double dash) ensures those patches load before others at the same priority level.

To disable a patch, rename it with a `.disabled` extension (e.g., `2-badge-series.lua.disabled`).
