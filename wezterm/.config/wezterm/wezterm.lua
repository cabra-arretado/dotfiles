local wezterm = require 'wezterm'
local sessionizer = require("sessionizer")
local act = wezterm.action

local config = wezterm.config_builder()

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane;
  local title = pane.title;

  -- Customize the title based on the current process or other conditions
  if title == "v" then
    return "Neovim";
  elseif string.find(title, "top") then
    return "System Monitor";
  else
    return title;  -- Default to the original title if no condition matches
  end
end)

config.window_padding = {
  left = 1,
  right = 1,
  top = 0,
  bottom = 0,
}

config.color_scheme = 'Andromeda'
-- config.color_scheme = 'Tokyo Night'
config.font_size = 16
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.audible_bell = "Disabled"

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.mouse_bindings = {
  -- Make triple click select the shell integration semantic zone instead of a single line.
  {
    event = { Down = { streak = 3, button = "Left" } },
    mods = "NONE",
    action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
  },
}

local keys = {

  ----------------- Multiplexing -----------------
  -- Pane splitting
  { key = "|", mods = "LEADER", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = "-", mods = "LEADER", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },

  -- Pane navigation
  { key = "h", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Left" } },
  { key = "l", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Right" } },
  { key = "k", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Up" } },
  { key = "j", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Down" } },

  -- Tab management
  { key = "c", mods = "LEADER", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
  { key = "w", mods = "LEADER", action = wezterm.action { CloseCurrentTab = { confirm = true } } },
  { key = "n", mods = "LEADER", action = wezterm.action { ActivateTabRelative = 1 } },
  { key = "p", mods = "LEADER", action = wezterm.action { ActivateTabRelative = -1 } },

  ---- Some tests
  --- TODO: Maybe do the SpawnCommand? https://wezfurlong.org/wezterm/config/launch.html#changing-the-default-program
  { key = "s", mods = "LEADER", action = wezterm.action.ShowLauncherArgs { flags = 'WORKSPACES',  } },

  -----------------------------------------------
  -- Sessionizer --
  { key = "f", mods = "LEADER", action = wezterm.action_callback(sessionizer.toggle) },
  { key = "F", mods = "LEADER", action = wezterm.action_callback(sessionizer.resetCacheAndToggle) },
}

if wezterm.has_action("PromptInputLine") then
  table.insert(keys, {
    key = "t",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = "Enter name for new workspace",
      action = wezterm.action_callback(function(window, pane, line)
        local name = line and line:match("^%s*(.-)%s*$")
        if name and name ~= "" then
          window:perform_action(
            act.SwitchToWorkspace({ name = name }),
            pane
          )
        end
      end),
    }),
  })
end

config.keys = keys

return config
