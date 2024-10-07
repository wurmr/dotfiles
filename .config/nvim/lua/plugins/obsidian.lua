return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    "BufReadPre " .. vim.fn.expand "~" .. "/.obsidian/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/.obsidian/*.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/.obsidian",
      },
    },

    daily_notes = {
      templates = {
        default = "journal",
        personal = "personal",
      },
    },
    notes_sub_dir = "~/.obsidian/0 - Inbox/",
    new_notes_location = "~/.obsidian/0 - Inbox/",
  },
}
