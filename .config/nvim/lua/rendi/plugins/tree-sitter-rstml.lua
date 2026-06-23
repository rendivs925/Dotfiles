return {
  "rayliwell/tree-sitter-rstml",
  ft = "rust",
  dependencies = { "nvim-treesitter" },
  build = ":TSUpdate",
  config = function()
    require("tree-sitter-rstml").setup()
  end,
}
