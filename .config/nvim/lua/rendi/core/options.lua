local opt = vim.opt

opt.updatetime = 300
opt.undofile = true

opt.wildignore:append({
  "**/node_modules/**",
  "**/.*",
})

opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

opt.relativenumber = true
opt.number = true
opt.guicursor = ""
opt.mouse = "a"

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.tabstop = 2
opt.shiftwidth = 0
opt.expandtab = true
opt.smarttab = false
opt.cmdheight = 0
opt.breakindent = true
opt.linebreak = true
opt.laststatus = 3

opt.pumheight = 15
opt.pumwidth = 20

opt.wrap = false

-- Limit syntax highlighting to first 2000 lines in large files
opt.synmaxcol = 200

opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false
opt.backup = false
opt.writebackup = false
