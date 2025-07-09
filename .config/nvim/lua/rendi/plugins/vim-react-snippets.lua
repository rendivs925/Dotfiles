return {
  "mlaursen/vim-react-snippets",
  lazy = true,
  ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  config = function()
    require("vim-react-snippets").lazy_load()
  end,
}
