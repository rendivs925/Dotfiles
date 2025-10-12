return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }

    -- Chrome-specific settings
    vim.g.mkdp_browser = "chrome"
    vim.g.mkdp_browserfunc = "open"

    -- Optional: Customize Chrome launch if needed
    vim.g.mkdp_browser_path = "/usr/bin/google-chrome-stable" -- Linux
    -- vim.g.mkdp_browser_path = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'  -- macOS
    -- vim.g.mkdp_browser_path = 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe'  -- Windows

    -- Other useful settings
    vim.g.mkdp_theme = "dark" -- or 'light'
    vim.g.mkdp_port = ""
    vim.g.mkdp_page_title = "${name}"
  end,
  ft = { "markdown" },
}
