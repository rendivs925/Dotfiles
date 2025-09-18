vim.g.mapleader = " "
local keymap = vim.keymap

-- LSP standard
keymap.set("n", "<leader>lx", ":LspStop<CR>", { desc = "Stop LSP" })
keymap.set("n", "<leader>ls", ":LspStart<CR>", { desc = "Start LSP" })
keymap.set("n", "<leader>lr", ":LspRestart<CR>", { desc = "Restart LSP" })

-- LSP garbage-day
keymap.set("n", "<leader>sl", ":lua require('garbage-day.utils').stop_lsp()<CR>", { desc = "Stop LSP (GD)" })
keymap.set("n", "<leader>sr", ":lua require('garbage-day.utils').start_lsp()<CR>", { desc = "Start LSP (GD)" })

-- LSP navigation
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })

-- Go to line:column
keymap.set("n", "<leader>lc", function()
  local input = vim.fn.input("Go to line:column: ")
  local line, col = input:match("^(%d+):(%d+)$")
  if line and col then
    vim.api.nvim_win_set_cursor(0, { tonumber(line), tonumber(col) - 1 })
  else
    vim.notify("Invalid format. Use line:column", vim.log.levels.ERROR)
  end
end, { desc = "Jump to line:column" })

-- Insert mode
keymap.set("i", "<C-c>", "<Esc>", { desc = "Esc insert" })
keymap.set("i", "<C-h>", "<Left>", { desc = "←" })
keymap.set("i", "<C-l>", "<Right>", { desc = "→" })
keymap.set("i", "<C-d>", "<Delete>", { desc = "Del char" })
keymap.set("i", "<C-w>", "<C-o>db<C-o>x", { desc = "Del word ←" })
keymap.set("i", "<C-D>", "<C-o>dw", { desc = "Del word →" })

-- Search
keymap.set("n", "<leader>g", "*", { desc = "Search word ↓" })
keymap.set("n", "<leader>G", "#", { desc = "Search word ↑" })
keymap.set("n", "<leader>zg", "g*", { desc = "Search partial ↓" })
keymap.set("n", "<leader>zG", "g#", { desc = "Search partial ↑" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear highlight" })

-- Comments
keymap.set("n", "<leader>dhhc", [[:%s/<!--.*-->//gc<CR>]], { desc = "Remove HTML comments" })
keymap.set("n", "<leader>dccc", [[:%s/\/\*.*\*\///gc<CR>]], { desc = "Remove CSS comments" })
keymap.set("n", "<leader>ddc", [[:%s/--.*//gc<CR>]], { desc = "Remove -- comments" })
keymap.set("n", "<leader>dac", [[:%s/;.*//gc<CR>]], { desc = "Remove ; comments" })
keymap.set("n", "<leader>drc", [[:%s/\/\/.*//gc<CR>]], { desc = "Remove // comments" })
keymap.set("n", "<leader>dhc", [[:%s/#.*//gc<CR>]], { desc = "Remove # comments" })
keymap.set("n", "<leader>dcl", [[:%s/\n\{3,}/\r\r/gc<CR>]], { desc = "Collapse blank lines" })
keymap.set("n", "<leader>sc", [[:/\v(#|--|\/\/|;|<!--.*-->|\/\*.*\*\/).*<CR>]], { desc = "Search comments" })

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Black hole ops
keymap.set("n", "x", '"_x', { desc = "Del no copy" })
keymap.set("n", "<leader>d", '"_d', { desc = "Del no copy" })
keymap.set("n", "<leader>D", '"_D', { desc = "Del to EOL no copy" })
keymap.set("v", "<leader>d", '"_d', { desc = "Visual del no copy" })
keymap.set("v", "<leader>D", '"_D', { desc = "Visual del to EOL" })
keymap.set("n", "<leader>c", '"_c', { desc = "Change no copy" })
keymap.set("n", "<leader>C", '"_C', { desc = "Change to EOL" })
keymap.set("v", "<leader>c", '"_c', { desc = "Visual change no copy" })
keymap.set("v", "<leader>C", '"_C', { desc = "Visual change to EOL" })

-- Pasting
keymap.set("n", "<leader>p", '""0"p', { desc = "Paste 0" })
keymap.set("n", "<leader>P", '""0"P', { desc = "Paste before 0" })
keymap.set("v", "<leader>p", '""0"p', { desc = "Visual paste 0" })

-- Plugin UIs
keymap.set("n", "<leader>ld", "<Cmd>lua LazyDocker.toggle()<CR>", { desc = "Toggle LazyDocker" })
keymap.set("n", "<leader>lz", ":Lazy<CR>", { desc = "Lazy.nvim" })
keymap.set("n", "<leader>mm", ":Mason<CR>", { desc = "Mason" })

-- Number
keymap.set("n", "+", "<C-a>", { desc = "Increment" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement" })

-- Set marks without conflicting with nvim-tree
keymap.set("n", "<leader>ma", "ma", { desc = "Set mark a" })
keymap.set("n", "<leader>mA", "mA", { desc = "Set mark A" })
keymap.set("n", "<leader>mb", "mb", { desc = "Set mark b" })
keymap.set("n", "<leader>mB", "mB", { desc = "Set mark B" })
keymap.set("n", "<leader>mc", "mc", { desc = "Set mark c" })
keymap.set("n", "<leader>mC", "mC", { desc = "Set mark C" })

-- Marks
keymap.set("n", "<leader>ja", "'a", { desc = "Jump a" })
keymap.set("n", "<leader>jA", "'A", { desc = "Jump A" })
keymap.set("n", "<leader>jb", "'b", { desc = "Jump b" })
keymap.set("n", "<leader>jB", "'B", { desc = "Jump B" })
keymap.set("n", "<leader>jc", "'c", { desc = "Jump c" })
keymap.set("n", "<leader>jC", "'C", { desc = "Jump C" })
keymap.set("n", "<leader>dm", ":delmarks ", { desc = "Del mark" })
keymap.set("n", "<leader>lm", ":marks<CR>", { desc = "List marks" })

-- Zen
keymap.set("n", "<leader>zm", ":ZenMode<CR>", { desc = "Zen Mode" })

-- Wrap
keymap.set("n", "[w", ":set wrap<CR>", { desc = "Wrap" })
keymap.set("n", "]w", ":set nowrap<CR>", { desc = "No wrap" })

-- Splits
keymap.set("n", "<leader>sw", "<C-w>w", { desc = "Switch window" })
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equal split" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

-- Tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "New tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Prev tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Buf in tab" })
