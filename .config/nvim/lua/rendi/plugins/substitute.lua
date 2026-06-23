return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local substitute = require("substitute")

    substitute.setup()

    -- set keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>rs", substitute.operator, { desc = "Substitute with motion" })
    keymap.set("n", "<leader>rl", substitute.line, { desc = "Substitute line" })
    keymap.set("n", "<leader>rS", substitute.eol, { desc = "Substitute to end of line" })
    keymap.set("x", "<leader>rs", substitute.visual, { desc = "Substitute in visual mode" })
  end,
}
