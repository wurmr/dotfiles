return {
  "huggingface/llm.nvim",
  opts = {
    backend = "ollama",
    model = "starcoder2:7b",
    -- model = "codellama:7b-code",
    -- model = "deepseek-coder:6.7b",
    url = "http://localhost:11434",
    request_body = {
      temperature = 0.2,
      top_p = 0.95,
    },
  },
}
