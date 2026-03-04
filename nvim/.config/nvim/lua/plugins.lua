local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
  { 'mbbill/undotree' },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  {
    'rcarriga/nvim-notify',
    lazy = true,
    -- priority = 1000,
    opts = {
      stages = "static"
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {}
  },
  { 'tpope/vim-fugitive' },
  {
    'numToStr/Comment.nvim',
    lazy = false,
  },
  { 'christoomey/vim-tmux-navigator', },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    }
  },
  {
    'j-hui/fidget.nvim',
    opts = {}
  },
  { 'nvim-treesitter/nvim-treesitter' },
  { 'folke/trouble.nvim' },
  { 'nvim-lua/plenary.nvim' },
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim'
    }
  },
  { 'akinsho/bufferline.nvim' },
  { 'nvim-lualine/lualine.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'hrsh7th/cmp-nvim-lsp' },
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
    }
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      "nvim-telescope/telescope.nvim"
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
  },
  {
    'hrsh7th/nvim-cmp',
    lazy = true,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
  },
  {
    'akinsho/toggleterm.nvim',
    lazy = true
  },
  {
    'folke/todo-comments.nvim',
    lazy = true
  },
  { "stevearc/dressing.nvim" },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      views = {
        cmdline_popup = {
          border = {
            style = "none",
            padding = { 2, 3 },
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          keys = { "f", "F", "t", "T", "," },
        }
      }
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc =
        "Treesitter Search"
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      },
    },
  },
  { "nvim-tree/nvim-tree.lua" },
  {
    'RRethy/vim-illuminate',
    lazy = true
  },
  {
    -- TODO: Finish to test this out
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true,
    },
  },
  {
    "folke/neodev.nvim",
    opts = {}
  },
  {
    "folke/zen-mode.nvim",
    opts = {}
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
  {
    "github/copilot.vim",
    lazy = false,
    priority = 999,
  },
  ---------------------------------------------------
  -- THEMES
  --
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  --
  -- {
  --   "rebelot/kanagawa.nvim",
  -- },
  -- {
  --   'rose-pine/neovim',
  --   name = 'rose-pine'
  -- },
  -- { "catppuccin/nvim" },
  -- { "projekt0n/github-nvim-theme" },
  -- { "sainnhe/sonokai" },
  -- {
  --   'Mofiqul/vscode.nvim'
  -- }
  ---------------------------------------------------
}
)
