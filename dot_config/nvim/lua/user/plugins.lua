local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[ packadd packer.nvim ]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

-- Install plugins here
return packer.startup(function(use)
  -- Have packer manage itself
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/popup.nvim'   -- an implementation of the Popup API from Vim in Neovim
  use 'nvim-lua/plenary.nvim' -- useful Lua functions used by lots of plugins
  use 'windwp/nvim-autopairs' -- autopairs, integrates with both Cmp and Treesitter
  use 'numToStr/Comment.nvim' -- easily comment stuff
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'nanozuki/tabby.nvim'
  use 'moll/vim-bbye'
  use 'freddiehaddad/feline.nvim'
  use 'akinsho/toggleterm.nvim'
  use 'ahmedkhalf/project.nvim'
  use 'lewis6991/impatient.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'goolord/alpha-nvim'
  use 'antoinemadec/FixCursorHold.nvim' -- fix lsp doc highlight
  use 'folke/which-key.nvim'
  use 'wakatime/vim-wakatime'

  -- Colorschemes
  use 'shaunsingh/nord.nvim'
  use 'folke/tokyonight.nvim'
  use 'EdenEast/nightfox.nvim'
  use { 'catppuccin/nvim', as = 'catppuccin' }

  -- Completion
  use 'hrsh7th/nvim-cmp'         -- completion plugin
  use 'hrsh7th/cmp-buffer'       -- buffer completions
  use 'hrsh7th/cmp-path'         -- path completions
  use 'hrsh7th/cmp-cmdline'      -- cmdline completions
  use 'hrsh7th/cmp-nvim-lsp'     -- lsp completions
  use 'hrsh7th/cmp-nvim-lua'     -- neovim lua api
  use 'saadparwaiz1/cmp_luasnip' -- snippet completions

  -- Snippets
  use 'L3MON4D3/LuaSnip'             -- snippet engine
  use 'rafamadriz/friendly-snippets' -- a bunch of snippets to use

  -- LSP
  use 'neovim/nvim-lspconfig'           -- enable lsp
  use 'williamboman/mason.nvim'         -- simple to use language server installer
  use 'williamboman/mason-lspconfig.nvim'
  use 'tamago324/nlsp-settings.nvim'    -- configue lsp using json/yaml
  use 'jose-elias-alvarez/null-ls.nvim' -- formatters and linters

  -- Telescope
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-media-files.nvim'

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'nvim-treesitter/playground'

  -- Git
  use 'lewis6991/gitsigns.nvim'

  -- LISP
  use 'Olical/conjure'

  -- Automatically set up the configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
