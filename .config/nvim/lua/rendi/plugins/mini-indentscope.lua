return {
  "echasnovski/mini.nvim",
  version = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("mini.indentscope").setup({
      symbol = "│",
      options = { try_as_border = true },
    })

    local c = require("rendi.core.palette")
    vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = c.fg_gutter, nocombine = true })
  end,
}
