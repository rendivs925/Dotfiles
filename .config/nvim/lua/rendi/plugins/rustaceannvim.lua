return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
  config = function()
    vim.g.rustaceanvim = {
      server = {
        settings = {
          ["rust-analyzer"] = {
            procMacro = {
              enable = true,
            },
            checkOnSave = false,
            completion = {
              autoimport = {
                enable = false,
              },
            },
            inlayHints = {
              enable = false,
              -- parameterHints = { enable = false },
              -- typeHints = { enable = false },
              -- chainHints = { enable = false },
              -- ... other hint types
            },
            semanticHighlighting = {
              enable = false,
            },

            notifications = {},
          },
        },
        on_attach = function(_, bufnr)
          local map = function(keys, func)
            vim.keymap.set("n", keys, func, { noremap = true, silent = true, buffer = bufnr })
          end
          map("K", vim.lsp.buf.hover)
          map("gd", vim.lsp.buf.definition)
          map("<leader>ca", vim.lsp.buf.code_action)
        end,
      },
    }
  end,
}
