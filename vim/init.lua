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
vim.g.maplocalleader = '\\'

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
vim.keymap.set('n', '<leader>f', ':lua FoldColumnToggle()<CR>')

-- scroll faster
vim.keymap.set('n', '<C-e>', '5<C-e>')
vim.keymap.set('n', '<C-y>', '5<C-y>')

-- search in normal
vim.keymap.set('n', '<space>', '/')
vim.keymap.set('n', '<c-space>', '?')

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


--##############################################################################
--#    Plugin config                                                           #
--##############################################################################
if vim.g.vscode then
  return
end

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
  {
    'vim-airline/vim-airline',
    dependencies = { 'vim-airline/vim-airline-themes' },
    config = function()
      -- use fancy symbols
      vim.g.airline_powerline_fonts = 0
      vim.g['airline#extensions#tabline#enabled'] = 1
      vim.g.airline_theme = 'kolor'
    end
  },

  {
    'airblade/vim-gitgutter',
    config = function()
      vim.keymap.set('n', '<leader>gg', ':GitGutterToggle<CR>')
      -- off by default
      vim.g.gitgutter_enabled = 0
      vim.g.gitgutter_highlight_lines = 1
      vim.g.gitgutter_max_signs = 1000
      -- consistent coloring with line number column
      vim.cmd('highlight clear SignColumn')
    end
  },

  {
    'sjl/gundo.vim',
    config = function()
      vim.keymap.set('n', '<leader>u', ':GundoToggle<CR>')
      -- show gundo at bottom
      vim.g.gundo_preview_bottom = 1
    end
  },

  {
    'wsdjeg/FlyGrep.vim',
    cmd = 'FlyGrep',
    config = function()
      vim.keymap.set('n', '<Space>s/', ':FlyGrep<cr>')
    end
  },

  {
    'scrooloose/nerdtree',
    cmd = 'NERDTreeToggle',
    config = function()
      vim.keymap.set('', '<C-n>', ':NERDTreeToggle<CR>')
      vim.g.NERDTreeIgnore = {'\\~$', '__pycache__', '*.pyc$'}
    end
  },

  {
    'kshenoy/vim-signature',
    config = function()
      vim.keymap.set('n', '<leader>m', ':SignatureToggleSigns<CR>')
    end
  },

  {
    'sheerun/vim-polyglot',
    config = function()
      vim.g.jsx_ext_required = 0
      vim.g.vim_markdown_conceal = 0
    end
  },

  {
    'dense-analysis/ale',
    config = function()
      vim.g.ale_fix_on_save = 1
      vim.g.ale_lint_on_text_changed = 'never'
      vim.g['airline#extensions#ale#enabled'] = 1
      vim.keymap.set('n', '<C-k>', '<Plug>(ale_previous_wrap)', { silent = true })
      vim.keymap.set('n', '<C-j>', '<Plug>(ale_next_wrap)', { silent = true })

      vim.g.ale_completion_tsserver_autoimport = 1
      vim.g.ale_linters = {
        rust = {'analyzer'},
        python = {'mypy', 'ruff', 'ruff_format'}
      }
      vim.g.ale_fixers = {
        rust = {'rustfmt'},
        javascript = {'prettier', 'eslint'},
        typescript = {'prettier', 'eslint'},
        typescriptreact = {'prettier', 'eslint'}
      }
      -- vim.g.ale_python_mypy_executable = 'poetry'
      -- vim.g.ale_python_mypy_options = 'run mypy --ignore-missing-imports --scripts-are-modules'
      -- vim.g.ale_python_ruff_executable = 'poetry'
      -- vim.g.ale_python_ruff_options = 'run ruff --fix --exit-non-zero-on-fix'
    end
  },

  {
    'ibhagwan/fzf-lua',
    config = function()
      vim.keymap.set('', '<C-p>', ':FzfLua files<CR>')
      vim.keymap.set('', '<C-f>', ':FzfLua live_grep_native<CR>')
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'javascript', 'typescript', 'python', 'rust' },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end
  },

  'lukas-reineke/indent-blankline.nvim',
  'bling/vim-bufferline',
  'mhinz/vim-startify',
  'myusuf3/numbers.vim',
  'liuchengxu/space-vim-dark',
  'ervandew/supertab',
  'jceb/vim-orgmode',
  'chrisbra/NrrwRgn',
  'leafgarland/typescript-vim',

  {
    'peitalin/vim-jsx-typescript',
    config = function()
      vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
        pattern = {'*.tsx', '*.jsx'},
        command = 'set filetype=typescriptreact'
      })
    end
  },

  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-ui',
  'kristijanhusak/vim-dadbod-completion',
})

------------------------------------------------------------------------------

vim.opt.background = 'dark'
vim.cmd('colorscheme space-vim-dark')
vim.cmd('highlight ColorColumn ctermbg=black')
vim.cmd('highlight Normal ctermbg=none')
vim.cmd('highlight NonText ctermbg=none')
