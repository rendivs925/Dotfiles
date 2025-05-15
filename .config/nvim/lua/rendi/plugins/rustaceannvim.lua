return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
  config = function()
    vim.g.rustaceanvim = {
      server = {
        settings = {
          ["rust-analyzer"] = {
            procMacro = { enable = false },
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
        on_attach = function(_, bufnr)
          local map = function(keys, func)
            vim.keymap.set("n", keys, func, { noremap = true, silent = true, buffer = bufnr })
          end
          map("<leader>ca", vim.lsp.buf.code_action)
        end,
      },
    }
  end,
}
