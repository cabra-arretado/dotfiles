local ok, ls = pcall(require, "luasnip")

if not ok then
  return
end

-- Mine
-- vim.keymap.set({ "i", "s" }, "<C-l>", function()
--   if ls.expand_or_jumpable() then
--     ls.expand_or_jump()
--   end
-- end, { silent = true })

---------------------------------------
-- Testing TJ for a litte
---------------------------------------
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })
--
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ "i" }, "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

vim.keymap.set('n', '<leader><leader>s', '<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<cr>')
-- End TJ ----
---------------------------------------
---------------------------------------
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key
local types = require("luasnip.util.types")

require("luasnip.loaders.from_vscode").lazy_load()

--- Print snippet
ls.add_snippets("lua", {
    s("print", {
      t("print("),
      i(1),
      t(")"),
    })
})
ls.add_snippets("typescript", {
    s("print", {
      t("console.log("),
      i(1),
      t(")"),
    })
})
ls.add_snippets("python", {
    s("print", {
      t("print("),
      i(1),
      t(")"),
    })
})
ls.add_snippets("typescriptreact", {
    s("print", {
      t("console.log("),
      i(1),
      t(")"),
    })
})
ls.add_snippets("go", {
    s("print", {
      t("fmt.Printf("),
      i(1),
      t(")"),
    })
})


ls.config.set_config {
  history = false,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " « ", "NonTest" } },
      },
    },
  },
}
