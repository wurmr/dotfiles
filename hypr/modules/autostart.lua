-- Autostart: commands run on hyprland.start.

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprctl setcursor catppuccin-mocha-dark-cursors 24")

	-- XDPH / dbus
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

	-- Secret Service. As of kwallet 6.30 (KF6 6.30.0) ksecretd is the real daemon
	-- and owns org.freedesktop.secrets; kwalletd6 is only a compat shim that
	-- proxies the legacy org.kde.kwalletd6 API onto it (and is D-Bus activated
	-- on demand, so it does not need starting here). org.freedesktop.secrets has
	-- no D-Bus activation file, so ksecretd must be started explicitly.
	hl.exec_cmd("ksecretd")
	hl.exec_cmd("noctalia -d")
	hl.exec_cmd("udiskie --smart-tray")
	hl.exec_cmd("dropbox")
	hl.exec_cmd("/opt/localsend/localsend --hidden")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")

	-- Calendar services
	hl.exec_cmd("/usr/lib/evolution/evolution-source-registry")
	hl.exec_cmd("/usr/lib/goa-daemon")
	hl.exec_cmd("/usr/lib/evolution/evolution-calendar-factory")
end)
