return {
  "rmagatti/auto-session",
  keys = {
    { "<leader>wr", "<cmd>SessionRestore<CR>", desc = "Restore session for cwd" },
    { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session for auto session root dir" },
  },
  config = function()
    require("auto-session").setup({
      auto_restore = true,
      suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    })
  end,
}
