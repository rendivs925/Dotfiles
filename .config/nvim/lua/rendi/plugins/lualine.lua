local c = require("rendi.core.palette")

local function mode_colors(mode)
  local accent = mode == "insert" and c.purple or mode == "visual" and c.purple_alt or c.bg_highlight
  return {
    a = { fg = c.fg, bg = accent, gui = "bold" },
    b = { fg = c.fg_dark, bg = c.bg_highlight },
    c = { fg = c.fg, bg = "none" },
  }
end

local theme = {
  normal   = mode_colors("normal"),
  insert   = mode_colors("insert"),
  visual   = mode_colors("visual"),
  replace  = mode_colors("replace"),
  command  = mode_colors("command"),
  inactive = {
    a = { fg = c.fg_gutter, bg = "none", gui = "bold" },
    b = { fg = c.fg_gutter, bg = "none" },
    c = { fg = c.fg_gutter, bg = "none" },
  },
}

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = theme,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { { "mode", separator = { left = "" }, padding = { left = 1, right = 1 } } },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { { "filename", path = 1, file_status = true } },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = {
        { "location", separator = { right = "" }, padding = { left = 1, right = 1 } },
      },
    },
    inactive_sections = {
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "location" },
    },
  },
}
