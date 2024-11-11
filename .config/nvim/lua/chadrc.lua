-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :(

require "configs.nvim-tree"

---@type ChadrcConfig
local M = {
  ui = {
    statusline = {
      theme = "default",
      separator_style = "round",
    },
    tabufline = {
      order = { "tabs", "buffers", "treeOffset" },
    },
  },
  base46 = {
    theme = "catppuccin",
    theme_toggle = { "catppuccin", "github_light" },
    transparency = false,

    -- hl_override = {
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
    -- },
  },
  
  nvdash = {
    load_on_startup = true,
  },
}

return M
