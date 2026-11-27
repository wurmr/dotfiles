-- ZSA Voyager, one backlight color per row (theme groups, so it follows the colorscheme)
local keyboard = {
  { "╭─┬─┬─┬─┬─┬─╮         ╭─┬─┬─┬─┬─┬─╮", "Keyword" },
  { "├─┼─┼─┼─┼─┼─┤         ├─┼─┼─┼─┼─┼─┤", "Function" },
  { "├─┼─┼─┼─┼─┼─┤         ├─┼─┼─┼─┼─┼─┤", "Operator" },
  { "├─┼─┼─┼─┼─┼─┤         ├─┼─┼─┼─┼─┼─┤", "String" },
  { "╰─┴─┴─┴─┴─┼─┼─╮     ╭─┼─┼─┴─┴─┴─┴─╯", "Type" },
  { "          ╰─┴─╯     ╰─┴─╯", "Constant" },
}

local quotes = {
  { "Make it work, make it right, make it fast.", "Kent Beck" },
  { "Simplicity is prerequisite for reliability.", "Edsger W. Dijkstra" },
  { "Talk is cheap. Show me the code.", "Linus Torvalds" },
  { "First, solve the problem. Then, write the code.", "John Johnson" },
  { "The best way to predict the future is to invent it.", "Alan Kay" },
  { "Real artists ship.", "Steve Jobs" },
}

local function greeting()
  local hour = tonumber(os.date("%H"))
  if hour < 5 then
    return "Still up", "Let's make it count."
  elseif hour < 12 then
    return "Good morning", "What are we building today?"
  elseif hour < 17 then
    return "Good afternoon", "Let's ship something."
  elseif hour < 22 then
    return "Good evening", "Time to build."
  end
  return "Late night", "Let's make it count."
end

local function header()
  -- snacks centers each line on its own, so pad the art to one width to keep it aligned
  local width = vim.api.nvim_strwidth(keyboard[1][1])
  local text = {}
  for i, row in ipairs(keyboard) do
    local pad = string.rep(" ", width - vim.api.nvim_strwidth(row[1]))
    text[#text + 1] = { (i > 1 and "\n" or "") .. row[1] .. pad, hl = row[2] }
  end

  local hello, prompt = greeting()
  local quote = quotes[os.time() % #quotes + 1]
  vim.list_extend(text, {
    { "\n\n" .. hello .. ", ", hl = "desc" },
    { "@jkarg", hl = "special" },
    { ". " .. prompt, hl = "desc" },
    { '\n\n"' .. quote[1] .. '"', hl = "Comment" },
    { "\n- " .. quote[2], hl = "Comment" },
  })
  return text
end

return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      sections = {
        { text = header(), align = "center", padding = 2 },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    explorer = {
      -- Delete files outright instead of moving them to the system trash
      -- (gio/trash-cli aren't available in dev containers).
      trash = false,
    },
    picker = {
      ignored = true,
      hidden = true,
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { ".git", "node_modules" },
          layout = {
            layout = { position = "right" },
          },
          win = {
            input = {
              keys = {
                ["<esc>"] = { "", mode = "n" },
              },
            },
            list = {
              keys = {
                ["<esc>"] = { "", mode = "n" },
              },
            },
          },
        },
        files = { hidden = true },
      },
    },
  },
}
