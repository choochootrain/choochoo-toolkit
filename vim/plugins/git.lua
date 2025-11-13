return {
  {
    'airblade/vim-gitgutter',
    config = function()
      -- off by default
      vim.g.gitgutter_enabled = 0
      vim.g.gitgutter_highlight_lines = 1
      vim.g.gitgutter_max_signs = 1000
      -- consistent coloring with line number column
      vim.cmd('highlight clear SignColumn')
    end
  },
  {
    "FabijanZulj/blame.nvim",
    config = function()
      require('blame').setup {}
    end,
    opts = {
      blame_options = { '-w' },
    },
  },
  "sindrets/diffview.nvim",
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  }
}
