return {
  url = "https://codeberg.org/andyg/leap.nvim",
  event = "VeryLazy",
  config = function()
    local leap = require("leap")
    vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
    vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
    -- leap.add_default_mappings()
  end,
}
