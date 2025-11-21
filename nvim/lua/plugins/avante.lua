return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  opts = {
    provider = "ollama",
    auto_suggestions_provider = "ollama",
    behaviour = {
      auto_suggestions = false,
      enable_cursor_planning_mode = true,
    },
    providers = {
      ollama = {
        disabled_tools = { "rag_search" },
        model = "gpt-oss:20b",
        -- disable_tools = true,
        -- is_env_set = require("avante.providers.ollama").check_endpoint_alive,
      },
    },
  },
  build = "make",
}
