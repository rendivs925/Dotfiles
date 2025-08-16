vim.g.rustaceanvim = {
  server = {
    settings = {
      ["rust-analyzer"] = {
        procMacro = {
          enable = true,
        },
        checkOnSave = {
          enable = false,
        },
      },
    },

    on_attach = function(client, bufnr)
      if client.server_capabilities.semanticTokensProvider then
        client.server_capabilities.semanticTokensProvider = nil
      end

      local map = function(keys, func)
        vim.keymap.set("n", keys, func, { noremap = true, silent = true, buffer = bufnr })
      end

      map("<leader>ca", vim.lsp.buf.code_action)
      map("K", vim.lsp.buf.hover)
      map("gr", vim.lsp.buf.references)
    end,
  },
}

return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
}
