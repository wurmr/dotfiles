local has_clipboard_tool = vim.fn.executable("wl-copy") == 1
  or vim.fn.executable("xclip") == 1
  or vim.fn.executable("xsel") == 1

if not has_clipboard_tool then
  local osc52 = require("vim.ui.clipboard.osc52")
  vim.g.clipboard = {
    name = "OSC 52 (Copy-Only Fallback)",
    copy = {
      ["+"] = osc52.copy("+"),
      ["*"] = osc52.copy("*"),
    },
    paste = {
      ["+"] = function()
        return vim.split(vim.fn.getreg('"'), "\n")
      end,
      ["*"] = function()
        return vim.split(vim.fn.getreg('"'), "\n")
      end,
    },
  }
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
