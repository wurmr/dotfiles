-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "biome", "ts_ls" }
local nvlsp = require "nvchad.configs.lspconfig"
local lspformat = require "lsp-format"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = function()
      return { nvlsp.on_attach, lspformat.on_attach }
    end,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- lspconfig.biome.setup {
--   on_attach = nvlsp.on_attach,
--   capabilities = nvlsp.capabilities,
--   single_file_support = true,
-- }

-- vim.lsp.handlers["textDocument/codeAction"] = require("telescope.builtin").lsp_code_actions
-- Setup biome LSP
-- configuring single server, example: typescript
-- lspconfig.typescript.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
-- }
