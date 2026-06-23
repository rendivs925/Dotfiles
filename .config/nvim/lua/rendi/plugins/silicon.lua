return {
  "michaelrommel/nvim-silicon",
  cmd = "Silicon",
  main = "nvim-silicon",
  keys = {
    { "<leader>sc", function() require("nvim-silicon").clip() end, desc = "Copy code screenshot to clipboard", mode = "v" },
    { "<leader>sf", function() require("nvim-silicon").file() end, desc = "Save code screenshot as file", mode = "v" },
    { "<leader>ss", function() require("nvim-silicon").shoot() end, desc = "Create code screenshot", mode = "v" },
  },
  config = function()
    local c = require("rendi.core.palette")
    require("nvim-silicon").setup({
      line_offset = function(args)
        return args.line1
      end,
      font = "Hack Nerd Font",
      theme = vim.fn.expand("~/.config/bat/themes/tokyonight_night.tmTheme"),
      background = c.bg,
      shadow_blur_radius = 4,
      shadow_offset_x = 2,
      shadow_offset_y = 2,
    })
  end,
}
