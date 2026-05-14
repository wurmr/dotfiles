-- Autostart: commands run on hyprland.start.

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprctl setcursor catppuccin-mocha-dark-cursors 24")

	-- XDPH / dbus
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

	hl.exec_cmd("kwalletd6")
	hl.exec_cmd("qs -c noctalia-shell")
	hl.exec_cmd("udiskie --tray")
	hl.exec_cmd("dropbox")
	hl.exec_cmd("/opt/localsend/localsend --hidden")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")

	-- Calendar services
	hl.exec_cmd("/usr/lib/evolution/evolution-source-registry")
	hl.exec_cmd("/usr/lib/goa-daemon")
	hl.exec_cmd("/usr/lib/evolution/evolution-calendar-factory")
end)
