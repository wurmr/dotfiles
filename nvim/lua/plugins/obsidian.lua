local vault = vim.fn.expand("~/.obsidian")

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  cmd = "Obsidian",
  event = {
    "BufReadPre " .. vault .. "/*.md",
    "BufNewFile " .. vault .. "/*.md",
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      { name = "personal", path = vault },
    },
    daily_notes = {
      folder = "journal",
    },
    -- render-markdown handles rendering
    ui = { enable = false },
  },
}
