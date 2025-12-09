-- Load startup optimizations first
require "user.startup"

-- Load essential configs immediately
require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.treesitter"  -- Load immediately for syntax highlighting

-- Defer non-essential configs to after startup
vim.defer_fn(function()
require "user.hop"
require "user.lualine"
require "user.telescope"
require "user.cutlass"
  require "user.toggleterm"
  require "user.dap"
  require "user.conform"
  require "user.lint"
end, 0)

-- Defer heavy LSP and completion setup
vim.defer_fn(function()
require "user.lsp"
require "user.cmp"
end, 10)
