return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  opts = {
    ensure_installed = {
      "json", "javascript", "java", "typescript", "tsx",
      "rust", "asm", "yaml", "html", "css",
      "prisma", "hurl", "python", "markdown", "markdown_inline",
      "graphql", "php", "bash", "lua", "vim",
      "gitignore", "query", "vimdoc", "c", "smali",
    },
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter").setup(opts)
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
    })
  end,
}
