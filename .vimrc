"Pathon is only used becouse vundle doesn't find template in runtime
call pathogen#infect()
call pathogen#helptags()
"runtime! plugin/sensible.vim
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Basics {
  set nocompatible " Necesary for lots of cool vim things - should be first line
  " Use visualbell instead of sound bell
  set noerrorbells
  set visualbell
  set t_vb=

" }

" GUI Settings {
  set title
  set t_Co=256
" }

" General {
  set background=dark " Assume a dark background

  " Allow to trigger background
  function! ToggleBG()
      let s:tbg = &background
      " Inversion
      if s:tbg == "dark"
          set background=light
      else
          set background=dark
      endif
  endfunction
  noremap <leader>bg :call ToggleBG()<CR>

  syntax enable
  set shortmess=aIoO
  "set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
  set nospell
  "set spell " Spell checking on
  set hidden " Allow buffer switching without saving
  set history=1000 " Store a ton of history (default is 20)

  set noswapfile " Swapfiles are really anoying
  set nobackup "Backups are nice ...
  set nowritebackup
  " Persistent Undo {
      set undodir=$HOME/.vim/undo
      set undofile " So is persistent undo ...
      set undolevels=1000 " Maximum number of changes that can be undone
      set undoreload=10000 " Maximum number lines to save for undo on a buffer reload
  " }
  set clipboard=unnamed "when vim yanks something throw it to the osx clipboard"
  set mouse=nicr "iTerm2 scroll mouse
" }

" Vim UI {

  set showmatch " Show matching brackerts/parenthesis
  set cursorline " highlight current line
  set incsearch " Find as you type search
  set hlsearch " Highlight search terms
  set ignorecase " Case insensitive search
  set smartcase " Ignore case if all case is lowercase
  "set wildmenu -" Couldn't make it work " Show list instead of just completing
  "set wildmode=list:longest,full -" Could't make it work " Comand <Tab>
  "completion, list matches, then longest common part, then all.
  set scrolljump=1 " Lines to scroll when cursor leaves screen
  set scrolloff=5 " Minimum lines to keep above and below cursor
  set list " Show especial characters
  set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
  set number " Line numbers on

  "Don't know what the following 2 commands do
  "highlight clear SignColumn      " SignColumn should match background 
  "highlight clear LineNr          " Current line number row will have same background color in relative mode

  " Ignore folders on ctrl+p and expansion
  "set wildignore+=*/vendor/**
  set wildignore+=*/node_modules/**
" }

" Formatting {

set nowrap " Do not wrap long lines
set autoindent " Indent at the same level of the previous line
set copyindent " copy the previous indentation on autoindent
"set textwidth=80
set formatoptions-=t
set formatoptions+=rn
set shiftwidth=4 " Use indents of 4 spaces
autocmd FileType scss setlocal shiftwidth=2 " Use indents of 2 spaces on scss files
set expandtab " Tabs are spaces, not tabs
set tabstop=4 " An indentation every four colums
set softtabstop=4 " Let backspace delete indent of 4 spaces
"set smartindent
set backspace=2 " make backspace work like most other apps deleting things like eol

set splitbelow " Puts new split windows to the bottom of the current one
set splitright " Puts new vsplit windows to the right of the current one

"To set config for some filetypes
"autocmd FileType ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2

set matchpairs+=<:> " Match, to be used with %

" }

" Unknown Category {
  set modelines=1
  set nuw=6
" }

" Key Mappings {
  let mapleader="," " set map leader to comma
  let g:mapleader = ","
  " Visual shifthing (keepts in visual mode after shift)
  vnoremap < <gv
  vnoremap > >gv
  :inoremap jk <esc>

  "easier window nagivation
  nmap <C-h> <C-w>h
  nmap <C-j> <C-w>j
  nmap <C-k> <C-w>k
  nmap <C-l> <C-w>l

  "Splits
  nmap vs :vsplit<cr>
  nmap sp :split<cr>

  "Resize vsplit
  "nmap <C-v> :vertical resize +5<ccr>
  "nmap 25 :vertical resize 40<cr>
  "nmap 50 <c-w>=
  "nmap 75 :vertical resize 120<cr>

  "Creates a split below
  nmap :sp :rightbelow sp<cr>

" Language specific key mappings{

"    PHP {
        map <leader>t :!phpunit %<cr>
        map <leader>lt :!vendor/bin/phpunit <cr>
"    }
"  }

" }

" Tempalte config
let g:gruvbox_italic=1
colorscheme gruvbox
"draws comments in italics
highlight Comment cterm=italic

" Plugins {
"
  " vim-airline {
      function GAF()
          "Return branch name parsed for Autofact naming standar
          return matchstr(fugitive#statusline(), '\w*-\d*')
      endfunction
      set laststatus=2

      if has('unix')
          let g:airline_section_b = '%{GAF()}'
      else
          let g:airline_symbols.branch = '🔀'
      endif

      let g:airline_powerline_fonts = 1
      "let g:airline#extensions#tabline#enabled = 1 "display all buffers on top when there's only one tab open
      let g:airline#extensions#whitespace#enabled=0 "Don't show 'trailing[x]' on warning
      if !exists('g:airline_symbols')
          let g:airline_symbols = {}
      endif
      "let g:airline_section_warning= '%{fugitive#statusline()}'
  " }

  " Nerd tree {
      nmap <C-n> :NERDTreeToggle<CR>
      imap <C-n> <C-O><C-E>
      let NERDTreeWinSize=40
      let NERDTreeMinimalUI=1
      let NERDTreeIgnore=['build-.*', 'stage-.*', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
      "let g:NERDshutUp=1 "disable warning comments for nerd tree
  " }

  " PIV {
      "let g:DisableAutoPHPFolding = 1 "Disables Better php folding
      "let php_folding=0 "Disables php folding
      "let g:PIVAutoClose =1 " Automatic close char mapping?
      "Fix for color loss
      map <F12> <Esc>:syn sync fromstart<Cr>
  " }

  " Matchit {
      "plugin isn't installed
      "let b:match_ignorecase=1
  " }

  " ctrlp {
        function! Ignore_vendor(item, type)
            return fnamemodify(a:item, ':.') =~ '^vendor'
        endfunction

        let g:ctrlp_working_path_mode = 'ra'
        let g:ctrlp_clear_cache_on_exit = 0
        let g:ctrlp_custom_ignore = {
                    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|node_modules$\|smarty$\|static$\|node_modules',
                    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$\|\.png$',
                    \ 'func': 'Ignore_vendor'
                    \}
        if executable('ag')
            let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
        endif
  " }


  " syntastic {
       let g:syntastic_php_checkers=['php', 'phpcs']
       let g:syntastic_php_phpcs_args='--standard=PSR2 -n'

       let g:syntastic_scss_checkers=['sass_lint']
       let g:syntastic_sass_sass_args='-I '.getcwd()

       let g:syntastic_html_checkers=['htmlhint']

       set statusline+=%#warningmsg#
       set statusline+=%{SyntasticStatuslineFlag()}
       set statusline+=%*

       let g:syntastic_always_populate_loc_list = 1
       let g:syntastic_auto_loc_list = 1
       let g:syntastic_check_on_open = 1
       let g:syntastic_check_on_wq = 0

       let g:syntastic_html_tidy_ignore_errors=["trimming empty <"]
  " }

  " php.vim {
      "this will highlight phpDocs
      function! PhpSyntaxOverride()
          hi! def link phpDocTags  phpDefine
          hi! def link phpDocParam phpType
      endfunction

      augroup phpSyntaxOverride
          autocmd!
          autocmd FileType php call PhpSyntaxOverride()
      augroup END
  " }

  " omnicomplete, superTab {
        autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
        set completeopt=longest,menuone "Show always the menu and complete with the longest

        let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
  " }


" VIM Plugins
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" PIV
"Plugin 'spf13/PIV'

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" nerd tree
Plugin 'scrooloose/nerdtree'

" Color Scheme gruvbox
Plugin 'morhetz/gruvbox'

" Airline (bottom bar)
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline' "buffers in airline

" Git support
Plugin 'mhinz/vim-signify'   " show diff of git on the left
Plugin 'tpope/vim-fugitive'  " ADd extra git options inside vim

" Blade sintax support
Plugin 'jwalton512/vim-blade'

" Search throught proyect with ctrl+p
Plugin 'ctrlpvim/ctrlp.vim'

" PHP Omnicomplete omni complete is a feature in vim 7
" Needs to install universal-ctags
Plugin 'shawncplus/phpcomplete.vim'

Plugin 'captbaritone/better-indent-support-for-php-with-html'

" Look for sintax errors on code
Plugin 'scrooloose/syntastic'

Plugin 'ervandew/supertab'

Plugin 'StanAngeloff/php.vim' " Update php syntaxs to 5.6

Plugin 'MarcWeber/vim-addon-mw-utils' "vim-snipmate dependency
Plugin 'tomtom/tlib_vim' "vim-snipmate dependency
Plugin 'honza/vim-snippets' "adds a bunch of out of the box snippets
Plugin 'garbas/vim-snipmate'

"Plugin 'majutsushi/tagbar'

" SCSS Sintax
Plugin 'cakebaker/scss-syntax.vim'

" XDebug
Plugin 'joonty/vdebug'

" smarty
Plugin 'blueyed/smarty.vim'

" JSX with React
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" Polyglot
Plugin 'sheerun/vim-polyglot'

call vundle#end()            " required
filetype plugin indent on    " required by vundle
" To ignore plugin indent changes, instead use:
" "filetype plugin on

" set ts, sts and sw for html language
" autocmd FileType html setlocal ts=8 sts=8 sw=8 noexpandtab

" Options to search for
" set smarttab
" set tags=tags;
"
