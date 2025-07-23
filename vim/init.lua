local function lsp_on_attach(client, bufnr)
  local map = function(lhs, rhs, desc)
    vim.keymap.set('n', lhs, rhs,
      { noremap = true, silent = true, buffer = bufnr, desc = desc })
  end

  -- if disable_fmt[client.name] then
  --   client.server_capabilities.documentFormattingProvider = false
  -- else
    ----------------------------------------------------------------
    -- register *BufWritePre* only if this server can still format
    ----------------------------------------------------------------
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  -- end

  ----------------------------------------------------------------
  -- Jump / navigation
  ----------------------------------------------------------------
  map('gd', vim.lsp.buf.definition,        'Go to definition')
  map('gi', vim.lsp.buf.implementation,    'Go to implementation')
  map('gr', vim.lsp.buf.references,        'List references')
  map('gD', vim.lsp.buf.declaration,       'Go to declaration')
  map('<leader>D', vim.lsp.buf.type_definition, 'Go to type definition')

  ----------------------------------------------------------------
  -- Hover, signature help, code actions
  ----------------------------------------------------------------
  map('K',  vim.lsp.buf.hover,             'Hover documentation')
  map('<C-k>', vim.lsp.buf.signature_help, 'Signature help')
  map('<leader>.', vim.lsp.buf.code_action, 'Code action')
  map('<leader>rn', vim.lsp.buf.rename, 'Rename symbol')

  ----------------------------------------------------------------
  -- Diagnostics
  ----------------------------------------------------------------
  --map('[d',  vim.diagnostic.goto_prev,     'Prev diagnostic')
  --map(']d',  vim.diagnostic.goto_next,     'Next diagnostic')
  map('<leader>dl', vim.diagnostic.open_float,'Line diagnostics')
  map('<leader>dq', vim.diagnostic.setloclist,'Quickfix diagnostics')
end

--##############################################################################
--#    Plugin config                                                           #
--##############################################################################
-- Install lazy.nvim if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'liuchengxu/space-vim-dark',

  'mhinz/vim-startify',
  'myusuf3/numbers.vim',
  'RRethy/vim-illuminate',
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
    lazy =
    false,
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
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<space>",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

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

  {
    'kshenoy/vim-signature',
    config = function()
      vim.keymap.set('n', '<leader>m', ':SignatureToggleSigns<CR>')
    end
  },

  -- filetypes
  {
    'sheerun/vim-polyglot',
    config = function()
      vim.g.jsx_ext_required = 0
      vim.g.vim_markdown_conceal = 0
    end
  },
  {
    'peitalin/vim-jsx-typescript',
    config = function()
      vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
        pattern = {'*.tsx', '*.jsx'},
        command = 'set filetype=typescriptreact'
      })
    end
  },

  -- Language support
  {
    'neovim/nvim-lspconfig',
    event = "BufReadPost",
    lazy = false,
    -- TODO: neoconf.vim for project-local settings
    -- config = function()
    --   vim.lsp.config('rust_analyzer', {
    --       settings = {
    --         ['rust-analyzer'] = {
    --           diagnostics = {
    --             enable = true;
    --           }
    --         }
    --       }
    --   });
    -- end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    dependencies = {
      'neovim/nvim-lspconfig'
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'javascript', 'typescript', 'python', 'rust' },
        sync_install = true,
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end
  },

  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    cmd = { "LspLinesToggle" },
    event = "VeryLazy",
    keys = {
      { "<leader>ud", "<cmd>LspLinesToggle<cr>", desc = "Toggle LSP Lines" },
    },
    config = function()
      require("lsp_lines").setup()
      vim.api.nvim_create_user_command("LspLinesToggle", function()
        vim.diagnostic.config({ virtual_text = not require("lsp_lines").toggle() })
      end, { desc = "Toggle LspLines" })

      vim.diagnostic.config({ virtual_lines = { only_current_line = true }, virtual_text = false })
    end,
  },

  -- XXX better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      use_diagnostic_signs = true,
      auto_jump = { "lsp_definitions", "lsp_references", "lsp_type_definitions", "lsp_implementations" },
      action_keys = {
        jump = { "<S-CR>" },
        jump_close = { "<CR>" },
      },
    },
    keys = {
      { "]d", vim.diagnostic.goto_next, desc = "Next diagnostic" },
      { "[d", vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
      { "<leader>xj", vim.diagnostic.goto_next, desc = "Next diagnostic" },
      { "<leader>xk", vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Trouble: Show" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble: Show QuickFix" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Trouble: Show Locationlist" },
      { "<leader>xt", "<cmd>TroubleToggle telescope<cr>", desc = "Trouble: Show Telescope" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble: Show Diagnostics" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble: Show Workspace Diagnostics" },
      --{ "<leader>xD", require("util").toggle_diagnostics, desc = "Toggle Diagnostics" },
      --{ "<leader>ux", require("util").toggle_diagnostics, desc = "Toggle Diagnostics" },
    },
  },

  'ervandew/supertab',

  -- TODO
  -- {
  --   'hrsh7th/nvim-cmp',
  --   event = 'InsertEnter',            -- lazy-load when you enter Insert mode
  --   dependencies = {
  --     'hrsh7th/cmp-nvim-lsp',         -- LSP completions
  --     'L3MON4D3/LuaSnip',             -- snippet engine
  --     'saadparwaiz1/cmp_luasnip',     -- cmp <-> luasnip bridge
  --     'rafamadriz/friendly-snippets', -- (optional) huge set of community snippets
  --   },
  --   config = function()
  --     local cmp = require('cmp')
  --     local luasnip = require('luasnip')

  --     luasnip.config.setup({ history = true, updateevents = 'TextChanged,TextChangedI' })

  --     cmp.setup({
  --       completion = { completeopt = 'menu,menuone,noinsert' },
  --       snippet = {
  --         expand = function(args) luasnip.lsp_expand(args.body) end,
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ['<CR>']     = cmp.mapping.confirm({ select = true }),  -- ⏎ to accept
  --         ['<C-Space>']= cmp.mapping.complete(),                  -- trigger menu
  --         ['<Tab>']    = cmp.mapping(function(fallback)
  --           if cmp.visible() then cmp.select_next_item()
  --           elseif luasnip.jumpable(1) then luasnip.jump(1)
  --           else fallback() end
  --         end, { 'i', 's' }),
  --         ['<S-Tab>']  = cmp.mapping(function(fallback)
  --           if cmp.visible() then cmp.select_prev_item()
  --           elseif luasnip.jumpable(-1) then luasnip.jump(-1)
  --           else fallback() end
  --         end, { 'i', 's' }),
  --       }),
  --       sources = {
  --         { name = 'nvim_lsp' },
  --         { name = 'luasnip'  },
  --         -- add { name = 'buffer' } or others later if you like
  --       },
  --     })
  --   end,
  -- },

  -- ai shit
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("claude-code").setup({
        keymaps = {
          window_navigation = false,
        },
      })
    end
  },

  -- vim.keymap.set('n', '<C-k>', '<Plug>(ale_previous_wrap)', { silent = true })
   -- vim.keymap.set('n', '<C-j>', '<Plug>(ale_next_wrap)', { silent = true })

  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-ui',
  'kristijanhusak/vim-dadbod-completion',
})


