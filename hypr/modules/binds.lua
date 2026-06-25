-- Keybindings + resize submap.
--
-- Scrolling is the only layout (see look.lua / workspaces.lua). The layout
-- messages used below (promote, swapcol, consume_or_expel, fit, colresize) are
-- native scrolling-layout messages dispatched via hl.dsp.layout(msg).

local mainMod = "SUPER"
local terminal = "ghostty"
local browser = "zen-browser"
local ipc = "qs -c noctalia-shell ipc call"

-- Pyprland binds
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("pypr shift_monitors +1"))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("pypr toggle cider && hyprctl dispatch bringactivetotop"))

-- Media controls
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Noctalia core
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(ipc .. " launcher toggle"))
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd(ipc .. " launcher emoji"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(ipc .. " controlCenter toggle"))
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd(ipc .. " settings toggle"))

-- Noctalia session
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd(ipc .. " lockScreen lock"))

-- Noctalia media keys (locked + repeating like bindel/bindl)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. " volume increase"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. " volume decrease"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. " volume muteOutput"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. " brightness increase"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. " brightness decrease"), { locked = true, repeating = true })

-- Apps + window ops
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + W", hl.dsp.group.toggle())

-- Scrolling layout: column ordering / promotion
hl.bind(mainMod .. " + P", hl.dsp.layout("promote")) -- window -> its own new column
hl.bind(mainMod .. " + O", hl.dsp.layout("swapcol r")) -- swap column with right neighbor
hl.bind(mainMod .. " + I", hl.dsp.layout("swapcol l")) -- swap column with left neighbor

-- Scrolling layout: combine / split within a column (vertical stacking)
-- alone in a column -> consume into neighbor; stacked -> expel to its own column
hl.bind(mainMod .. " + U", hl.dsp.layout("consume_or_expel next"))
hl.bind(mainMod .. " + Y", hl.dsp.layout("consume_or_expel prev"))

-- Scrolling layout: column sizing
hl.bind(mainMod .. " + E", hl.dsp.layout("fit all")) -- grow active column into free space
hl.bind(mainMod .. " + equal", hl.dsp.layout("colresize +conf")) -- cycle to a wider preset
hl.bind(mainMod .. " + minus", hl.dsp.layout("colresize -conf")) -- cycle to a narrower preset

-- Move focus
for key, dir in pairs({ H = "l", L = "r", K = "u", J = "d" }) do
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = dir }))
end

-- Move windows
for key, dir in pairs({ H = "l", L = "r", K = "u", J = "d" }) do
	hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ direction = dir }))
end

-- Workspace switching + window-to-workspace (1, 2, 7, 8, 9, 0 -> 10)
for _, ws in ipairs({ 1, 2, 7, 8, 9, 10 }) do
	local key = ws == 10 and "0" or tostring(ws)
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = ws }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws }))
end

-- Resize submap
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
	hl.bind("L", hl.dsp.window.resize({ x = 75, y = 0, relative = true }, { repeating = true }))
	hl.bind("H", hl.dsp.window.resize({ x = -75, y = 0, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = -80, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = 80, relative = true }), { repeating = true })
	hl.bind("Escape", hl.dsp.submap("reset"))
end)

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move windows with mainMod + LMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
