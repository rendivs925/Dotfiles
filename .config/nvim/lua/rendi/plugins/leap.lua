return {
  "ggandor/leap.nvim",
  event = "VeryLazy",
  config = function()
    local leap = require("leap")
    leap.add_default_mappings()
  end,
}
