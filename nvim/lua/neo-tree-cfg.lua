local neotree = require("neo-tree")

neotree.setup({
  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
  -- popup_border_style = "rounded",
  enable_git_status = true,
  sources = {
    "filesystem",
    "buffers",
    "git_status",
  },
  source_selector = {
    winbar = true,
    statusline = false
  },
  default_component_configs = {
    container = {
      enable_character_fade = true,
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      -- folder_closed = "",
      -- folder_open = "",
      -- folder_empty = "",
      default = " ",
      highlight = "NeoTreeFileIcon",
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        added = "✚", -- but this is redundant info if you use git_status_colors on the name
        modified = "", -- , but this is redundant info if you use git_status_colors on the name
        deleted = "", -- this can only be used in the git_status source
        renamed = "", -- this can only be used in the git_status source
        -- Status type
        untracked = "",
        ignored = "",
        -- unstaged = "",
        unstaged = "U",
        staged = "",
        conflict = "",
      },
    },
  }
})
