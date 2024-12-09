require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  require 'kickstart/plugins/gitsigns',

  require 'kickstart/plugins/which-key',

  require 'kickstart/plugins/telescope',

  require 'kickstart/plugins/lspconfig',

  require 'kickstart/plugins/conform',

  require 'kickstart/plugins/cmp',

  --  require 'kickstart/plugins/theme',

  require 'kickstart/plugins/todo-comments',

  require 'kickstart/plugins/mini',

  require 'kickstart/plugins/treesitter',

  -- Custom plugins

  require 'custom/plugins/oil',

  require 'custom/plugins/notify',

  require 'custom.plugins.lazygit',

  require 'custom.plugins.noice',

  require 'custom.plugins.trouble',

  require 'custom.plugins.window_picker',

  require 'custom.plugins.flash',

  require 'custom.plugins.neotree',

  require 'custom.plugins.bufferline',

  --  require 'custom.plugins.auto-dark',

  require 'custom.plugins.snacks',

  require 'custom.plugins.typescript-tools',

  require 'kickstart.plugins.lint',

  require 'kickstart.plugins.autopairs',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et