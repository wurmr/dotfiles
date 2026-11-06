-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.winbar = "%=%m %f"
opt.ignorecase = true

vim.opt.clipboard = "unnamedplus"

local wl = vim.env.WAYLAND_DISPLAY
local has_wayland = wl
  and vim.fn.executable("wl-paste") == 1
  and vim.uv.fs_stat(wl:sub(1, 1) == "/" and wl or ((vim.env.XDG_RUNTIME_DIR or "") .. "/" .. wl)) ~= nil

if not has_wayland then
  local osc52 = require("vim.ui.clipboard.osc52")
  local function from_unnamed()
    return { vim.fn.getreg('"', 1, true), vim.fn.getregtype('"') }
  end
  vim.g.clipboard = {
    name = "osc52-copy-only",
    copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
    paste = { ["+"] = from_unnamed, ["*"] = from_unnamed },
  }
end
