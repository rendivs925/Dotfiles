return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  event = "VeryLazy",
  opts = {
    options = {
      mode = "tabs",
      indicator = { style = "none" },
      separator_style = "thin",
    },
  },
}
