set nocompatible              " be iMproved, required
filetype off                  " required

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'FredKSchott/CoVim'
Plug 'Raimondi/delimitMate' "auto close quotes, paren, etc
Plug 'airblade/vim-gitgutter'
Plug 'blindFS/vim-taskwarrior'
Plug 'bling/vim-airline'
Plug 'chr4/nginx.vim'
Plug 'fatih/vim-go'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'janko-m/vim-test'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'mileszs/ack.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'peterhoeg/vim-qml'
Plug 'rizzatti/dash.vim'
Plug 'rking/ag.vim'
Plug 'rust-lang/rust.vim'
Plug 'samsonw/vim-task'
"Plug 'scrooloose/syntastic'
Plug 'skywind3000/asyncrun.vim'
"Plug 'ternjs/tern_for_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-vinegar'
Plug 'trayo/vim-ginkgo-snippets'
Plug 'trayo/vim-gomega-snippets'
Plug 'vim-scripts/dbext.vim'
Plug 'vim-scripts/loremipsum'
Plug 'vim-scripts/SyntaxRange'
Plug 'wakatime/vim-wakatime'
Plug 'wavded/vim-stylus'
Plug 'apple/swift', { 'rtp': 'utils/vim' }
Plug 'google/protobuf', { 'rtp': 'editors' }
Plug 'wagnerf42/vim-clippy'
Plug 'w0rp/ale'
Plug 'udalov/kotlin-vim'


if !has('nvim')
  Plug 'valloric/YouCompleteMe'
  " Let YCM load config files in code folder automatically
  let g:ycm_extra_conf_globlist = ['~/code/*','!~/*']
  let g:ycm_complete_in_comments = 1
  let g:ycm_seed_identifiers_with_syntax = 1
  let g:ycm_add_preview_to_completeopt = 1
  let g:ycm_autoclose_preview_window_after_insertion = 1
  """"""""" Snippets """""""""""
  " Track the engine.
  Plug 'SirVer/ultisnips'
endif

