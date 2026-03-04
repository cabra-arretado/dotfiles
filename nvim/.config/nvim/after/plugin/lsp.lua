------------- LSP Keymaps via LspAttach ----------------

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local bufnr = ev.buf
    local map = require("utils").map
    local lsp_map = function(modes, lhs, rhs, desc)
      local options = { buffer = bufnr }
      if desc then
        options.desc = 'LSP: ' .. desc
      end
      map(modes, lhs, rhs, options)
    end

    local telescope = require('telescope.builtin')
    lsp_map({ 'n', 'v' }, 'gd', vim.lsp.buf.definition, '[G]o to [d]efinition')
    lsp_map({ 'n', 'v' }, '<space><space>', vim.lsp.buf.hover, 'Hover over')
    lsp_map({ 'n', 'v' }, 'gi', vim.lsp.buf.implementation, '[G]o to [I]mplementation')
    lsp_map({ 'n', 'v' }, '<space>k', vim.lsp.buf.signature_help, '[S]ignature [H]elp')
    lsp_map({ 'i' }, '<C-h>', vim.lsp.buf.signature_help, '[S]ignature [H]elp')
    lsp_map({ 'n', 'v' }, '<space>wa', vim.lsp.buf.add_workspace_folder, 'Add Worspace Folder')
    lsp_map({ 'n', 'v' }, '<space>wr', vim.lsp.buf.remove_workspace_folder, 'Remove Worspace Folder')
    lsp_map({ 'n', 'v' }, '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, 'Print Workspace Folder List')
    lsp_map({ 'n', 'v' }, 'gtd', vim.lsp.buf.type_definition, 'Type Definition')
    lsp_map({ 'n', 'v' }, '<space>d', vim.diagnostic.open_float, 'Open Line Diagnostic')
    lsp_map({ 'n', 'v' }, '<space>rs', vim.lsp.buf.rename, '[R]ename Symbol')
    lsp_map({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action)
    lsp_map({ 'n', 'v' }, '<space>f', function()
      vim.lsp.buf.format({ async = true })
    end, '[F]ormat doc')
    lsp_map({ 'n', 'v' }, '<F6>', vim.diagnostic.hide, 'Hide LSP suggestions')
    lsp_map({ 'n', 'v' }, '<space>e', vim.diagnostic.open_float, 'Show Diagnostic')
    lsp_map({ 'n', 'v' }, '[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
    lsp_map({ 'n', 'v' }, ']d', vim.diagnostic.goto_next, 'Next Diagnostic')
    lsp_map({ 'n', 'v' }, '<space>q', vim.diagnostic.setloclist, 'Diagnostic List')
    lsp_map({ 'n', 'v' }, 'gr', telescope.lsp_references, 'Go to [R]eferences')
    lsp_map({ 'n', 'v' }, '<space>qf', telescope.quickfix, '[Q]uickfix')
    lsp_map({ 'n', 'v' }, '<space>ws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    lsp_map({ 'n', 'v' }, '<space>ds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
  end,
})

------------- Diagnostics ----------------

vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

------------- Mason Setup ----------------

local servers = {
  'pyright',
  'ts_ls',
  'gopls',
  'rust_analyzer',
  'eslint',
  'jsonls',
}

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

------------- LSP Server Config (Neovim 0.11+ native API) ----------------

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Global defaults for all servers
vim.lsp.config('*', {
  capabilities = capabilities,
})

-- lua_ls specific config
if vim.fn.executable('lua-language-server') == 1 then
  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })
  table.insert(servers, 'lua_ls')
end

-- Enable all configured servers
vim.lsp.enable(servers)
