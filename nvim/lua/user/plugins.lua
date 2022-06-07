local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer, close and reopen Neovim"
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]


-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  print("Failed to require `packer`.")
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  -- use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  -- use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons"
  use "akinsho/bufferline.nvim"
  use 'folke/tokyonight.nvim'
  -- use "moll/vim-bbye"
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- use "akinsho/toggleterm.nvim"
  -- use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  -- use "lukas-reineke/indent-blankline.nvim"
  -- use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  -- use "lunarvim/darkplus.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  -- use "hrsh7th/cmp-buffer" -- buffer completions
  -- use "hrsh7th/cmp-path" -- path completions
  -- use "hrsh7th/cmp-cmdline" -- cmdline completions
  -- use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  -- use "L3MON4D3/LuaSnip" --snippet engine
  -- use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- use 'tpope/vim-endwise'
  -- use 'prettier/vim-prettier'
  -- use 'thoughtbot/vim-rspec'
  -- use 'ngmy/vim-rubocop'
  -- use 'janko/vim-test'
  -- use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
  use 'gbprod/cutlass.nvim'
  use 'jghauser/mkdir.nvim'
  use 'mboughaba/vim-lessmess'
  -- use 'tpope/vim-dispatch'
  -- use 'tpope/vim-repeat'
  -- use 'alvan/vim-closetag'
  -- use 'easymotion/vim-easymotion'
  -- use 'skywind3000/vim-rt-format', { 'do': 'pip3 install autopep8' }
  use 'eugen0329/vim-esearch'
  -- use 'danchoi/ri.vim'
  -- use 'craigemery/vim-autotag'
  -- use 'tpope/vim-unimpaired'
  -- use 'hashivim/vim-terraform'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use { 'junegunn/fzf.vim' }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)