local cmd = vim.cmd --- to execute string as vim command
local g = vim.g -- to access global variables
local opt = vim.opt -- to set options
local api = vim.api -- access the VIM Lua API

-- Leader to be declared before plugins
g.mapleader = ','
g.maplocalleader = '\\'

require('globals')
require('plugins')

-- Changes the cursor in insert mode
-- opt.guicursor = ''

opt.swapfile = false
opt.backup = false
opt.number = true
-- opt.relativenumber = true
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.shortmess:append({ W = true, I = true, c = true })
opt.cursorline = true
opt.splitright = true
opt.completeopt = "menu,menuone,noselect"
opt.termguicolors = true
opt.cursorline = true
opt.ignorecase = true
opt.visualbell = true
opt.smartcase = true
opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
opt.clipboard = 'unnamedplus'
opt.mouse = 'a'
opt.laststatus = 3
opt.expandtab = true
opt.shiftwidth = 2
opt.list = true
opt.listchars:append "eol:↴" -- other options( ↩ , ↴ , ↵ )
opt.listchars:append "trail:·"
opt.breakindent = true
opt.linebreak = true
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
g.mapleader = ','
g.maplocalleader = '\\'
g.markdown_remmended_style = 0

-- Theme
-- local theme = [[catppuccin-macchiato]]
local theme = [[tokyonight-night]]
-- local theme = [[github_dark_dimmed]]
cmd.colorscheme(theme)


-- tmux nav
cmd([[let g:tmux_navigator_disable_when_zoomed = 1]])

--  Require Keymaps after the opts
require('keymaps')
require('autocmds')