if has('nvim')
  Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }
  Plug 'junegunn/fzf'
  Plug 'Shougo/neosnippet'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'zchee/deoplete-go', { 'do': 'make'}
  Plug 'sebastianmarkow/deoplete-rust'
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  Plug 'zchee/deoplete-clang'
  let g:deoplete#sources#clang#libclang_path = "/usr/local/Cellar/llvm/6.0.1/lib/libclang.dylib"
  let g:deoplete#sources#clang#clang_header = "/usr/local/Cellar/llvm/6.0.1/lib/clang"

  let g:deoplete#enable_at_startup = 1
  let g:deoplete#disable_auto_complete = 1
  let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
  " <CR>: If popup menu visible, expand snippet or close popup with selection,
  "       Otherwise, check if within empty pair and use delimitMate.
  inoremap <silent><expr><CR> pumvisible() ?
    \ (neosnippet#expandable() ? neosnippet#mappings#expand_impl() : deoplete#close_popup())
      \ : (delimitMate#WithinEmptyPair() ? "\<C-R>=delimitMate#ExpandReturn()\<CR>" : "\<CR>")

  " <Tab> completion:
  " 1. If popup menu is visible, select and insert next item
  " 2. Otherwise, if within a snippet, jump to next input
  " 3. Otherwise, if preceding chars are whitespace, insert tab char
  " 4. Otherwise, start manual autocomplete
  imap <silent><expr><Tab> pumvisible() ? "\<C-n>"
    \ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
    \ : (<SID>is_whitespace() ? "\<Tab>"
    \ : deoplete#manual_complete()))

  smap <silent><expr><Tab> pumvisible() ? "\<C-n>"
    \ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
    \ : (<SID>is_whitespace() ? "\<Tab>"
    \ : deoplete#manual_complete()))

  inoremap <expr><S-Tab>  pumvisible() ? "\<Up>" : "\<C-h>"

  function! s:is_whitespace() "{{{
    let col = col('.') - 1
    return ! col || getline('.')[col - 1] =~? '\s'
  endfunction "}}}

  let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls']
    \}
  nmap <leader>f :call LanguageClient_contextMenu()<CR>
endif
call plug#end()

filetype plugin indent on    " required

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set nowritebackup
set noshowmode
set history=50 " keep 50 lines of command line history
set ruler      " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch  " do incremental searching

" disable completopt preview
set completeopt=menuone

" Limit autocomplete to 10
set pumheight=10

" Don't use Ex mode, use Q for formatting
map Q gq

" Colors
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

colorscheme railscasts

" Enable the following to keep terminal color
"hi Normal guibg=NONE ctermbg=NONE
hi clear SignColumn


" Show line numbers
set number
set numberwidth=5

" Turn on Mouse Capture
set mouse=a
if !has('nvim')
  " Add support for iTerm2 and Large windows
  if has('mouse_sgr')
    set ttymouse=sgr
  endif
endif

" Switch wrap off for everything
set formatoptions=tcqw
set nowrap
set textwidth=80
set colorcolumn=80

" Softtabs, 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Always display the status line
set laststatus=2

" \ is the leader character
let mapleader = ","

" Go mappings
au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <leader>gbd <Plug>(go-build)
au FileType go nmap <leader>gtst :GoTest<CR>
au FileType go nmap <leader>gtf :GoTestFunc<CR>
au FileType go nmap <leader>gcov <Plug>(go-coverage)
au FileType go nmap <Leader>gdoc <Plug>(go-doc)
au FileType go nmap gds <Plug>(go-def-split)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>s <Plug>(go-implements)

" Swap header and implementation
map <leader>sw :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Run Make - this runs the !make
map <leader>mk :Make<CR>
map <leader>mkr :Make run<CR>

" Run make - this runs makeprg
map <leader>r :make<CR>

" Tasks
map <leader>tt :call Toggle_task_status()<CR>

" Don't confirm switching when a buffer is not saved
set hidden

" Default to syntax based folding
set foldmethod=syntax

if has("autocmd")
  " Set File type to 'text' for files ending in .txt
  autocmd BufNewFile,BufRead *.txt setfiletype text
  autocmd BufNewFile,BufRead todo.txt,*.task,*.tasks,*.todo  setfiletype task
  autocmd BufRead,BufNewFile *.es6 setfiletype javascript

  " Enable soft-wrapping for text files
  autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

  " Enable indent folds for tasks
  autocmd FileType task set foldmethod=indent

  " Enable indent folds for qml
  autocmd FileType qml set foldmethod=indent

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Automatically load .vimrc source when saved
  autocmd BufWritePost .vimrc source $MYVIMRC

  augroup END
endif

set foldenable
set foldlevelstart=10
set foldnestmax=10
noremap <space> za

" Hide search highlighting
map <Leader>h :set invhls <CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" Display extra whitespace
"set list listchars=tab:»·,trail:·
" Delete trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Use Ag instead of Grep when available
if executable("ag")
  set grepprg="ag --vimgrep"
  let g:ackprg = 'ag --vimgrep'
endif

" Enable Ninja if available
if executable("ninja")
  if filereadable("./build.ninja")
    command! Ninja execute "!ninja"
  elseif filereadable("./build/build.ninja")
    command! Ninja execute "!ninja -C build"
  endif
  set makeprg=ninja
endif

" Tags
map <Leader>` :TagbarToggle<CR>
set tags=./tags;

" Friendly save - will not re-enter insert mode
nmap <Leader>w :w<CR>
imap <Leader>w <Esc><Leader>w
" will restore visual select
vmap <Leader>w <Esc><Leader>wgv

" Beautification

nmap <Leader>a= :Tabularize decl_assign<CR>
vmap <Leader>a= :Tabularize decl_assign<CR>
nmap <Leader>a: :Tabularize /:/l2r2<CR>
vmap <Leader>a: :Tabularize /:/l2r2<CR>

if !has("nvim")
  " Configure Ultisnips + YCM to play nice
  let g:UltiSnipsExpandTrigger = "<nop>"
  let g:ulti_expand_or_jump_res = 0
  function! ExpandSnippetOrCarriageReturn()
      let snippet = UltiSnips#ExpandSnippetOrJump()
      if g:ulti_expand_or_jump_res > 0
          return snippet
      else
          return "\<CR>"
      endif
  endfunction
  inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
endif

" Local config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif



" Change CamelCase to snake_case
nmap <Leader>cts :s#\(\<\u\l\+\\|\l\+\)\(\u\)#\l\1_\l\2#g<CR>
vmap <Leader>cts :s#\%V\(\<\u\l\+\\|\l\+\)\(\u\)#\l\1_\l\2#g<CR>

" Ctrl-P Hide build/dist folders
let g:ctrlp_custom_ignore = '\v(build|dist|tmp|bower_components|node_modules|cordova|build_cache|Godeps|vendor)$'

" Setup Vim Test
let test#strategy = "asyncrun"
let test#go#runner = 'ginkgo'
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Auto open QuickFix window when tests run
function! CloseQuickFixOnSuccess()
    if g:asyncrun_status =~ "success"
        call asyncrun#quickfix_toggle(8, 0)
    endif
endfunction

augroup vimrc
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
    autocmd User AsyncRunStop call CloseQuickFixOnSuccess()
augroup END

" Use Go Imports
let g:go_fmt_command = "goimports"
" Turn on error checking with Go/Syntastic
"let g:syntastic_go_checkers = ['gofmt', 'golint', 'govet', 'errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"

" Collaborative Vim
let CoVim_default_name = "kayle"
let CoVim_default_port = "1337"

" Lint
let g:ale_linters = {
\   'javascript': ['standard'],
\   'go': ['gofmt', 'gometalinter'],
\   'rust': ['cargo', 'rls'],
\}
let g:ale_fixers = {
\   'javascript': ['standard'],
\}

" Project Specific VimRC
set exrc
set secure

" Customize syntax highlighting
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

au BufRead,BufNewFile * syn match simpleIterator '\C[^a-zA-Z0-9][ijk][^a-zA-Z0-9]'

function! CustomizeSyntax()
  if has('nvim')
    highlight Comment cterm=italic ctermfg=137
  endif
  if !has('nvim')
    highlight Comment cterm=italic ctermbg=bg ctermfg=137
  endif
  highlight Identifier cterm=italic
  highlight Constant cterm=bold
  highlight simpleIterator cterm=italic
  highlight Special ctermfg=67
  highlight ColorColumn ctermbg=black
endfunction
au BufRead,BufNewFile * call CustomizeSyntax()

" Rust Lang
let g:rustfmt_command = "cargo fmt -- "
let g:rustfmt_autosave = 1 " Enable auto format on save
"let g:syntastic_rust_checkers = ['clippy', 'rustc']
let g:ycm_rust_src_path = $RUST_SRC_PATH
let g:deoplete#sources#rust#rust_source_path=$RUST_SRC_PATH
let g:deoplete#sources#rust#racer_binary='/Users/kayle/.cargo/bin/racer'
let g:rust_fold=1

function! SetRustOptions()
  set textwidth=99
  set colorcolumn=99
  set tabstop=4
  set softtabstop=4
  set shiftwidth=4
endfunction
au FileType rust call SetRustOptions()

if &term =~ 'tmux'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

com! FormatJSON %!python -m json.tool
