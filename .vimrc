" Remap leader
let mapleader = "\<Space>"
set encoding=utf-8

"auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

silent!call plug#begin()

""" Theme ###
Plug 'lifepillar/vim-solarized8'
Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'
Plug 'reedes/vim-colors-pencil'

""" Thematic ###
Plug 'reedes/vim-thematic'

""" Fuzzy Search ###
Plug 'ctrlpvim/ctrlp.vim'

""" Neomake ###
Plug 'neomake/neomake'

""" Vim Surround ###
Plug 'tpope/vim-surround'

""" Airline ###
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

""" Nerd Commenter ###
Plug 'scrooloose/nerdcommenter'

""" Git integration ###
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

""" Goyo ###
Plug 'junegunn/goyo.vim'

""" Pencil ###
Plug 'reedes/vim-pencil'

""" Snippets ###
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

""" Nerdtree ###
Plug 'scrooloose/nerdtree'

""" Tabularize ###
Plug 'godlygeek/tabular'

""" Startify ###
Plug 'mhinz/vim-startify'

""" Zettelkasten ###
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'michal-h21/vim-zettel'

""" pandoc ###
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

""" Markdown ###
Plug 'jkramer/vim-checkbox' " Checkbox manipulation

""" Latex ###
Plug 'lervag/vimtex'
Plug 'hisaknown/deoplete-latex'

""" Python ###
Plug 'vim-scripts/indentpython.vim'

" Neovim only plugins
if has('nvim')
  """ deoplete ###
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  """ Neocomplete ###
  Plug 'Shougo/neocomplete.vim'
endif

call plug#end()

""" Theme ###
let g:pencil_terminal_italics = 1
let g:pencil_spell_undercurl = 0

let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1

syntax enable
if has("patch-7.4-1799") || has("nvim")
  set termguicolors
endif

let python_highlight_all=1

" Set detection, indentation & plugin load for filetypes
" This has to be called early
filetype plugin indent on

""" Thematic ###
let g:thematic#themes = {
\ 'dark' :{'colorscheme': 'nord',
\                 'background': 'dark',
\                 'airline-theme': 'nord',
\                 'ruler': 1,
\                },
\ 'light' :{'colorscheme': 'pencil',
\                 'background': 'light',
\                 'airline-theme': 'pencil',
\                 'ruler': 0,
\                },
\ }

let g:thematic#theme_name = 'dark'

""" Ctrlp ###
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

""" Neomake ###
if has('nvim')
  autocmd! BufWritePost * Neomake
else
  nmap <Leader>l :Neomake<CR>
endif
let g:neomake_virtualtext_current_error = 0 " turn off virtual text
let g:neomake_warning_sign = {
  \ 'text': 'W',
  \ 'texthl': 'WarningMsg',
  \ }
let g:neomake_error_sign = {
  \ 'text': 'E',
  \ 'texthl': 'ErrorMsg',
  \ }

let g:neomake_virtualtext_current_error = 0
let g:neomake_python_enabled_makers = ['pylint']

nmap ]w :lnext<CR>
nmap [w :lprev<CR>

""" Airline ###
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#wordcount#filetypes =
\ ['help', 'markdown', 'text', 'pandoc', 'tex', 'mail']

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_section_y = '%{PencilMode()}'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }

""" Nerd Commenter ###
map <C-_> <Leader>c<space>

""" Git integration ###
map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>i
map <Leader>gd :Gdiff<CR>

""" Goyo ###
nnoremap <leader>go :Goyo <CR>
let g:goyo_width=70
let g:goyo_height=100

""" Pencil ###
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,vimwiki,text,tex call pencil#init()
augroup END
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#autoformat = 0
let g:pencil#conceallevel = 0
let g:pencil#textwidth = 74

""" Snippets ###
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"

""" Nerdtree ###
map <C-\> :NERDTreeToggle<CR>

""" Zettelkasten ###
let g:vimwiki_list = [{'path': '~/zettelkasten',
                     \ 'syntax': 'markdown', 'index': 'readme', 'ext': '.md'}]
let g:vimwiki_global_ext=0
let g:vimwiki_conceallevel=0
let g:zettel_format = "%Y-%m-%d-%H-%M"

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" Disable default keymappings
let g:zettel_default_mappings = 0 
" This is basically the same as the default configuration
augroup zettelkasten
  autocmd!
  autocmd FileType vimwiki imap <silent> [[ [[<esc><Plug>ZettelSearchMap
  autocmd FileType vimwiki nmap T <Plug>ZettelYankNameMap
  autocmd FileType vimwiki xmap z <Plug>ZettelNewSelectedMap
  autocmd FileType vimwiki nmap gZ <Plug>ZettelReplaceFileWithLink
  autocmd FileType vimwiki nmap <C-F> :Ag<CR>
  autocmd FileType vimwiki set syntax=pandoc
  autocmd FileType vimwiki Thematic light
  au FileType vimwiki cd %:p:h
  au! BufWritePost ~/zettelkasten/* !git add "%";git commit -m "Auto commit of %:t." "%"
augroup END

""" Pandoc ###
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#spell#enabled = 0
let g:pandoc#folding#fdc = 0
augroup pandoc_syntax
  au!
  autocmd FileType pandoc set syntax=pandoc
