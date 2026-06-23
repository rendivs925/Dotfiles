return {
  "aznhe21/actions-preview.nvim",
  event = "LspAttach",
  config = function()
    vim.keymap.set({ "n", "v" }, "<leader>ca", function()
      require("actions-preview").code_actions()
    end, { desc = "Code actions (with preview)" })
  end,
}
