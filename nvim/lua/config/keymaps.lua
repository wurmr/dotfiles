-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>bs", "<cmd>SudaWrite<cr>", { desc = "Write with sudo" })
vim.keymap.set("n", "<leader>bu", "<cmd>e!<cr>", { desc = "Undo (Reload from disk)" })

vim.keymap.set("i", "jj", "<ESC>", { silent = true })

vim.keymap.set("n", "<leader>mx", function()
  local line = vim.api.nvim_get_current_line()
  local new_line
  if line:match("%[x%]") then
    new_line = line:gsub("%[x%]", "[ ]", 1)
  elseif line:match("%[ %]") then
    new_line = line:gsub("%[ %]", "[x]", 1)
  end
  if new_line then
    vim.api.nvim_set_current_line(new_line)
  end
end, { desc = "Toggle Checkbox" })

vim.keymap.set("n", "q", function()
  return vim.fn.reg_recording() ~= "" and "q" or "<Nop>"
end, { expr = true, desc = "Stop macro / block q" })
vim.keymap.set("n", "Q", "q", { desc = "Record macro" })
