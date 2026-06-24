return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    current_line_blame = true,
    current_line_blame_opts = { delay = 500 },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = { interval = 1000 },
    attach_to_untracked = true,
    on_attach = function()
      local c = require("rendi.core.palette")

      vim.api.nvim_set_hl(0, "GitSignsAdd",          { fg = c.git_add })
      vim.api.nvim_set_hl(0, "GitSignsChange",       { fg = c.git_change })
      vim.api.nvim_set_hl(0, "GitSignsDelete",       { fg = c.git_delete })
      vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = c.git_change })
      vim.api.nvim_set_hl(0, "GitSignsTopdelete",    { fg = c.git_delete })
      vim.api.nvim_set_hl(0, "GitSignsUntracked",    { fg = c.git_untracked })
    end,
  },
}
