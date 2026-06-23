return {
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
  },
  {
    "mlaursen/vim-react-snippets",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    dependencies = { "L3MON4D3/LuaSnip" },
  },
}
