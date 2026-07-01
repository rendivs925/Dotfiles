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

-- performance
opt.showmode = false
opt.shortmess:append({ c = true, I = true })
opt.hidden = true
opt.confirm = true
opt.autoread = true
opt.inccommand = "nosplit"
opt.list = true
opt.listchars = { tab = "» ", trail = "·", extends = "›", precedes = "‹" }
opt.fillchars = { eob = " ", diff = "╱", foldopen = "▾", foldclose = "▸" }
opt.whichwrap:append("<,>,[,],h,l")
opt.virtualedit = "block"
opt.splitkeep = "screen"
opt.jumpoptions = "stack"
opt.undolevels = 10000
opt.completeopt = { "menu", "menuone", "noselect" }
opt.redrawtime = 1500
opt.ttimeoutlen = 50
opt.diffopt:append("algorithm:histogram,indent-heuristic")

-- disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false
opt.backup = false
opt.writebackup = false
