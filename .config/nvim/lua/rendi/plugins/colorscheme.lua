return {
  "folke/tokyonight.nvim",
  priority = 1000,
  opts = {
    style = "night",
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_colors = function(colors)
      colors.bg_highlight = "#143652"
      colors.bg_search = "#0A64AC"
      colors.bg_visual = "#275378"
      colors.border = "#547998"
      colors.fg = "#CBE0F0"
      colors.fg_dark = "#B4D0E9"
      colors.fg_float = "#CBE0F0"
      colors.fg_gutter = "#627E97"
      colors.fg_sidebar = "#B4D0E9"
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd("colorscheme tokyonight")
  end,
}
