return {
  "crnvl96/lazydocker.nvim",
  event = "VeryLazy",
  opts = {},
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("lazydocker").setup({
      window = {
        settings = {
          width = 1,
          height = 1,
          border = "rounded",
          relative = "editor",
        },
      },
    })
  end,
}
