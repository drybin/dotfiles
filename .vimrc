if empty(glob('~/.vim/autoload/plug.vim'))
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/bundle')


"------  Common settings  ------
set nocompatible

"Highlighting source code
syntax on

"------  Auto-detect file type ------
filetype plugin on
filetype indent on

set encoding=utf-8
set printencoding=cp1251

"Timeout for mapping deplay
set timeoutlen=200

"------ Enable auto-comlete command in command line ------
set wildmenu

"------  Fast scrolling  ------
set ttyfast


"------  Search  ------
"Higlight search result
set hlsearch

"Incremental search
set incsearch


"Use case in search if any caps used
set smartcase

"------  History  ------
set history=1000
set undofile
set undodir=$HOME/.vim/undo/

"------  Indent  ------
set expandtab

set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set nowrap
set backspace=2
set lazyredraw
set laststatus=2

"------  Special symbols  ------
"Show whitespace, tab, etc
set list
set listchars=eol:↲,tab:→→,trail:•,nbsp:↔


"------  Leader key  ------
let mapleader="\<space>"


"------  Window Navigation  ------
"" ,hljk = Move between windows
nnoremap <Leader>h <C-w>h
nnoremap <Leader>l <C-w>l
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k

"------  Color Scheme  ------
colorscheme Tomorrow-Night

"------  Buffer Navigation  ------
"" Ctrl Left/h & Right/l cycle between buffers
noremap <silent> <C-left> :bprev<CR>
noremap <silent> <C-h> :bprev<CR>
noremap <silent> <C-right> :bnext<CR>
noremap <silent> <C-l> :bnext<CR>
" <leader>q Closes the current buffer
nnoremap <silent> <C-q> :bdelete<CR>

"------  Exit and Save  ------
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>

"------  Replace  ------
nmap S :%s//g<LEFT><LEFT>
vmap S :s//g<LEFT><LEFT>

"------  Delete spaces  ------
" <leader>T = Delete all Trailing space in file
map <Leader>t :%s/\s\+$//<CR>


"------  Deploy  ------
if !exists("g:project_directory")
    let g:project_directory = "/realty/"
endif

function! DeployFile()
    silent !clear
    silent execute  "!" . "" ."mkdir -p " . g:project_directory . substitute(substitute(expand("%:h"), '\./', '', '') , '/data/projects/realty.ngs.ru/', '', '') ." ; cp -R ". bufname("%") . " " . g:project_directory . substitute(bufname("%"), '\./', '', '')
    redraw!
endfunction

nmap <Leader>a :call DeployFile()<CR>



"------  Plugin: current-func-info  ------
"Show current function name
Plug 'tyru/current-func-info.vim'
nnoremap <Leader>f :echo cfi#format("%s", "")<CR>


"------  Plugin: airline  ------
Plug 'bling/vim-airline'
let g:airline_theme='kolor'
let g:airline#extensions#syntastic#enabled = 1


Plug 'Shougo/vimproc', "{ 'do': 'make' }
"Plug 'm2mdas/phpcomplete-extended'

"------  Plugin: PhpComplete  ------
Plug 'shawncplus/phpcomplete.vim'
let g:phpcomplete_relax_static_constraint = 1
let g:phpcomplete_complete_for_unknown_classes = 1
"let g:phpcomplete_search_tags_for_variables = 1
"let g:phpcomplete_parse_docblock_comments = 1
"let g:phpcomplete_cache_taglists = 1
let g:phpcomplete_enhance_jump_to_definition = 1
let g:phpcomplete_add_class_extensions = ['date_time', 'curl', 'memcache', 'memcached', 'pdo', 'reflection', 'sphinx']
let g:phpcomplete_add_function_extensions = ['date_time', 'curl', 'posix_regex', 'exif', 'iconv', 'mysql']
let g:phpcomplete_active_constant_extensions = ['date_time', 'curl', 'exif', 'mysql', 'pcre', 'memcache', 'mysql_pdo']


"------ Tags  ------
set tags=/data/projects/realty.ngs.ru/php.tags

"------ Paste mode  ------
set pastetoggle=<F2>

"------ Copy current file path to * buffe ------
nmap <F4> :let @* = expand("%")<CR>

"------  Plugin: YouCompleteMe  ------
Plug 'Valloric/YouCompleteMe'
let g:ycm_key_list_select_completion = ['<c-n>']
let g:ycm_key_list_previous_completion = ['<c-p>']
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_register_as_syntastic_checker = 0
"let g:ycm_allow_changing_updatetime = 0
let g:ycm_add_preview_to_completeopt = 0