--##############################################################################
--#    Basic stuff                                                             #
--##############################################################################

-- v modern v demure
vim.opt.compatible = false

-- change buffer without saving
vim.opt.hidden = true
-- show line numbers
vim.opt.number = true
-- close potential security hole by ignoring modelines in files
vim.opt.modelines = 0
-- no delay when escaping
vim.opt.ttimeoutlen = 0
-- show status line
vim.opt.laststatus = 2
-- modern encoding default
vim.opt.encoding = 'utf-8'
-- shit is annoying
vim.opt.errorbells = false
vim.opt.visualbell = false
-- more natural split opening
vim.opt.splitbelow = true
vim.opt.splitright = true
-- make menu useful
vim.opt.wildmenu = true
-- mouses are for plebs
vim.opt.mouse = ''
-- no redraw while executing macros
vim.opt.lazyredraw = true
-- show informative title
vim.opt.title = true
-- automatically reload files on external change
vim.opt.autoread = true
-- allow a metric shittonne of buffers to be open at once
vim.opt.tabpagemax = 1000
-- automatic swiffer
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = ':%s/\\s\\+$//e'
})

------------------------------------------------------------------------------
-- continue indentation onto next line
vim.opt.autoindent = true
-- copy indentation structure of previous lines
vim.opt.copyindent = true
vim.opt.smartindent = true
-- make vim smart about tabs
vim.opt.smarttab = true
-- use spaces for tab
vim.opt.expandtab = true
-- 2 spaces to tab
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

------------------------------------------------------------------------------
-- keep 5 lines visible below cursor
vim.opt.scrolloff = 5
-- search is case-insensitive unless there is a capital letter
vim.opt.smartcase = true
-- show search results as you type
vim.opt.incsearch = true
-- highlight all matches for previous search
vim.opt.hlsearch = true
-- show matching bracket
vim.opt.showmatch = true
-- use very magic search patterns (standard regex)
vim.keymap.set('n', '/', '/\\v', { noremap = true })
vim.keymap.set('v', '/', '/\\v', { noremap = true })

------------------------------------------------------------------------------
-- dont save backup files
vim.opt.backup = false
-- dont make swap files
vim.opt.swapfile = false

------------------------------------------------------------------------------
-- characters treated as whitespace
vim.opt.listchars = 'eol:$,tab:>-,trail:.,extends:>,precedes:<,nbsp:_'
-- make deleting useful
vim.opt.backspace = 'indent,eol,start'
-- highlight conflict markers
vim.fn.matchadd('ErrorMsg', '^\\(<\\||\\|=\\|>\\)\\{7\\}\\([^=].\\+\\)\\?$')

------------------------------------------------------------------------------
-- add line at 80 characters
vim.opt.colorcolumn = '80'
-- show current line
vim.opt.cursorline = true
-- show current column
vim.opt.cursorcolumn = true

