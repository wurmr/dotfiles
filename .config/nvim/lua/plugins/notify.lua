return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    require("notify").setup {
      render = "compact",
      fps = 60,
      top_down = false, -- place notifications at bottom
    }
  end,
}
