-- Window rules and layer rules.

-- Fix PWA windows
hl.window_rule({ name = "tile-edge", match = { class = "Microsoft-edge" }, tile = true })
hl.window_rule({ name = "tile-chrome", match = { class = "Google-chrome" }, tile = true })

-- Center the VncViewer connection popup
hl.window_rule({ name = "center-vnc", match = { class = "Vncviewer" }, center = true })

-- Block screen sharing of the Bitwarden window
hl.window_rule({
	name = "bitwarden-no-screen-share",
	match = { class = "^(Bitwarden)$" },
	no_screen_share = true,
})

hl.layer_rule({
	name = "noctalia",
	match = { namespace = "noctalia-background-.*$" },
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})
