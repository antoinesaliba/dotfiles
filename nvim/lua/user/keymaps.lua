local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", ":W", ":w", opts)
keymap("n", '<Bslash><Bslash>c', ":noh<return>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
-- keymap("t", "<Esc>", "<C-\\><C-n>", term_opts)

-- FZF --
keymap("n", ";", ":FZF<CR>", opts)

-- Rspec --
keymap("n", "<Bslash>f", ":TestFile<CR>", opts)
keymap("n", "<Bslash>s", ":TestNearest<CR>", opts)
keymap("n", "<Bslash>l", ":TestLast<CR>", opts)

-- Hop --
keymap('n', 'f', "<cmd>lua require'hop'.hint_words({ current_line_only = false, inclusive_jump = false })<cr>", {})
keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ current_line_only = false, inclusive_jump = false })<cr>", {})

-- Fugitive --
keymap('n', "<space>ga", ":Git add %:p<CR><CR>", opts)
keymap('n', "<space>gs", ":Git<CR>", opts)
keymap('n', "<space>gc", ":Git commit -v -q %<CR>", opts)
keymap('n', "<space>gt", ":Git commit -v -q %:p<CR>", opts)
keymap('n', "<space>gd", ":Gdiff<CR>", opts)
keymap('n', "<space>ge", ":Gedit<CR>", opts)
keymap('n', "<space>gr", ":Gread<CR>", opts)
keymap('n', "<space>gw", ":Gwrite<CR><CR>", opts)
keymap('n', "<space>gm", ":Gmove<Space>", opts)
keymap('n', "<space>go", ":Git checkout<Space>", opts)
keymap('n', "<space>gp", ":Git! push<CR>", opts)
keymap('n', "<space>gl", ":Git! pull<CR>", opts)

-- ToggleTerm --
keymap("n", "<c-q>", "<cmd>lua _Toggleterm_rails() <CR>", opts)
