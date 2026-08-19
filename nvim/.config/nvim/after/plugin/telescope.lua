local ok, telescope = pcall(require, "telescope")

if not ok then
  return
end

local has_treesitter_parser_manager = (function()
  local ts_ok, treesitter = pcall(require, "nvim-treesitter")
  return ts_ok and type(treesitter.install) == "function"
end)()

telescope.setup {
  defaults = {
    preview = {
      treesitter = has_treesitter_parser_manager,
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "-F" -- Maybe to remove that later
    },
    prompt_prefix = " 🔍  ",
    selection_caret = "  ",
    entry_prefix = "  ",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
      },
      vertical = {
        mirror = false,
      },
      preview_cutoff = 120,
    },
    file_ignore_patterns = { "node_modules" },
    path_display = { "truncate" },
    winblend = 0,
    border = true,
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" },
    mappings = {
      n = {
        ["q"] = require("telescope.actions").close,
        ["J"] = "preview_scrolling_down",
        ["K"] = "preview_scrolling_up",
        ["v"] = "select_vertical",
      },
    },
  },
  pickers = {
    oldfiles = {
      only_cwd = true,
      initial_mode = 'normal',
    },
    lsp_definitions = {
      jump_type = 'never',
      initial_mode = 'normal',
    },
    jumplist = {
      initial_mode = 'normal',
    },
    registers = {
      initial_mode = 'normal',
    },
    git_status = {
      initial_mode = 'normal',
    },
    git_commits = {
      initial_mode = 'normal',
    },
    git_bcommits = {
      initial_mode = 'normal',
    },
    git_branches = {
      initial_mode = 'normal',
    },
    lsp_references = {
      initial_mode = 'normal',
    },
    lsp_incoming_calls = {
      initial_mode = 'normal',
    },
    lsp_dynamic_workspace_symbols = {
      initial_mode = 'normal',
    },
    git_stash = {
      initial_mode = 'normal',
    },
    buffers = {
      initial_mode = 'normal',
      mappings = {
        n = {
          ["x"] = require("telescope.actions").delete_buffer,
          ["B"] = require("telescope.actions").move_selection_next,
          ["b"] = require("telescope.actions").select_default,
        },
      },
    },
  },
}

-- Mappings
local map = require("utils").map
local telescope_builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')

local function cheatsheet()
  local entries = {}
  local modes = { 'n', 'i', 'l', 'v', 'x', 's', 'o', 'c', 't' }

  local function add_keymaps(keymaps, scope)
    for _, keymap in ipairs(keymaps) do
      local description = keymap.desc or keymap.rhs
      if not description or description == '' then
        description = '[Lua callback]'
      end

      table.insert(entries, {
        kind = 'keymap',
        lhs = keymap.lhs,
        mode = keymap.mode,
        scope = scope,
        description = description,
      })
    end
  end

  for _, mode in ipairs(modes) do
    add_keymaps(vim.api.nvim_get_keymap(mode), 'global')
    add_keymaps(vim.api.nvim_buf_get_keymap(0, mode), 'buffer')
  end

  for _, command in ipairs(vim.fn.getcompletion('', 'command')) do
    table.insert(entries, {
      kind = 'command',
      name = command,
    })
  end

  for _, entry in ipairs(require('cheatsheet')) do
    entry.kind = 'custom'
    table.insert(entries, entry)
  end

  pickers.new({}, {
    prompt_title = 'Keymaps and Commands',
    finder = finders.new_table({
      results = entries,
      entry_maker = function(entry)
        if entry.kind == 'keymap' then
          local display = string.format(
            '[map:%s:%s] %-18s %s',
            entry.mode,
            entry.scope,
            entry.lhs,
            entry.description
          )

          return {
            value = entry,
            display = display,
            ordinal = table.concat({
              'map', entry.mode, entry.scope, entry.lhs, entry.description,
            }, ' '),
          }
        end

        if entry.kind == 'custom' then
          local action = entry.keys or (entry.command and ':' .. entry.command) or ''
          local display = string.format(
            '[custom:%s] %-18s %s',
            entry.category or 'note',
            action,
            entry.description
          )

          return {
            value = entry,
            display = display,
            ordinal = table.concat({
              'custom',
              entry.category or 'note',
              entry.mode or '',
              action,
              entry.description,
            }, ' '),
          }
        end

        return {
          value = entry,
          display = '[command] :' .. entry.name,
          ordinal = 'command ' .. entry.name,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        if not selection then
          return
        end

        if selection.value.kind == 'keymap' or selection.value.keys then
          vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes(
              selection.value.lhs or selection.value.keys,
              true,
              false,
              true
            ),
            't',
            true
          )
          actions.close(prompt_bufnr)
          return
        end

        actions.close(prompt_bufnr)
        local command = selection.value.name or selection.value.command
        if command then
          vim.api.nvim_feedkeys(':' .. command .. ' ', 'nt', false)
        end
      end)

      return true
    end,
  }):find()
end

vim.api.nvim_create_user_command('Cheatsheet', cheatsheet, {
  desc = 'Search all keymaps and commands',
})

-- Builtin
map({ 'n', 'v' }, '<leader>sg', telescope_builtin.git_files, { desc = '[S]earch [F]iles in Git' })
map({ 'n', 'v' }, '<leader>sf', telescope_builtin.find_files, { desc = '[S]earch [F]iles the Original' })
map({ 'n', 'v' }, '<leader>sw', telescope_builtin.live_grep, { desc = '[S]earch in [W]orkspace' })
map({ 'n', 'v' }, '<leader>sp', telescope_builtin.pickers, { desc = '[S]earch [P]ickers used before' })
map({ 'n', 'v' }, '<leader>sc', telescope_builtin.grep_string, { desc = '[S]earch String Under [C]ursor' })
map({ 'n', 'v' }, '<leader>sr', telescope_builtin.registers, { desc = '[S]earch [R]egisters' })
map({ 'n', 'v' }, '<leader>sj', telescope_builtin.jumplist, { desc = '[S]earch [J]umplist' })
map({ 'n', 'v' }, '<leader>gc', telescope_builtin.git_commits, { desc = '[G]it [C]ommits' })
map({ 'n', 'v' }, '<leader>gbr', telescope_builtin.git_branches, { desc = '[G]it [B]ranches' })
map({ 'n', 'v' }, '<leader>gs', telescope_builtin.git_status, { desc = '[G]it [S]tatus' })
map({ 'n', 'v' }, '<leader>km', telescope_builtin.keymaps, { desc = '[K]ey[m]aps' })
map({ 'n', 'v' }, '<leader>h', telescope_builtin.help_tags, { desc = '[H]elp Neovim' })
map({ 'n', 'v' }, '<leader>o', telescope_builtin.oldfiles, { desc = 'Last Opened Files. [O]ld files' })
map({ 'n', 'v' }, '<leader>cs', telescope_builtin.colorscheme, { desc = 'Change colorscheme' })

map({ 'n', 'v' }, 'B', function()
  telescope_builtin.buffers(require('telescope.themes').get_dropdown {
    previewer = false
  })
end, { desc = 'Select [B]uffers' })

-- Extesions
map({ 'n', 'v' }, '<leader>st', '<cmd>TodoTelescope keywords=FM<cr>', { desc = '[S]earch [T]odo' })
map({ 'n', 'v' }, '<leader>sm', require("telescope").extensions.notify.notify, { desc = 'Show Messages (Notify)' })
map({ 'n', 'v' }, '<leader>sr', '<cmd>Telescope neoclip<cr>', { desc = '[S]earch [R]egisters' })
