return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
  ft = { "rust" },
  config = function()
    vim.g.rustaceanvim = {
      server = {
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
