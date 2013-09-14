set modelines=0
set colorcolumn=85
au FocusLost * :wa
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
autocmd BufWritePre * :%s/\s\+$//e

" powerline
set laststatus=2
set encoding=utf-8

" Use the damn hjkl keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Easy window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
nnoremap <leader>w <C-w>v<C-w>l

" more natural split opening
set splitbelow
set splitright

""Max out the height of the current split
"ctrl + w _
""Max out the width of the current split
"ctrl + w |
""Normalize all split sizes, which is very handy when resizing terminal
"ctrl + w =
""Swap top/bottom or left/right split
"Ctrl+W R
""Break out current window into a new tabview
"Ctrl+W T
""Close every window in the current tabview but the current one
"Ctrl+W o

filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on

let mapleader=","
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
noremap <leader>i :set list! <CR>
noremap <leader>q :q
noremap <leader>in gg=G''
noremap <leader>c :w !xsel -i -b<CR>

nnoremap / /\v
vnoremap / /\v

nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" Line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <leader>nu :call NumberToggle()<cr>
set relativenumber
au FocusLost * :set number
au FocusGained * :set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" basic stuff
set autoindent
set copyindent
set showmatch
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
set backspace=indent,eol,start
set wildmenu
set mouse=a

set smartcase
set incsearch
set hlsearch
set autoread
set title

set foldenable
set foldcolumn=2
set foldmethod=syntax
set foldlevelstart=99
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

function! MyFoldText()
  let line = getLine(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount)
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
  return line . ' …' . repeat(' ', fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()

nnoremap <leader>z za

nnoremap <leader>f :call FoldColumnToggle()<cr>
let g:last_fold_column_width = 4

" {{{
function! FoldColumnToggle()
  if &foldcolumn
    let g:last_fold_column_width = &foldcolumn
    setlocal foldcolumn=0
  else
    let &l:foldcolumn = g:last_fold_column_width
  endif
endfunction
" }}}

nnoremap ; :
nnoremap <leader>; ;

set cursorline
set cursorcolumn

set nobackup
set noswapfile

nnoremap <Tab> %
vnoremap <Tab> %

" Conflict markers {{{
" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" shortcut to jump to next conflict marker
nnoremap <silent> <leader>co /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
" }}}

set background=dark
colorscheme solarized
call togglebg#map("<F5>")

set listchars=eol:$,tab:>-,trail:.,extends:>,precedes:<,nbsp:_
highlight SpecialKey ctermfg=6
highlight NonText ctermfg=6

"NERDTree settings {{{
" Put focus to the NERD Tree with F3 (tricked by quickly closing it and
" immediately showing it again, since there is no :NERDTreeFocus command)
nnoremap <leader>n :NERDTreeClose<CR>:NERDTreeToggle<CR>
nnoremap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
nnoremap <leader>N :NERDTreeClose<CR>

" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

" Quit on opening files from the tree
let NERDTreeQuitOnOpen=1

" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1

" Use a single click to fold/unfold directories and a double click to open files
let NERDTreeMouseMode=2

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
      \ '\.o$', '\.so$', '\.egg$', '^\.git$' ]
" Open if no files specified
autocmd vimenter * if !argc() | NERDTree | endif

" Close if last buffer open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" }}}

" Taglist settings {{{
noremap <leader>t :TagbarToggle<CR>
let Tlist_Exit_OnlyWindow=1         " quit when TagList is the last open window
let Tlist_GainFocus_On_ToggleOpen=1 " put focus on the TagList window when it opens
" }}}


" Gitgutter settings {{{
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 1
highlight clear SignColumn
noremap <leader>gg :GitGutterToggle<CR>
" }}}

" Gundo settings {{{
noremap <leader>u :GundoToggle<CR>
let g:gundo_preview_bottom = 1
" }}}

" Arduino settings
autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp

" Project specific settings
if filereadable(".vim.custom")
  so .vim.custom
endif
