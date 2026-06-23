return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { "hrsh7th/cmp-nvim-lsp", lazy = true },
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "graphql",
        "emmet_ls",
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({ capabilities = capabilities })
        end,

        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
                telemetry = { enable = false },
              },
            },
          })
        end,

        ["ts_ls"] = function()
          require("lspconfig").ts_ls.setup({
            capabilities = capabilities,
            init_options = {
              plugins = {
                { name = "@vue/typescript-plugin", location = "", languages = { "vue" } },
              },
            },
            settings = {
              typescript = { inlayHints = { includeInlayParameterNameHints = "all" } },
              javascript = { inlayHints = { includeInlayParameterNameHints = "all" } },
            },
          })
        end,

        ["emmet_ls"] = function()
          require("lspconfig").emmet_ls.setup({
            capabilities = capabilities,
            filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
          })
        end,

        ["tailwindcss"] = function()
          require("lspconfig").tailwindcss.setup({
            capabilities = capabilities,
            settings = {
              tailwindCSS = {
                includeLanguages = {
                  typescriptreact = "javascript",
                  javascriptreact = "javascript",
                },
              },
            },
          })
        end,

        ["rust_analyzer"] = function() end,
      },
    })
  end,
}
