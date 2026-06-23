vim.g.mapleader = " "
local keymap = vim.keymap

-- LSP lifecycle
keymap.set("n", "<leader>lx", ":LspStop<CR>", { desc = "Stop LSP" })
keymap.set("n", "<leader>ls", ":LspStart<CR>", { desc = "Start LSP" })

-- Go to line:column
keymap.set("n", "<leader>lc", function()
  require("rendi.core.extract_locations").extract_to_qflist()
end, { desc = "Extract Rust errors to quickfix" })

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

-- Comment cleanup (q* prefix to avoid delaying <leader>d operator)
keymap.set("n", "<leader>qh", [[:%s/<!--.*-->//gc<CR>]], { desc = "Remove HTML comments" })
keymap.set("n", "<leader>qc", [[:%s/\/\*.*\*\///gc<CR>]], { desc = "Remove CSS comments" })
keymap.set("n", "<leader>q-", [[:%s/--.*//gc<CR>]], { desc = "Remove -- comments" })
keymap.set("n", "<leader>q;", [[:%s/;.*//gc<CR>]], { desc = "Remove ; comments" })
keymap.set("n", "<leader>q/", [[:%s/\/\/.*//gc<CR>]], { desc = "Remove // comments" })
keymap.set("n", "<leader>q#", [[:%s/#.*//gc<CR>]], { desc = "Remove # comments" })
keymap.set("n", "<leader>qb", [[:%s/\n\{3,}/\r\r/gc<CR>]], { desc = "Collapse blank lines" })
keymap.set("n", "<leader>qs", [[:/\v(#|--|\/\/|;|<!--.*-->|\/\*.*\*\/).*<CR>]], { desc = "Search comments" })

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
keymap.set("n", "<leader>ld", "<Cmd>lua require('lazydocker').toggle()<CR>", { desc = "Toggle LazyDocker" })
keymap.set("n", "<leader>lz", ":Lazy<CR>", { desc = "Lazy.nvim" })
keymap.set("n", "<leader>L", ":Lazy<CR>", { desc = "Lazy.nvim" })

-- Startup profiling
keymap.set("n", "<leader>lp", function()
  vim.cmd("Lazy profile")
end, { desc = "Lazy profile" })
keymap.set("n", "<leader>mm", ":Mason<CR>", { desc = "Mason" })

-- Number
keymap.set("n", "+", "<C-a>", { desc = "Increment" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement" })

-- Set marks / jump marks (generated)
for _, m in ipairs({ "a", "A", "b", "B", "c", "C" }) do
  keymap.set("n", "<leader>m" .. m, "m" .. m, { desc = "Set mark " .. m })
  keymap.set("n", "<leader>j" .. m, "'" .. m, { desc = "Jump " .. m })
end
keymap.set("n", "<leader>km", ":delmarks ", { desc = "Del mark" })
keymap.set("n", "<leader>lm", ":marks<CR>", { desc = "List marks" })

-- Zen
keymap.set("n", "<leader>zm", ":ZenMode<CR>", { desc = "Zen Mode" })

-- Wrap
keymap.set("n", "[w", ":set wrap<CR>", { desc = "Wrap" })
keymap.set("n", "]w", ":set nowrap<CR>", { desc = "No wrap" })

-- Window ops (w* prefix to avoid clashing with substitute operator)
keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Switch window" })
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split vertical" })
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split horizontal" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Equal split" })
keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close split" })
-- Tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "New tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Prev tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Buf in tab" })
