return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>mp", function() require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 2000 }) end, desc = "Format file or range", mode = { "n", "v" } },
  },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        rust = { "rustfmt" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
      },
      formatters = {
        prettier = {
          stop_after_first = true,
        },
      },
      format_on_save = function()
        return {
          lsp_fallback = true,
          async = true,
          timeout_ms = 500,
        }
      end,
    })

  end,
}
