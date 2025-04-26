return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  lazy = false,
  ft = { "rust" },
  config = function()
    vim.g.rustaceanvim = {
      server = {
        autostart = true,
        on_attach = function(client, bufnr)
          local opts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
        settings = {
          ["rust-analyzer"] = {
            linkedProjects = {
              "frontend/Cargo.toml",
              "backend/Cargo.toml",
              "shared/Cargo.toml",
            },
            cargo = { allFeatures = true },
            checkOnSave = { command = "check" },
            diagnostics = { enable = true },
            procMacro = { enable = true },
            completion = { autoimport = { enable = false } },
            workspace = { symbol = { search = { limit = 500 } } },
            standalone = false,
          },
        },
      },
    }
  end,
}
