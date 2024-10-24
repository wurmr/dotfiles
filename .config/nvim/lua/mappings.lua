require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "i", "n" }, "<leader>gi", ":Neogit<CR>", { desc = "Open Neogit" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map({"n"}, "<leader>sw", ":w !sudo tee % > /dev/null", { desc = "Write with sudo"})
