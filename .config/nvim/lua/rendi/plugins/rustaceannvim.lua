vim.g.rustaceanvim = {
  server = {
    settings = {
      ["rust-analyzer"] = {
        procMacro = {
          enable = true,
        },

        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
        },

        checkOnSave = {
          enable = false,
        },

        completion = {
          autoimport = { enable = true },
          postfix = { enable = true },
        },

        diagnostics = {
          enable = true,
          experimental = { enable = false },
        },

        inlayHints = { enable = false },
        semanticHighlighting = { enable = false },
        lens = { enable = false },

        hover = {
          actions = {
            enable = false,
          },
        },

        files = {
          watcher = "client",
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
      map("gr", vim.lsp.buf.references)
      map("K", vim.lsp.buf.hover)
    end,
  },
}

return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
}
