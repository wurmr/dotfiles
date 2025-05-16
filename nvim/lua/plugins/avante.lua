return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  cond = vim.env.COPILOT == nil,
  opts = {
    debug = false,
    provider = "ollama",
    auto_suggestions_provider = "ollama",
    behaviour = {
      auto_suggestions = false,
      enable_cursor_planning_mode = true,
    },
    ollama = {
      model = "qwen3:4b",
      stream = true, -- stream required for avante to see files in the side pane
    },
  },
  build = "make",
}
