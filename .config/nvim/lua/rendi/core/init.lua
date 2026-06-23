require("rendi.core.options")
require("rendi.core.keymaps")
require("rendi.core.autocmds")
require("rendi.lsp")

-- Prevent netrw from loading (nvim-tree replaces it)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Defer non-critical startup work
vim.schedule(function()
  vim.cmd([[
    iab ^1 ¹  | iab ^2 ²  | iab ^3 ³
    iab ^4 ⁴  | iab ^5 ⁵  | iab ^6 ⁶
    iab ^7 ⁷  | iab ^8 ⁸  | iab ^9 ⁹
    iab ^0 ⁰
  ]])
end)
