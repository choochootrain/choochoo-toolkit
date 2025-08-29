return {
  'liuchengxu/space-vim-dark',
  'myusuf3/numbers.vim',
  'RRethy/vim-illuminate',
  'ibhagwan/fzf-lua',
--  {
--    'nvim-telescope/telescope.nvim', tag = '0.1.8',
--    dependencies = {
--      'nvim-lua/plenary.nvim',
--      {
--        'nvim-telescope/telescope-fzf-native.nvim',
--        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
--      },
--    },
--    config = function()
--      local telescope = require('telescope')
--      telescope.setup({
--        defaults = {
--          layout_config = { prompt_position = 'top' },
--          sorting_strategy = 'ascending',
--          winblend = 10,
--          pickers = {
--            find_files = { hidden = true },
--          },
--        }
--      })
--      telescope.load_extension('fzf')
--    end
--  },
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
      options  = { theme = 'ayu_dark' },
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
