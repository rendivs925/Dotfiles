return {
  "zeioth/garbage-day.nvim",
  dependencies = "neovim/nvim-lspconfig",
  event = "BufReadPre",
  opts = {
    aggressive_mode = true,
    excluded_lsp_clients = { "rust_analyzer" },
    grace_period = 60 * 15,
  },
  config = function()
    local lspconfig = require("lspconfig")
    lspconfig.rust_analyzer.setup({
      on_attach = function(client, bufnr)
        if vim.api.nvim_buf_is_loaded(bufnr) then
        end
      end,
    })
  end,
  debug = {
    notifications = true,
    retries = 3,
    timeout = 1000,
  },
}
