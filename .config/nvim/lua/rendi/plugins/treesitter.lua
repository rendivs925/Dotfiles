return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  -- build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
    })

    treesitter.setup({
      sync_install = false,
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "json",
        -- "dockerfile",
        "javascript",
        "java",
        "typescript",
        "tsx",
        "rust",
        "asm",
        "yaml",
        "html",
        "css",
        "prisma",
        "hurl",
        "python",
        "rust_with_rstml",
        "markdown",
        "markdown_inline",
        "graphql",
        "php",
        "bash",
        "lua",
        "vim",
        "gitignore",
        "query",
        "vimdoc",
        "c",
        "smali",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
