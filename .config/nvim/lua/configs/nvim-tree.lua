-- nvim-tree config
local nvim_tree = require "nvim-tree"

nvim_tree.setup {
  view = {
    side = "right",
  },
}

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("NvimTreeOpen")
  end,
})
