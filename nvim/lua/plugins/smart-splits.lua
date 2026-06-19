-- snacks picker/explorer windows are floats with relative="win", which trips
-- up smart-splits' screen-edge detection (it reads the window-relative col=0 as
-- if it were the absolute screen position, so e.g. a right-side explorer looks
-- like it's hugging the left edge and ctrl-h gets routed to tmux instead of the
-- editor). For those windows, navigate with plain winnr logic and only hand off
-- to the multiplexer when there's genuinely no nvim window in that direction.
local function in_snacks_float()
  return vim.api.nvim_win_get_config(0).relative ~= "" and vim.bo.filetype:match("^snacks_picker") ~= nil
end

---@param wincmd string "h"|"j"|"k"|"l"
---@param direction string "left"|"down"|"up"|"right"
local function move(wincmd, direction)
  return function()
    if in_snacks_float() then
      if vim.fn.winnr(wincmd) ~= vim.fn.winnr() then
        vim.cmd("wincmd " .. wincmd)
      else
        require("smart-splits.mux").move_pane(direction, true, "stop")
      end
    else
      require("smart-splits")["move_cursor_" .. direction]()
    end
  end
end

return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  keys = {
    { "<c-h>", move("h", "left"), desc = "Move to left split" },
    { "<c-j>", move("j", "down"), desc = "Move to below split" },
    { "<c-k>", move("k", "up"), desc = "Move to above split" },
    { "<c-l>", move("l", "right"), desc = "Move to right split" },
    {
      "<c-\\>",
      function()
        require("smart-splits").move_cursor_previous()
      end,
      desc = "Move to previous split",
    },
  },
  opts = {
    -- tmux is auto-detected; navigation seamlessly crosses nvim windows and tmux panes
    at_edge = "stop",
    multiplexer_integration = "wezterm",
  },
}
