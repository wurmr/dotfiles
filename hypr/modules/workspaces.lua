-- Workspace-to-monitor pinning + per-workspace layout.

hl.workspace_rule({ workspace = "1", monitor = "DP-1", layout = "scrolling", default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1", layout = "scrolling" })
hl.workspace_rule({
	workspace = "7",
	monitor = "DP-3",
	layout = "scrolling",
	layout_opts = { orientation = "right" },
	default = true,
	persistent = true,
})
hl.workspace_rule({
	workspace = "8",
	monitor = "DP-3",
	layout = "scrolling",
	layout_opts = { orientation = "right" },
	persistent = true,
})
hl.workspace_rule({
	workspace = "9",
	monitor = "DP-1",
	layout = "scrolling",
	layout_opts = { orientation = "right" },
	default_name = "code",
})
hl.workspace_rule({ workspace = "10", monitor = "DP-1", layout = "master", default_name = "msrs" })