------------------------------------------------------------------------------
-- enable code folding
vim.opt.foldenable = true
-- hide fold column on start
vim.opt.foldcolumn = '0'
-- set folds by syntax
vim.opt.foldmethod = 'syntax'
-- start with all folds open
vim.opt.foldlevelstart = 99
-- specify commands which open folds
vim.opt.foldopen = 'block,hor,insert,jump,mark,percent,quickfix,search,tag,undo'
-- make foldcolumn 4 characters wide
vim.g.last_fold_column_width = 4
function FoldColumnToggle()
  if vim.wo.foldcolumn ~= '0' then
    vim.g.last_fold_column_width = vim.wo.foldcolumn
    vim.wo.foldcolumn = '0'
  else
    vim.wo.foldcolumn = tostring(vim.g.last_fold_column_width)
  end
end

------------------------------------------------------------------------------
-- file specific settings
vim.cmd('filetype plugin indent on')

-- syntax highlighting is kinda useful
vim.cmd('syntax on')

------------------------------------------------------------------------------
-- load directory specific files
--   only works when vim is invoked in same directory as .vim.custom
if vim.fn.filereadable('.vim.custom') == 1 then
  vim.cmd('source .vim.custom')
end

------------------------------------------------------------------------------
-- :W sudo saves the file when opened without write permissions
vim.api.nvim_create_user_command('W', 'w !sudo tee % > /dev/null', {})


--##############################################################################
--#    Leader keybindings                                                      #
--##############################################################################

-- set leader keys
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- edit vimrc
vim.keymap.set('n', '<leader>ev', ':tabe $MYVIMRC<CR>', { silent = true })
-- reload vimrc
vim.keymap.set('n', '<leader>sv', ':so $MYVIMRC<CR>', { silent = true })

-- toggle whitespace visible
vim.keymap.set('n', '<leader>i', ':set list! <CR>')

-- fix indents
vim.keymap.set('n', '<leader>in', "gg=G''")

-- copy selected text
vim.keymap.set('n', '<leader>c', ':w !xsel -i -b<CR>')

-- next tab
vim.keymap.set('n', '<leader>w', 'gt<CR>')
-- previous tab
vim.keymap.set('n', '<leader>q', 'gT<CR>')

-- next buffer
vim.keymap.set('n', '<leader>W', ':bn<CR>')
-- previous buffer
vim.keymap.set('n', '<leader>Q', ':bp<CR>')

-- toggle fold open/close
vim.keymap.set('n', '<leader>z', 'za')

-- toggle fold column show/hide
vim.keymap.set('n', '<leader>fc', ':lua FoldColumnToggle()<CR>')

-- scroll faster
vim.keymap.set('n', '<C-e>', '5<C-e>')
vim.keymap.set('n', '<C-y>', '5<C-y>')

-- make : commands easier to type
vim.keymap.set('n', ';', ':')
-- keep semicolon accessible for idk what
vim.keymap.set('n', '<leader>;', ';')

-- jump to matching bracket
vim.keymap.set('n', '<Tab>', '%')
vim.keymap.set('v', '<Tab>', '%')

-- jump to next conflict marker
vim.keymap.set('n', '<leader>co', '/^\\(<\\\\|=\\\\|>\\)\\{7\\}\\([^=].\\+\\)\\?$<CR>', { silent = true })

-- clear trailing whitespace
vim.keymap.set('', '<leader>T', ':%s/\\s\\+$//<CR>')

-- delete and yank into blackhole
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

-- paste and yank into blackhole
vim.keymap.set('v', '<leader>p', '"_dP')

-- persist undos
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.config/nvim/undo')

-- escape from terminal mode like a sane person
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- navigate from terminal mode like a sane person
vim.keymap.set('t', '<C-w>h', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-w>j', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-w>k', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-w>l', '<C-\\><C-n><C-w>l')

-- start in terminal mode like a sane person because i'm in a terminal
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'term://*',
  command = 'startinsert'
})

------------------------------------------------------------------------------

vim.opt.background = 'dark'
vim.cmd('colorscheme space-vim-dark')
vim.cmd('highlight ColorColumn ctermbg=black')
vim.cmd('highlight Normal ctermbg=none')
vim.cmd('highlight NonText ctermbg=none')

------------------------------------------------------------------------------

vim.keymap.set('n', '<leader>f',       ':FzfLua files<CR>')

vim.keymap.set('n', '<leader>g',       ':FzfLua grep_cword<CR>')
vim.keymap.set('n', '<leader>gl',      ':FzfLua live_grep_native<CR>')
vim.keymap.set('n', '<leader>gb',      ':BlameToggle window<CR>')
vim.keymap.set('n', '<leader>gg',      ':GitGutterToggle<CR>')

vim.keymap.set('n', '<leader>s',       ':FzfLua lsp_document_symbols<CR>')
vim.keymap.set('n', '<leader>sw',      ':FzfLua lsp_live_workspace_symbols<CR>')
vim.keymap.set('n', '<leader>sf',      ':FzfLua lsp_finder<CR>')
vim.keymap.set('n', '<leader>d',       ':FzfLua diagnostics_document<CR>')
