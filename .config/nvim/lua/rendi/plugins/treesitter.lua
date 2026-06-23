return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
    })

    local languages = {
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

    require("nvim-treesitter").setup()
    require("nvim-treesitter").install(languages)

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("rendi_treesitter", { clear = true }),
      callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)
        if ok then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
