-- Workspace-to-monitor pinning + names. Layout is scrolling globally (see look.lua),
-- so these rules only handle monitor pinning, persistence, and naming.
-- For a per-workspace scroll direction, use layout_opts = { direction = "..." }.

hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "7", monitor = "DP-3", default = true, persistent = true })
hl.workspace_rule({ workspace = "8", monitor = "DP-3", persistent = true })
hl.workspace_rule({ workspace = "9", monitor = "DP-1", default_name = "code" })
hl.workspace_rule({ workspace = "10", monitor = "DP-1", default_name = "msrs" })
