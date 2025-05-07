return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  config = function()
    require("zen-mode").toggle({
      window = {
        width = 1,
      },
    })
  end,
}
