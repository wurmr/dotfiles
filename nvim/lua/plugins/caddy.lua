return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Only format actual Caddy files, not everything
        caddy = { "caddy_fmt" },
        caddyfile = { "caddy_fmt" },
      },
      formatters = {
        caddy_fmt = {
          command = "caddy",
          args = { "fmt", "-" },
          stdin = true,
          condition = function(ctx)
            -- Only run on Caddyfile or .caddy files
            return vim.fs.basename(ctx.filename) == "Caddyfile"
              or ctx.filename:match("%.caddy$")
              or ctx.filename:match("%.caddyfile$")
          end,
        },
      },
    },
  },
}