augroup END

""" Latex ###
let g:tex_flavor='latex'
let g:vimtex_fold_enabled = 1

""" Tabularize ###
if exists(":Tabularize")
  nmap <Leader>t= :Tabularize /=<CR>
  vmap <Leader>t= :Tabularize /=<CR>
  nmap <Leader>t: :Tabularize /:\zs<CR>
  vmap <Leader>t: :Tabularize /:\zs<CR>
endif

""" Deo/Neocomplete ###
let g:deoplete#enable_at_startup = 1
let g:neocomplete#enable_at_startup = 1

" Spelling
set spelllang=en_gb
set spellfile=~/.vim/spell/en.utf-8.add
au FileType markdown,text,tex,vimwiki,pandoc set spell
set syntax=pandoc

augroup CustomHighlights
  autocmd!
  autocmd colorscheme *
  \ hi clear SpellLocal
  \ hi clear SpellCap
  \ hi link SpellLocal SpellBad
  \ hi link SpellCap SpellBad
augroup END

noremap <silent> <Leader>s :set invspell<CR>

""" Ditto ###
let g:ditto_hlgroups = ['Todo', 'Todo', 'Todo', 'Todo', 'Todo']



" Fix sloppy linux
set backspace=indent,eol,start
" Tab stuff
set tabstop=2 expandtab shiftwidth=2
"Concealling off
set conceallevel=0
" Disable hard wrapping
set formatoptions-=t
" Mouse support
set mouse=a
" Shell
set shell=/bin/bash
" Vim replaces term title with files being edited
set title
" Current number tracking
set ruler
"set number
" Can change buffer without saving current
set hidden
" Increase history limit
set history=1000
" Who needs vi?
set nocompatible
" Show matching brackets
set showmatch
" Search options
set ignorecase smartcase hlsearch incsearch
let @/ = ""
" disable folding
"set nofoldenable
set foldmethod=expr
set foldlevel=2
" gvim stuff
set guifont=Cousine\ Regular\ 12
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guicursor=
" Fix clipboard
set clipboard^=unnamed,unnamedplus
" Fix airline over ssh
set laststatus=2
" Disable autocommenting
au FileType * set fo-=r fo-=o
" Enable cursorline
set cursorline

" Show whitespace
set listchars=tab:>-,trail:· nolist!
nnoremap <silent> <Leader>w :set nolist!<CR>

" Open up a terminal
noremap <Leader>tt :vspl<cr><C-W><C-L>:term fish<cr>i

" Remap to beginning/end of line
noremap B ^
noremap E $
noremap $ <nop>
noremap ^ <nop>

" Call make
noremap <F6> :make<CR>
noremap <F7> :make test<CR>

" Better movement
nnoremap j gj
nnoremap k gk

" Weaning myself off arrow keys
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

" Window switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Insert date
nnoremap <Leader>d "=strftime("%FT%T%z")<CR>P"

""" Mouse toggling ###
function! ToggleMouse()
    " check if mouse is enabled
    if &mouse == 'a'
        " disable mouse
        set mouse=
    else
        " enable mouse
        set mouse=a
    endif
endfunc

nmap <Leader>m :call ToggleMouse()<CR>

""" Gutter toggling ###
function! ToggleGutter()
  :set invrelativenumber
  :set invnumber
endfunction

nnoremap <Leader>n :call ToggleGutter()<CR>

""" Background toggling ###
let g:markdown_mode="false"
function! ToggleBackground()
  if g:markdown_mode == "false"
    :let g:markdown_mode = "true"
    Thematic light
  else
    :let g:markdown_mode = "false"
    Thematic dark
  endif
endfunction

nnoremap <Leader>b :call ToggleBackground()<CR>

" Just easier commands
nnoremap <Leader>v :vspl<cr><C-W><C-L>
nnoremap <Leader>h <C-W><C-S><C-W><C-J>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>e :e#<cr>
nnoremap vv viw
