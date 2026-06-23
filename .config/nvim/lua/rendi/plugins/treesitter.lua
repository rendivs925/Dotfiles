local parsers = {
  "json",
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
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local ts = require("nvim-treesitter")

    ts.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- Replacement for old ensure_installed.
    ts.install(parsers)

    -- Replacement for old highlight = { enable = true }.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)

        if ok then
          -- Replacement for old indent = { enable = true }.
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
    })
  end,
}
