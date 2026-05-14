-- Hyprland config (Lua) — entry point.
-- For the new Lua format: https://wiki.hypr.land/Configuring/Start/
-- LSP stubs: /usr/share/hypr/stubs/hl.meta.lua (wired up via .luarc.json)
--
-- Monitors live here (machine-specific). Everything else is under modules/.

------------------
---- MONITORS ----
------------------

hl.monitor({ output = "DP-1", mode = "2560x1440@144", position = "0x0", scale = "1", bitdepth = 8, cm = "srgb" })
hl.monitor({ output = "DP-3", mode = "preferred", position = "0x-1440", scale = "1", bitdepth = 8, cm = "srgb" })
hl.monitor({ output = "HDMI-A-1", disabled = true })

-----------------
---- MODULES ----
-----------------

require("modules.env")
require("modules.autostart")
require("modules.input")
require("modules.look")
require("modules.rules")
require("modules.workspaces")
require("modules.binds")
