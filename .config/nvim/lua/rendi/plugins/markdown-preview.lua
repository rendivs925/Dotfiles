return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.cmd([[
      function! OpenMarkdownPreview(url)
        call jobstart(["firefox", a:url], {"detach": v:true})
      endfunction
      let g:mkdp_browserfunc = "OpenMarkdownPreview"
    ]])
  end,
  ft = { "markdown" },
}
