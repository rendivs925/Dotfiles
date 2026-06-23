return {
  "echasnovski/mini.nvim",
  version = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("mini.indentscope").setup({
      symbol = "│",
      options = { try_as_border = true },
    })

    vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#627E97", nocombine = true })
  end,
}
