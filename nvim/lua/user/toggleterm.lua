local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup({
  size = 20,
  open_mapping = [[<c-w>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Custom Terminals
local ttt = require('toggleterm.terminal')
local Terminal = require("toggleterm.terminal").Terminal

local node = Terminal:new({ cmd = "node", hidden = true })

function _NODE_TOGGLE()
  node:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })

function _PYTHON_TOGGLE()
  python:toggle()
end

local nameTerm = function(term, name)
  vim.api.nvim_buf_set_name(term.bufnr, name)
  ttt.get(term.id).name = name
end

local initTerm = function(term, name)
  term:spawn()
  nameTerm(term, name)
end

local mainTerminal = Terminal:new {
  count = 1,
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
}
initTerm(mainTerminal, "Main")
function _Toggleterm_main()
  mainTerminal:open()
end

local railsTerminal = Terminal:new {
  count = 2,
  cmd = "bundle exec rails console",
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<c-q>", "<cmd>close<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
}
initTerm(railsTerminal, "Rails")
function _Toggleterm_rails()
  railsTerminal:open()
end
