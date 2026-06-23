return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-treesitter.config").setup({
      ensure_installed = {
        "json", "javascript", "java", "typescript", "tsx", "rust",
        "yaml", "html", "css", "prisma", "hurl", "python",
        "markdown", "markdown_inline", "graphql", "php", "bash",
        "lua", "vim", "gitignore", "query", "vimdoc", "c",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })

    require("nvim-ts-autotag").setup({
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = false,
    })
  end,
}
