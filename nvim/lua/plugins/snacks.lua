return {
  "folke/snacks.nvim",
  opts = {
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
