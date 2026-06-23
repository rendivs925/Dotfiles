return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    spec = {
      { "<leader>f", group = "Telescope" },
      { "<leader>g", group = "Search" },
      { "<leader>G", group = "Search" },
      { "<leader>zg", group = "Search" },
      { "<leader>zG", group = "Search" },
      { "<leader>q", group = "Comment cleanup" },
      { "<leader>w", group = "Window" },
      { "<leader>t", group = "Tab" },
      { "<leader>x", group = "Trouble" },
      { "<leader>m", group = "Set mark" },
      { "<leader>j", group = "Jump mark" },
      { "<leader>l", group = "Lazy/Plugin" },
      { "<leader>s", group = "Substitute", mode = "n" },
      { "<leader>S", group = "Substitute to EOL" },
      { "<leader>s", group = "Silicon", mode = "v" },
      { "<leader>c", group = "Change/Code" },
      { "<leader>d", group = "Delete" },
      { "<leader>p", group = "Paste" },
      { "<leader>z", group = "Zen/Wrap" },
      { "<leader>h", group = "Hurl" },
      { "<leader>e", group = "NvimTree" },
    },
  },
}
