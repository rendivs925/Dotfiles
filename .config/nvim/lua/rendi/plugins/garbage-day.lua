return {
  "zeioth/garbage-day.nvim",
  dependencies = "neovim/nvim-lspconfig",
  event = "BufReadPre",
  opts = {
    aggressive_mode = true,
    excluded_lsp_clients = { "rust_analyzer" },
    grace_period = 60 * 15,
  },
  debug = {
    notifications = true,
    retries = 3,
    timeout = 1000,
  },
}
