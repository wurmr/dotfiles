return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      prettier = {
        cwd = require("conform.util").root_file({
          ".prettierrc",
          ".prettierrc.json",
          ".prettierrc.js",
          "prettier.config.js",
          "prettier.config.mjs",
          "package.json",
        }),
      },
    },
  },
}
