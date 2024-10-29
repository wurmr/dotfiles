require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "i", "n" }, "<leader>gi", ":Neogit<CR>", { desc = "Open Neogit" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map({ "n" }, "<leader>sw", ":w !sudo tee % > /dev/null", { desc = "Write with sudo" })
map({"n"}, "<leader>fp", ":Prettier<CR>", { desc = "Format with Prettier" })
-- map(
--   { "n", "i" },
--   "<C-.>",
--   "<cmd>lua vim.lsp.buf.code_action()<CR>",
--   { desc = "Code Action" }
-- )
