local map = require("utils").map

-- Overwrite the :w to call the function Save_file()
vim.cmd("command! W lua Save_file()")
vim.cmd [[cnoreabbrev w W]]
vim.api.nvim_create_user_command('Json', function()
  vim.bo.filetype = 'json'
  local name = os.date('%Y-%m-%d_%H-%M-%S') .. '-nvim.json'
  vim.api.nvim_buf_set_name(0, name)
  vim.lsp.buf.format({ async = true })
end, {})
vim.cmd [[cnoreabbrev <expr> json getcmdtype() == ':' && getcmdline() == 'json' ? 'Json' : 'json']]
vim.api.nvim_create_user_command('Yq', function()
  if #vim.fn.getbufinfo({ buflisted = 1 }) ~= 1 then
    vim.notify('yq requires exactly one open buffer', vim.log.levels.ERROR)
    return
  end

  vim.cmd('%yank +')
  vim.cmd('quitall!')
end, {})
vim.cmd [[cnoreabbrev <expr> yq getcmdtype() == ':' && getcmdline() == 'yq' ? 'Yq' : 'yq']]

--General
map({ 'n', 'v', 't' }, ';', ':')
map({ 'n', 'v', 't' }, "'", ',')
map({ 'n', 'v', 't' }, '&', '<cmd>noh<cr>')
map({ 'n', 'v' }, 'R', '"', { desc = 'Register Registration' }) --  Register registration
map('n', '<leader>rr', '<cmd>checktime<cr>', { desc = 'Refresh Buffers' })
map({ 'n', 'v' }, ',', '<Esc>,')
map({ 'n', 'v' }, '<C-s>', Save_file, { desc = 'Salve Buffer' })
map({ 'n' }, 'U', 'C-r>')
map('x', "<leader>p", [["_dP]])
map({ 'v', 'n' }, "<leader>d", [["_d]])
map('n', "<leader>q;", "q:", { desc = 'Command Line History' })
map('n', "<leader>q/", "q/", { desc = 'Search Line History' })
map('n', "q;", ":q")
map('n', "q:", ":q")


map("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace under cursor current file'})
map("n", "n", "nzzzv")                                                        -- Improved n
map("n", "N", "Nzzzv")                                                        -- Improved N

-- Insert mode mappings
map('i', 'jk', '<Esc>')
map('i', 'JK', '<Esc>')
map("i", "<C-a>", "<Esc>A")
-- map("i", "<C-i>", "<Esc>I") -- won't work because c-i sends tab sign to terminal

-- Operand
map("o", "p", "i(")
map("o", "(", "i(")
map("o", "{", "i{")
map("o", "[", "i[")
map("o", "'", "i'")
map("o", '"', 'i"')

-- Moving
map({ 'n', 'v' }, 'J', '<C-f>zz')
map({ 'n', 'v' }, 'K', '<C-b>')
map({ 'n', 'v' }, 'H', '{')
map({ 'n', 'v' }, 'L', '}')

-- Buffer moving
-- map('n', '<Tab><Tab>', '<esc><C-w><C-w>', { desc = 'Next [Buffer]' })
map('n', '<Tab>l', '<Esc><cmd>bn<cr>', { desc = 'Right [Buffer]' })
map('n', '<Tab>h', '<Esc><cmd>bp<cr>', { desc = 'Left [Buffer]' })
map('n', '<Tab>d', '<Esc><cmd>bnext<bar>bd#<cr>', { desc = 'Delete [Buffer]' })
map('n', '<Tab>v', '<Esc><cmd>vert<space>sbNext<cr>', { desc = 'Split Vertical with next [Buffer]' })

-- identing
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Just for documentation
-- map('n', 'gd', function() return require('telescope.builtin').lsp_definitions(require('telescope.themes').get_cursor()) end)

-- Terminal
map({ 'n', 't', 'v' }, '<leader>t', '<cmd>ToggleTerm size=40<cr>')
map('t', ':q', '<cmd>ToggleTerm size=40<cr>')

-- Git
map({ 'n', 'v' }, '<localleader>gd', '<cmd>Gitsigns diffthis origin/main<cr>', { desc = '[G]it [D]iff Main' })

map({ 'n', 'v' }, '<F3>', '<cmd>!code . && code %<cr>', { desc = 'Open repo and file in VSCode' })
map({ 'n', 'v' }, '<F4>', '<cmd>!code %<cr>', { desc = 'Open file in VSCode' })


map({ 'n', 'v' }, '<leader>z', '<cmd>ZenMode<cr>', { desc = '[Z]en [M]ode' })

map({ 'v' }, '<M-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
map({ 'v' }, '<M-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })

-- Deactivate TS-Context-Highlight
map({ 'n', 'v' }, '<leader>ch', '<cmd>TSContextToggle<cr>', { desc = 'Disable TS-Context-Highlight' })


-- Copilot keymaps, here for lack of better place
-- vim.cmd([[imap <silent><script><expr> <S-Tab> copilot#Accept("\<CR>")]])
-- vim.cmd([[let g:copilot_no_tab_map = v:true]])
