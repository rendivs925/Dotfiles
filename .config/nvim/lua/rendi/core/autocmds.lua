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

-- Large file protection: disable LSP, treesitter, syntax, and plugins
vim.api.nvim_create_autocmd("BufReadPre", {
  callback = function()
    local path = vim.fn.expand("<afile>")
    local size = vim.fn.getfsize(path)
    if size > 1048576 then -- 1MB
      vim.b.large_file = true
      vim.cmd("syntax off")
      vim.bo.filetype = ""
      vim.bo.buftype = "nofile"
      vim.opt_local.foldmethod = "manual"
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    if vim.b[ev.buf].large_file then
      vim.lsp.stop_client(vim.lsp.get_client_by_id(ev.data.client_id))
    end
  end,
})
