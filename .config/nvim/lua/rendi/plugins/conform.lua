return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        rust = { "rustfmt_with_leptos" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
      },
      formatters = {
        rustfmt_with_leptos = {
          command = "sh",
          args = {
            "-c",
            "rustfmt --emit stdout | leptosfmt --stdin --rustfmt",
          },
          stdin = true,
          stdout = true,
          condition = function()
            return vim.fn.executable("rustfmt") == 1 and vim.fn.executable("leptosfmt") == 1
          end,
        },
      },
      format_on_save = function()
        return {
          lsp_fallback = true,
          async = false,
          timeout_ms = 2000,
        }
      end,
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 2000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
