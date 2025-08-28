--vim.opt.leader key
vim.g.mapleader                        = " "
vim.opt.undodir                        = vim.fn.expand('~/.vim/undo')

--Hardcode which python so starting vim is faster
vim.g.python_host_prog                 = '/usr/local/bin/python'
vim.g.python3_host_prog                = '/usr/local/bin/python3'

vim.g['plantuml_previewer#debug_mode'] = 1

local function find_ruby_project_root()
  local current_dir = vim.fn.expand('%:p:h')
  local ruby_project_root = current_dir

  while current_dir ~= "/" do
    if vim.fn.glob(current_dir .. "/Gemfile") ~= "" or vim.fn.glob(current_dir .. "/.ruby-version") ~= "" then
      ruby_project_root = current_dir
      break
    end
    current_dir = vim.fn.fnamemodify(current_dir, ":h")
  end

  return ruby_project_root
end

local function get_test_command()
  if vim.fn.expand('%:p'):match('spec') then
    return 'LOG_LEVEL=info bundle exec rspec'
  else
    return 'LOG_LEVEL=info bundle exec m'
  end
end

local function get_relative_path_from_root(root)
  local file_path = vim.fn.expand('%:p')
  local relative_path = file_path:sub(#root + 2)
  return relative_path
end

vim.g['test#custom_strategies'] = {
  custom_nearest = function()
    if vim.bo.filetype ~= 'ruby' then
      vim.g['test#strategy'] = 'neovim'
      vim.cmd('TestFile')
    else
      local root = find_ruby_project_root()
      local test_command = get_test_command()
      local relative_path = get_relative_path_from_root(root)
      local cmd = 'cd ' .. root .. ' && ' .. test_command .. ' ' .. relative_path .. ':' .. vim.fn.line('.')
      vim.cmd('split | terminal ' .. cmd)
    end
  end,
  custom_file = function()
    if vim.bo.filetype ~= 'ruby' then
      vim.g['test#strategy'] = 'neovim'
      vim.cmd('TestFile')
    else
      local root = find_ruby_project_root()
      local test_command = get_test_command()
      local cmd = 'cd ' .. root .. ' && ' .. test_command .. ' ' .. vim.fn.expand('%')
      vim.cmd('split | terminal ' .. cmd)
    end
  end,
  custom_suite = function()
    if vim.bo.filetype ~= 'ruby' then
      vim.g['test#strategy'] = 'neovim'
      vim.cmd('TestFile')
    else
      local root = find_ruby_project_root()
      local test_command = get_test_command()
      local cmd = 'cd ' .. root .. ' && ' .. test_command
      vim.cmd('split | terminal ' .. cmd)
    end
  end,
}

vim.g['test#strategy']          = {
  nearest = 'custom_nearest',
  file = 'custom_file',
  suite = 'custom_suite'
}

vim.g.copilot_assume_mapped     = true
vim.g.node_host_prog            = '/Users/antoinesaliba/.asdf/installs/nodejs/18.17.1/lib/node_modules'
vim.g.copilot_node_command      = '/Users/antoinesaliba/.asdf/shims/node'
vim.opt.hidden                  = true    --Required to keep multiple buffers open multiple buffers
vim.opt.wrap                    = false   --Display long lines as just one line
vim.opt.pumheight               = 10      --Makes popup menu smaller
vim.opt.fileencoding            = 'utf-8' --The encoding written to file
vim.opt.splitbelow              = true    --Horizontal splits will automatically be below
vim.opt.splitright              = true    --Vertical splits will automatically be to the right
vim.opt.conceallevel            = 0       --So that I can see `` in markdown files
vim.opt.tabstop                 = 2       --Insert 2 spaces for a tab
vim.opt.shiftwidth              = 2       --Change the number of space characters inserted for indentation
vim.opt.expandtab               = true    --Converts tabs to spaces
vim.opt.smartindent             = true    --Makes indenting smart
vim.opt.number                  = true    --Line numbers
vim.opt.relativenumber          = true    --Relative line numbers
vim.opt.background              = 'light'  --Tell vim what the background color looks like
vim.opt.backup                  = false   --This is recommended by coc
vim.opt.writebackup             = false   --This is recommended by coc
vim.opt.updatetime              = 300     --Faster completion
vim.opt.timeoutlen              = 500     --By default timeoutlen is 1000 ms
vim.opt.showmode                = false   --We don't need to see things like -- INSERT -- anymore
vim.cmd('set formatoptions-=cro')
vim.opt.clipboard = 'unnamedplus'         --Copy paste between vim and everything else
vim.opt.undofile = true                   --Enable undo even after file closed
vim.opt.backspace =
'indent,eol,start'                        --Allow backspace over indentations, over end-of-line (eol) characters, and past when you entered Insert mode
vim.opt.swapfile = false                  --Disable the creation of .swp files
-- vim.opt.tags='./.git/tags'                 --Directory where ctags info will be saved
vim.opt.wildignore = '*.class'
vim.opt.redrawtime = 10000
vim.opt.mouse = 'a'
vim.cmd('set iskeyword+=-')
vim.opt.showtabline = 2 -- always show tab bar

-- Use this if you want it to automatically show all diagnostics on the
-- current line in a floating window. Personally, I find this a bit
-- distracting and prefer to manually trigger it (see below). The
-- CursorHold event happens when after `updatetime` milliseconds. The
-- default is 4000 which is much too long
-- vim.cmd('autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()')
-- vim.o.updatetime = 300

-- Show all diagnostics on current line in floating window
vim.api.nvim_set_keymap(
  'n', '<Leader>d', ':lua vim.diagnostic.open_float()<CR>',
  { noremap = true, silent = true }
)
-- Go to next diagnostic (if there are multiple on the same line, only shows
-- one at a time in the floating window)
vim.api.nvim_set_keymap(
  'n', '<Leader>n', ':lua vim.diagnostic.goto_next()<CR>',
  { noremap = true, silent = true }
)
-- Go to prev diagnostic (if there are multiple on the same line, only shows
-- one at a time in the floating window)
vim.api.nvim_set_keymap(
  'n', '<Leader>p', ':lua vim.diagnostic.goto_prev()<CR>',
  { noremap = true, silent = true }
)

-- ESearch Plugin Settings
vim.cmd [[
  let g:esearch = {}

  " Use regex matching with the smart case mode by default and avoid matching text-objects.
  let g:esearch.regex   = 1
  let g:esearch.textobj = 0
  let g:esearch.case    = 'sensitive'

  " Set the initial pattern content using the highlighted '/' pattern (if
  " v:hlsearch is true), the last searched pattern or the clipboard content.
  let g:esearch.prefill = []

  " Override the default files and directories to determine your project root. Set it
  " to blank to always use the current working directory.
  let g:esearch.root_markers = []

  " Prevent esearch from adding any default keymaps.
  let g:esearch.default_mappings = 1

  " Start the search only when the enter is hit instead of updating the pattern while you're typing.
  let g:esearch.live_update = 1

  " How many lines to display before and after the search result found
  let g:esearch.context = 2

  " Open the search window in a vertical split and reuse it for all further searches.
  let g:esearch.name = 'search'
]]

-- Custom Tab Line --
vim.cmd('hi! TabLineFill guibg=#24283b') -- make tab line background color the same as my theme instead of black (should update if theme is changed)
vim.cmd [[
set tabline=%!MyTabLine()
function! MyTabLine()
  let s = ''
  " loop through each tab page
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#' " WildMenu
    else
      let s .= '%#Title#'
    endif
    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T '
    " set page number string
    let s .= i + 1 . ''
    " get buffer names and statuses
    let n = ''  " temp str for buf names
    let m = 0   " &modified counter
    let buflist = tabpagebuflist(i + 1)
    " loop through each buffer in a tab
    for b in buflist
      if getbufvar(b, "&buftype") == 'help'
        " let n .= '[H]' . fnamemodify(bufname(b), ':t:s/.txt$//')
      elseif getbufvar(b, "&buftype") == 'quickfix'
        " let n .= '[Q]'
      elseif getbufvar(b, "&modifiable")
        let n .= fnamemodify(bufname(b), ':t') . ', ' " pathshorten(bufname(b))
      endif
      if getbufvar(b, "&modified")
        let m += 1
      endif
    endfor
    " let n .= fnamemodify(bufname(buflist[tabpagewinnr(i + 1) - 1]), ':t')
    let n = substitute(n, ', $', '', '')
    " add modified label
    if m > 0
      let s .= '+'
      " let s .= '[' . m . '+]'
    endif
    if i + 1 == tabpagenr()
      let s .= ' %#TabLineSel#'
    else
      let s .= ' %#TabLine#'
    endif
    " add buffer names
    if n == ''
      let s.= '[New]'
    else
      let s .= n
    endif
    " switch to no underlining and add final space
    let s .= ' '
  endfor
  let s .= '%#TabLineFill#%T'
  return s
endfunction
]]

vim.opt.termguicolors = true
