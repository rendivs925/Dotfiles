local c = {
  bg = "#011628",
  bg_dark = "#011423",
  bg_highlight = "#143652",
  fg = "#CBE0F0",
  fg_dark = "#B4D0E9",
  fg_gutter = "#627E97",
  border = "#547998",
}

local theme = {
  normal = {
    a = { fg = c.bg_dark, bg = c.fg, gui = "bold" },
    b = { fg = c.fg_dark, bg = c.bg_highlight },
    c = { fg = c.fg, bg = "none" },
  },
  insert = {
    a = { fg = c.bg_dark, bg = c.fg, gui = "bold" },
    b = { fg = c.fg_dark, bg = c.bg_highlight },
    c = { fg = c.fg, bg = "none" },
  },
  visual = {
    a = { fg = c.bg_dark, bg = c.fg, gui = "bold" },
    b = { fg = c.fg_dark, bg = c.bg_highlight },
    c = { fg = c.fg, bg = "none" },
  },
  replace = {
    a = { fg = c.bg_dark, bg = c.fg, gui = "bold" },
    b = { fg = c.fg_dark, bg = c.bg_highlight },
    c = { fg = c.fg, bg = "none" },
  },
  command = {
    a = { fg = c.bg_dark, bg = c.fg, gui = "bold" },
    b = { fg = c.fg_dark, bg = c.bg_highlight },
    c = { fg = c.fg, bg = "none" },
  },
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
      lualine_c = { "filename" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { { "location", separator = { right = "" }, padding = { left = 1, right = 1 } } },
    },
    inactive_sections = {
      lualine_c = { "filename" },
      lualine_x = { "location" },
    },
  },
}
