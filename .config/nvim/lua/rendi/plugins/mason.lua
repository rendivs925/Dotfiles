return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")

    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "ts_ls",
        "html",
        -- "rust_analyzer",
        "cssls",
        -- "asm_lsp",
        -- "jdtls",
        "tailwindcss",
        "lua_ls",
        "graphql",
        "emmet_ls",
        -- "prismals",
        -- "pyright",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        -- "isort",
        -- "black",
        -- "pylint",
        -- "asmfmt",
        -- "xmlformatter",
        -- "google-java-format",
        -- "clang-format",
      },
    })
  end,
}
