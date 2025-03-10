return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {
    debugm = true,
    provider = "ollama",
    ollama = {
      api_key_name = "",
      endpoint = "http://127.0.0.1:11434",
      model = "qwen2.5-coder:latest",
      options = {
        num_ctx = 32768,
        temperature = 0,
      },
      stream = true,
    },
  },
  build = "make",
}
