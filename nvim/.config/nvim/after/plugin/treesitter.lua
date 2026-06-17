local parsers = {
  "vimdoc",
  "diff",
  "python",
  "lua",
  "dot",
  "json",
  "bash",
  "dockerfile",
  "yaml",
  "hcl",
  "javascript",
  "typescript",
  "tsx",
  "go",
  "rust",
}

local filetypes = {
  "help",
  "vimdoc",
  "diff",
  "python",
  "lua",
  "dot",
  "json",
  "jsonc",
  "sh",
  "bash",
  "dockerfile",
  "yaml",
  "hcl",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "rust",
}

local ok, treesitter = pcall(require, "nvim-treesitter")
local has_parser_manager = ok and type(treesitter.setup) == "function" and type(treesitter.install) == "function"

if has_parser_manager then
  treesitter.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
  })
  treesitter.install(parsers)
end

local builtin_filetypes = {
  c = true,
  help = true,
  lua = true,
  markdown = true,
  query = true,
  vim = true,
  vimdoc = true,
}

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("FM: treesitter", { clear = true }),
  pattern = filetypes,
  callback = function()
    if not has_parser_manager and not builtin_filetypes[vim.bo.filetype] then
      return
    end

    local started = pcall(vim.treesitter.start)
    if not started then
      return
    end

    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end,
})
