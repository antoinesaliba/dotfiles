--vim.opt.leader key
vim.g.mapleader = " "
vim.cmd [[colorscheme tokyonight]]
vim.opt.undodir = '/Users/antoinesaliba/.vim/undo'

--Hardcode which python so starting vim is faster
vim.g.python_host_prog  = '/usr/local/bin/python'
vim.g.python3_host_prog = '/usr/local/bin/python3'

vim.g.rspec_command = "bundle exec rspec {spec}"
vim.g['test#strategy'] = "neovim"

vim.opt.hidden = true --Required to keep multiple buffers open multiple buffers
vim.opt.wrap = false --Display long lines as just one line
vim.opt.pumheight = 10 --Makes popup menu smaller
vim.opt.fileencoding = 'utf-8' --The encoding written to file
vim.opt.splitbelow = true --Horizontal splits will automatically be below
vim.opt.splitright = true --Vertical splits will automatically be to the right
vim.opt.conceallevel = 0 --So that I can see `` in markdown files
vim.opt.tabstop = 2 --Insert 2 spaces for a tab
vim.opt.shiftwidth = 2 --Change the number of space characters inserted for indentation
vim.opt.expandtab = true --Converts tabs to spaces
vim.opt.smartindent = true --Makes indenting smart
vim.opt.laststatus = 0 --Always display the status line
vim.opt.number = true --Line numbers
vim.opt.relativenumber = true --Relative line numbers
vim.opt.background = 'dark' --Tell vim what the background color looks like
vim.opt.backup = false --This is recommended by coc
vim.opt.writebackup = false --This is recommended by coc
vim.opt.updatetime = 300 --Faster completion
vim.opt.timeoutlen = 500 --By default timeoutlen is 1000 ms
vim.opt.showmode = false --We don't need to see things like -- INSERT -- anymore
vim.cmd('set formatoptions-=cro')
vim.opt.clipboard = 'unnamedplus' --Copy paste between vim and everything else
vim.opt.undofile = true --Enable undo even after file closed
vim.opt.backspace = 'indent,eol,start' --Allow backspace over indentations, over end-of-line (eol) characters, and past when you entered Insert mode
vim.opt.swapfile = false --Disable the creation of .swp files
-- vim.opt.tags='./.git/tags'                 --Directory where ctags info will be saved
vim.opt.wildignore = '*.class'
vim.opt.redrawtime = 10000
vim.opt.mouse = 'a'
vim.cmd('set iskeyword+=-')
