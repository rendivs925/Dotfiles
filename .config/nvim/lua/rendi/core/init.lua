require("rendi.core.options")
require("rendi.core.keymaps")
require("rendi.core.autocmds")

vim.cmd([[
  iab ^1 ¹
  iab ^2 ²
  iab ^3 ³
  iab ^4 ⁴
  iab ^5 ⁵
  iab ^6 ⁶
  iab ^7 ⁷
  iab ^8 ⁸
  iab ^9 ⁹
  iab ^0 ⁰
]])

local orig_notify = vim.notify
vim.notify = function(msg, level, opts)
  if type(msg) == "string" and not msg:match("deprecated") then
    orig_notify(msg, level, opts)
  end
end
