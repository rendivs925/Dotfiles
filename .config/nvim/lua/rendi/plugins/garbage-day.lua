return {
  "zeioth/garbage-day.nvim",
  dependencies = "neovim/nvim-lspconfig",
  event = "VeryLazy",
  opts = {
    aggressive_mode = false,
    grace_period = 15,
  },
  debug = {
    notifications = true,
    retries = 3,
    timeout = 1000,
  },
  setup = function()
    local garbage_day_utils = require("garbage-day.utils")

    local function stop_lsp()
      garbage_day_utils.stop_lsp()
    end

    local function start_lsp()
      garbage_day_utils.start_lsp()
    end

    vim.api.nvim_set_keymap("n", "<leader>sl", ":lua stop_lsp()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>sr", ":lua start_lsp()<CR>", { noremap = true, silent = true })
  end,
}
