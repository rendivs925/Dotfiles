return {
  "aznhe21/actions-preview.nvim",
  event = "LspAttach",
  keys = {
    { "<leader>ca", function() require("actions-preview").code_actions() end, desc = "Code actions (with preview)", mode = { "n", "v" } },
  },
}
