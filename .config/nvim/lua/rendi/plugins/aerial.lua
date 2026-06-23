return {
  "stevearc/aerial.nvim",
  event = "VeryLazy",
  opts = {
    backends = { "lsp", "treesitter", "markdown" },
    show_guides = true,
    layout = {
      max_width = { 40, 0.3 },
      min_width = 30,
    },
    keymaps = {
      ["<CR>"] = "actions.jump",
      ["<C-v>"] = "actions.jump_vsplit",
      ["<C-s>"] = "actions.jump_split",
      ["o"] = "actions.jump",
      ["t"] = "actions.toggle_tree",
    },
  },
  keys = {
    { "<leader>cs", "<cmd>AerialToggle<CR>", desc = "Toggle code outline (Aerial)" },
  },
}
