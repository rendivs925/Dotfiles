-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Disable concealing in specific file formats
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*/.config/i3/config", "*/i3/config" },
  callback = function()
    vim.bo.filetype = "i3config"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "i3config",
  callback = function()
    vim.bo.commentstring = "# %s"
  end,
})
