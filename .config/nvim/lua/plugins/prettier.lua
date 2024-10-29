return  {
  "MunifTanjim/prettier.nvim",
  lazy = false,
  dependencies = {
    "jose-elias-alvarez/null-ls.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("prettier").setup {
      bin = "prettier",
      cli_options = {
        semi = false,
        single_quote = true,
      }
    }
  end,
}
