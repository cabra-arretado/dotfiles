local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

treesitter.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
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
  },
  auto_install = true,

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  indent = {
    enable = true
  },
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    additional_vim_regex_highlighting = true,
  },
}
