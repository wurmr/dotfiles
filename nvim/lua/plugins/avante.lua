return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {
    debug = false,
    provider = "ollama",
    auto_suggestions_provider = "ollama",
    behaviour = {
      auto_suggestions = true,
      enable_cursor_planning_mode = true,
    },
    ollama = {
      model = "qwen2.5-coder:7b",
      stream = true, -- stream required for avante to see files in the side pane
    },
  },
  build = "make",
}
