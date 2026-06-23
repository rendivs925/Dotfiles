return {
  url = "https://codeberg.org/andyg/leap.nvim",
  event = "VeryLazy",
  config = function()
    local leap = require("leap")
    vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap)")
    vim.keymap.set("n", "gS", "<Plug>(leap-from-window)")
    -- leap.add_default_mappings()
  end,
}
