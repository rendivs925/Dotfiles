return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
  config = function()
    vim.g.rustaceanvim = {
      server = {
        settings = {
          ["rust-analyzer"] = {
            procMacro = { enable = true },
            completion = { autoimport = { enable = false } },
            inlayHints = { enable = false },
            semanticHighlighting = { enable = false },
            checkOnSave = {
              command = "check",
            },
            diagnostics = {
              enable = true,
            },
          },
        },
        on_attach = function(client, bufnr)
          client.server_capabilities.semanticTokensProvider = nil

          local map = function(keys, func)
            vim.keymap.set("n", keys, func, { noremap = true, silent = true, buffer = bufnr })
          end
          map("<leader>ca", vim.lsp.buf.code_action)
        end,
      },
    }
  end,
}
