return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      -- Delete files outright instead of moving them to the system trash
      -- (gio/trash-cli aren't available in dev containers).
      trash = false,
    },
    picker = {
      ignored = true,
      hidden = true,
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { ".git", "node_modules" },
          layout = {
            layout = { position = "right" },
          },
          win = {
            input = {
              keys = {
                ["<esc>"] = { "", mode = "n" },
              },
            },
            list = {
              keys = {
                ["<esc>"] = { "", mode = "n" },
              },
            },
          },
        },
        files = { hidden = true },
      },
    },
  },
}
