return {
  "ggandor/leap.nvim",
  config = function()
    local leap = require("leap")
    leap.set_default_keymaps()
  end,
}
