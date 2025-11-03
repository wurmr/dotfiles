-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.keymap.set(
--   "n",
--   "<leader>sx",
--   require("telescope.builtin").resume,
--   { noremap = true, silent = true, desc = "Resume" }
-- )

vim.keymap.set("n", "<leader>bs", ":SudaWrite<CR>", { desc = "Write with sudo" })

vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>bu", ":e!<CR>", { desc = "Undo (Reload from disk)" })

-- vim.keymap.set("n", "yc", "yygccp", { noremap = true, desc = "Yank and comment" })
-- vim.keymap.set("n", "<C-c>", "ciw")