let g:ycm_autoclose_preview_window_after_completion = 1

set omnifunc=phpcomplete#CompletePHP

autocmd FileType php,java,ruby,c,cpp,perl,python  
    \if &completefunc != '' | let &omnifunc=&completefunc | endif

"------ Last file position  ------
augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 120 characters.
    autocmd FileType text setlocal textwidth=120

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \ exe "normal! g`\"" |
                \ endif
augroup END


"------  Plugin: Syntastic  ------
Plug 'scrooloose/syntastic'
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpmd_exec = '~/phpmd/src/bin/phpmd'
let g:syntastic_phpmd_rules = "codesize,design,unusedcode"
let g:syntastic_php_phpcs_args="--encoding=utf-8 --report=csv --standard=NGS"

"------  Plugin: Tagbar  ------
Plug 'majutsushi/tagbar'
let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_iconchars = ['▶', '◢']
let g:tagbar_sort = 0
nmap <F8> :TagbarToggle<CR>

"------  Plugin: NerdTree  ------
Plug 'scrooloose/nerdtree'
autocmd FileType nerdtree nnoremap <buffer> <Leader>a :call GetSelected()<cr>
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <F3> :NERDTreeToggle<CR>

function! GetSelected()
    let current_file = g:NERDTreeFileNode.GetSelected()
    let current_path = current_file.path.str()
    let relative_path = substitute(current_file.path.str(), '/data/projects/realty.ngs.ru', '', '')
    echo relative_path

    silent !clear
    silent execute  "!" . "" ."mkdir -p " . g:project_directory . relative_path . " ; cp -R ". current_path . " " . g:project_directory
    redraw!
    endfunction

autocmd FileType nerdtree nnoremap <buffer> <Leader>a :call GetSelected()<cr>


"------  Plugin: PhpDoc  ------
Plug 'mikehaertl/pdv-standalone'
nnoremap <C-K> :call PhpDocSingle()<CR>
vnoremap <C-K> :call PhpDocRange()<CR>

"------  Plugin: fugitive  ------
Plug 'tpope/vim-fugitive'

"------  Plugin: Unite  ------
Plug 'Shougo/unite.vim'
Plug 'yuku-t/unite-git'
Plug 'epmatsw/ag.vim'

let g:unite_source_history_yank_enable = 1
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '-i --line-numbers --nocolor --nogroup --hidden'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200

nmap <C-f> :Ag <c-r>=expand("<cword>")<cr><cr>
nmap <C-n> :Unite -buffer-name=files -start-insert buffer file file_rec/async<cr>
nnoremap <space>/ :Ag

let g:unite_source_menu_menus = {}
                let g:unite_source_menu_menus.search = {
                      \     'description' : 'Search Operations',
                      \ }
                let g:unite_source_menu_menus.search.candidates = {
                      \   'Search in project'      : 'Unite grep:.',
                      \   'Search in current file'      : 'Unite grep:%',
                      \   'Git modified'      : 'Unite -buffer-name=files -start-insert git_modified',
                      \   'Git untracked'      : 'Unite -buffer-name=files -start-insert git_untracked',
                      \ }
                function g:unite_source_menu_menus.search.map(key, value)
                  return {
                      \       'word' : a:key, 'kind' : 'command',
                      \       'action__command' : a:value,
                      \     }
                endfunction

"------  Plugin: Vim-surround  ------
Plug 'tpope/vim-surround'

"------  Plugin: delimate  ------
"Auto close brackets, quotes, etc
Plug 'Raimondi/delimitMate'

"------  Plugin: javascript  ------
Plug 'pangloss/vim-javascript', { 'for': 'js' }

"------  Plugin: nginx-syntax  ------
Plug 'vim-scripts/nginx.vim'

"------  Plugin: php documentation  ------
Plug 'alvan/vim-php-manual', { 'for': 'php' }

"------  Plugin:  smarty syntax  ------
Plug 'vim-scripts/smarty-syntax', { 'for': 'smarty' }
 augroup filetype_smarty
        au!

        au BufRead,BufNewFile *.tpl set filetype=smarty
        au User BgBasePost hi htmlLink cterm=none
        au FileType smarty hi htmlLink cterm=none
    augroup end

call plug#end()

call unite#custom#source(
\ 'file,file/new,buffer,file_rec,file_rec/async, git_cached, git_untracked, directory',
\ 'matchers', 'matcher_fuzzy'
\ )

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_reverse'])
