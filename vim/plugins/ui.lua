return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {}
  },
  {
    'liuchengxu/space-vim-dark',
    lazy = false,
    priority = 1000,
  },
  'myusuf3/numbers.vim',
  'RRethy/vim-illuminate',
  {
    'ibhagwan/fzf-lua',
    config = function()
      require('fzf-lua').setup({
        lsp = {
          code_actions = {
            winopts = {
              height = 0.2,   -- smaller for code actions (30% of screen)
              width = 0.5,
            },
          },
        },
      })
      require('fzf-lua').register_ui_select()
    end
  },
  'unblevable/quick-scope',
  {
    'kshenoy/vim-signature',
    config = function()
      vim.keymap.set('n', '<leader>m', ':SignatureToggleSigns<CR>')
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {},
    config = function()
      local highlight = {
        "CursorColumn",
        "Whitespace",
      }
      require("ibl").setup {
        indent = { highlight = highlight, char = "" },
        whitespace = {
          highlight = highlight,
          remove_blankline_trail = false,
        },
        scope = { enabled = false },
      }
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options  = { theme = 'tokyonight' },
      sections = {
        lualine_c = { 'filename', 'filetype', 'diagnostics' },
        lualine_x = {
          {
            'lsp_status',
            icon = '',
            symbols = {
              spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
              done = '✓',
              separator = ' ',
            },
            ignore_lsp = {},
          }
        },
      },
    },
  },
  'voldikss/vim-floaterm',
}
