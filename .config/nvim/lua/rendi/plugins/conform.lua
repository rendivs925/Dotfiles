return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        -- c = { "clang-format" },
        -- asm = { "asmfmt" },
        -- xml = { "xmlformatter" },
        -- cpp = { "clang-format" },
        -- java = { "google-java-format" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        -- svelte = { "prettier" },
        -- rust = { "rustfmt" },
        rust = { "leptosfmt" },
        -- css = { "prettier" },
        -- php = { "pint" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        -- blade = { "blade-formatter" },
        markdown = { "prettier" },
        -- graphql = { "prettier" },
        -- liquid = { "prettier" },
        lua = { "stylua" },
        -- python = { "black" },
      },
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        if ft == "rust" then
          return
        end
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
