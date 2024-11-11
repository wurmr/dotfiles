return {
  "lukas-reineke/lsp-format.nvim",
  lazy = false,
  config = function()
    require("lsp-format").setup {}
    -- require("lspconfig").ts_ls.setup { on_attach = require("lsp-format").on_attach }
  end,
}
