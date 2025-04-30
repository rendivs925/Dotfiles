return {
  "zeioth/garbage-day.nvim",
  dependencies = "neovim/nvim-lspconfig",
  event = "VeryLazy",
  opts = {
    aggressive_mode = false,
  },
  debug = {
    retries = 3,
    timeout = 1000,
  },
}
