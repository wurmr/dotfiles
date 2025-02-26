return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["_"] = { "caddy_fmt" },
      },

      formatters = {
        caddy_fmt = {
          command = "caddy",
          args = { "fmt" },
          stdin = true,
          condition = function(ctx)
            return vim.fs.basename(ctx.filename) ~= "Caddyfile"
          end,
        },
      },
    },
  },
}
