vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>lx", ":LspStop<CR>", { noremap = true, silent = true, desc = "Stop standard LSP" })
keymap.set("n", "<leader>ls", ":LspStart<CR>", { noremap = true, silent = true, desc = "Start standard LSP" })
keymap.set("n", "<leader>lr", ":LspRestart<CR>", { noremap = true, silent = true, desc = "Restart standard LSP" })

keymap.set(
  "n",
  "<leader>sl",
  ":lua require('garbage-day.utils').stop_lsp()<CR>",
  { noremap = true, silent = true, desc = "Stop LSP (garbage-day)" }
)
keymap.set(
  "n",
  "<leader>sr",
  ":lua require('garbage-day.utils').start_lsp()<CR>",
  { noremap = true, silent = true, desc = "Start LSP (garbage-day)" }
)

keymap.set("i", "<C-c>", "<Esc>", { noremap = true, silent = true, desc = "Switch to normal mode" })

-- LSP keybindings
local opts = { noremap = true, silent = true, desc = "Go to definition" }
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

keymap.set(
  "n",
  "<leader>dhhc",
  [[:%s/<!--.*-->//gc<CR>]],
  { noremap = true, silent = true, desc = "Remove all HTML comments (<!-- -->) with confirmation" }
)

keymap.set(
  "n",
  "<leader>dccc",
  [[:%s/\/\*.*\*\///gc<CR>]],
  { noremap = true, silent = true, desc = "Remove all CSS comments (/* */) with confirmation" }
)

keymap.set(
  "n",
  "<leader>ddc",
  [[:%s/--.*//gc<CR>]],
  { noremap = true, silent = true, desc = "Remove all '--' comments (confirm each)" }
)

keymap.set(
  "n",
  "<leader>dac",
  [[:%s/;.*//gc<CR>]],
  { noremap = true, silent = true, desc = "Remove all ';' assembly comments (confirm each)" }
)

keymap.set(
  "n",
  "<leader>drc",
  [[:%s/\/\/.*//gc<CR>]],
  { noremap = true, silent = true, desc = "Remove all '//' comments (confirm each)" }
)

keymap.set(
  "n",
  "<leader>dhc",
  [[:%s/#.*//gc<CR>]],
  { noremap = true, silent = true, desc = "Remove all '#' comments (confirm each)" }
)

keymap.set(
  "n",
  "<leader>dcl",
  [[:%s/\n\{3,}/\r\r/gc<CR>]],
  { noremap = true, silent = true, desc = "Collapse 3+ blank lines into 2 (confirm each)" }
)

keymap.set(
  "n",
  "<leader>sc",
  [[:/\v(#|--|\/\/|;|<!--.*-->|\/\*.*\*\/).*<CR>]],
  { noremap = true, silent = true, desc = "Search all comments (#, --, //, ;, HTML, CSS)" }
)

-- Cursor movements in insert mode
keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true, desc = "Move cursor left" })
keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true, desc = "Move cursor right" })

-- Delete operations
keymap.set("i", "<C-d>", "<Delete>", { noremap = true, silent = true, desc = "Delete the character before the cursor" })
keymap.set("i", "<C-w>", "<C-o>db<C-o>x", { noremap = true, silent = true, desc = "Delete the word before the cursor" })
keymap.set("i", "<C-D>", "<C-o>dw", { noremap = true, silent = true, desc = "Delete the word after the cursor" })

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- <leader>g: search for exact word under cursor and jump to next match (like `*`)
keymap.set("n", "<leader>g", "*", { desc = "Search exact word and jump to next match" })

-- <leader>G: search for exact word under cursor and jump to previous match (like `#`)
keymap.set("n", "<leader>G", "#", { desc = "Search exact word and jump to previous match" })

-- <leader>zg: search for partial word under cursor and jump to next match (like `g*`)
keymap.set("n", "<leader>zg", "g*", { desc = "Search partial word and jump to next match" })

-- <leader>zG: search for partial word under cursor and jump to previous match (like `g#`)
keymap.set("n", "<leader>zG", "g#", { desc = "Search partial word and jump to previous match" })

-- Select all
keymap.set("n", "<C-s>", "gg<S-v>G", { desc = "Select all" })

-- Keymaps that avoid affecting registers
keymap.set("n", "x", '"_x', { noremap = true, silent = true, desc = "Delete without affecting register" })
keymap.set("n", "<Leader>p", '""0"p', { noremap = true, silent = true, desc = "Paste from register 0" })
keymap.set("n", "<Leader>P", '""0"P', { noremap = true, silent = true, desc = "Paste from register 0 before cursor" })
keymap.set("v", "<Leader>p", '""0"p', { noremap = true, silent = true, desc = "Paste from register 0 in visual mode" })
keymap.set("n", "<Leader>c", '"_c', { noremap = true, silent = true, desc = "Change without affecting register" })
keymap.set(
  "n",
  "<Leader>C",
  '"_C',
  { noremap = true, silent = true, desc = "Change to end of line without affecting register" }
)
keymap.set(
  "v",
  "<Leader>c",
  '"_c',
  { noremap = true, silent = true, desc = "Change in visual mode without affecting register" }
)
keymap.set("v", "<Leader>C", '"_C', { noremap = true, silent = true, desc = "Change in visual mode to end of line" })
keymap.set("n", "<Leader>d", '"_d', { noremap = true, silent = true, desc = "Delete without affecting register" })
keymap.set(
  "n",
  "<Leader>D",
  '"_D',
  { noremap = true, silent = true, desc = "Delete to end of line without affecting register" }
)
keymap.set(
  "v",
  "<Leader>d",
  '"_d',
  { noremap = true, silent = true, desc = "Delete in visual mode without affecting register" }
)
keymap.set("v", "<Leader>D", '"_D', { noremap = true, silent = true, desc = "Delete to end of line in visual mode" })

-- Managing LazyDocker and Lazy.nvim
keymap.set(
  "n",
  "<leader>ld",
  "<Cmd>lua LazyDocker.toggle()<CR>",
  { noremap = true, silent = true, desc = "Toggle LazyDocker" }
)
keymap.set("n", "<leader>ll", ":Lazy<CR>", { desc = "Open Lazy.nvim" })

keymap.set("n", "<leader>mm", ":Mason<CR>", { desc = "Open Mason" })

-- Increment and decrement numbers
keymap.set("n", "+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement number" })

-- Manage marks
keymap.set("n", "<leader>ja", "'a", { noremap = true, silent = true, desc = "Jump to mark 'a'" })
keymap.set("n", "<leader>jA", "'A", { noremap = true, silent = true, desc = "Jump to global mark 'A'" })
keymap.set("n", "<leader>jb", "'b", { noremap = true, silent = true, desc = "Jump to mark 'b'" })
keymap.set("n", "<leader>jB", "'B", { noremap = true, silent = true, desc = "Jump to global mark 'B'" })
keymap.set("n", "<leader>jc", "'c", { noremap = true, silent = true, desc = "Jump to mark 'c'" })
keymap.set("n", "<leader>jC", "'C", { noremap = true, silent = true, desc = "Jump to global mark 'C'" })
keymap.set("n", "<leader>dm", ":delmarks ", { desc = "Delete mark" })
keymap.set("n", "<leader>lm", ":marks<CR>", { noremap = true, silent = true, desc = "List all marks" })

-- Zen Mode toggle
keymap.set("n", "<leader>zm", ":ZenMode<CR>", { desc = "Toggle Zen Mode" })

-- Set wrap/nowrap
keymap.set("n", "[w", ":set wrap<CR>", { desc = "Set wrap" })
keymap.set("n", "]w", ":set nowrap<CR>", { desc = "Set nowrap" })

-- Window management
keymap.set("n", "<leader>sw", "<C-w>w", { desc = "Switch window" })
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize window sizes" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
