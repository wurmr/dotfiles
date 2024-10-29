return {
  "nvim-telescope/telescope-ui-select.nvim",
  lazy = false,
  config = function()
    require("telescope").setup {
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            winblend = 10,
            border = true,
            previewer = false,
            layout_config = {
              width = 0.5,
              height = 0.65,
            },
          }
        }
      }
    }

    require("telescope").load_extension("ui-select")
  end,
}
