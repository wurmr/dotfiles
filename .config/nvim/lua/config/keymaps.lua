-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume" }
)

-- Map ; to command palet like NvChad
vim.keymap.set("n", ";", ":", { noremap = true, silent = false })

vim.keymap.set("n", "<leader>bs", ":SudaWrite<CR>", { desc = "Write with sudo" })
