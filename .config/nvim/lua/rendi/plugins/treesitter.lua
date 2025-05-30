return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- Configure blade parser for nvim-treesitter
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

    require("nvim-ts-autotag").setup({
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
      },
    })

    -- configure treesitter
    treesitter.setup({
      sync_install = false,
      -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "javascript",
        "java",
        "typescript",
        "tsx",
        "rust_with_rstml",
        "asm",
        "yaml",
        "html",
        "css",
        "prisma",
        "hurl",
        "python",
        "markdown",
        "markdown_inline",
        "graphql",
        "php",
        "bash",
        "lua",
        "vim",
        -- "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
        "rust",
        "smali",
      },
      -- incremental selection configuration
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
