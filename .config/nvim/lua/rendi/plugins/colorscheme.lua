return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    local c = require("rendi.core.palette")
    local transparent = true

    require("tokyonight").setup({
      style = "night",
      transparent = transparent,
      styles = {
        sidebars = transparent and "transparent" or "dark",
        floats = transparent and "transparent" or "dark",
      },
      on_colors = function(colors)
        colors.bg = c.bg
        colors.bg_dark = transparent and colors.none or c.bg_dark
        colors.bg_float = transparent and colors.none or c.bg_dark
        colors.bg_highlight = c.bg_highlight
        colors.bg_popup = c.bg_dark
        colors.bg_search = c.bg_search
        colors.bg_sidebar = transparent and colors.none or c.bg_dark
        colors.bg_statusline = transparent and colors.none or c.bg_dark
        colors.bg_visual = c.bg_visual
        colors.border = c.border
        colors.fg = c.fg
        colors.fg_dark = c.fg_dark
        colors.fg_float = c.fg
        colors.fg_gutter = c.fg_gutter
        colors.fg_sidebar = c.fg_dark
      end,
    })

    vim.cmd.colorscheme("tokyonight")
  end,
}
