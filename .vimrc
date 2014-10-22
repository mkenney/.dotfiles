source ~/.vim/php-doc.vim 
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
nnoremap <C-P> :call PhpDocSingle()<CR> 
vnoremap <C-P> :call PhpDocRange()<CR>

" case-insensitive search
set ignorecase
" case-sensitive once I type an uppercase char...
set smartcase

" line wrapping
set wrap
set linebreak
set textwidth=0
set wrapmargin=0

set nocp
syntax on
filetype plugin indent on


" Don't remember source of this, i think it was already in my .vimrc
" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :5000 : up to 5000 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:5000,%,n~/.viminfo
 
" omnicomplete from: http://vim.wikia.com/wiki/VimTip1386
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
 
 
"###########################
"##       PHP             ##
"###########################
" The php doc plugin
" source ~/.vim/php-doc.vim
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>
 
" run file with PHP CLI (CTRL-M)
:autocmd FileType php noremap <C-M> :w!<CR>:!/usr/local/php/bin/php %<CR>
 
" PHP parser check (CTRL-L)
:autocmd FileType php noremap <C-L> :!/usr/local/php/bin/php -l %<CR>
 
" Do use the currently active spell checking for completion though!
" (I love this feature :-)
set complete+=kspell
 
" <TAB>-related options
" disable tabs
"set expandtab
"set shiftwidth=4
"set softtabstop=4
set tabstop=4
"set autoindent

" Incremental search
set incsearch

" highlt matches
set hlsearch
 
" Taken from http://peterodding.com/code/vim/profile/vimrc
" Make Vim open and close folded text as needed because I can't be bothered to
" do so myself and wouldn't use text folding at all if it wasn't automatic.
" set foldmethod=marker foldopen=all,insert foldclose=all
 
" Enable enhanced command line completion.
set wildmenu wildmode=list:full
 
" Ignore these filenames during enhanced command line completion.
set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif " binary images
set wildignore+=*.luac " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc " Python byte code
set wildignore+=*.spl " compiled spelling word lists
set wildignore+=*.sw? " Vim swap files
 
 
" Enable completion dictionaries for PHP buffers.
autocmd FileType php set complete+=k~/.vim/dict/PHP.dict
 
" PHP Autocomplete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
set ofu=syntaxcomplete#Complete
 
" You might also find this useful
" PHP Generated Code Highlights (HTML & SQL)                                              
let php_sql_query=1
let php_htmlInStrings=1
"let g:php_folding=2
"set foldmethod=syntax
"if line =~ '^\s*\(class\|function\)\s'
    

" --------------------
" Project
" --------------------
map <A-S-p> :Project<CR>
map <A-S-o> :Project<CR>:redraw<CR>/
nmap <silent> <F3> <Plug>ToggleProject
"let g:proj_window_width = 30
"let g:proj_window_increment = 150
 
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1     " exit if taglist is last window open
let Tlist_Show_One_File = 1       " Only show tags for current buffer
let Tlist_Enable_Fold_Column = 0  " no fold column (only showing one file)
let tlist_sql_settings = 'sql;P:package;t:table'
let tlist_ant_settings = 'ant;p:Project;r:Property;t:Target'
 
" auto change directory from:
" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | lcd %:p:h | endif
 
" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
 au!
 autocmd BufReadPost *
 \ if expand("<afile>:p:h") !=? $TEMP |
 \ if line("'\"") > 1 && line("'\"") <= line("$") |
 \ let JumpCursorOnEdit_foo = line("'\"") |
 \ let b:doopenfold = 1 |
 \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
 \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
 \ let b:doopenfold = 2 |
 \ endif |
 \ exe JumpCursorOnEdit_foo |
 \ endif |
 \ endif
 " Need to postpone using "zv" until after reading the modelines.
 autocmd BufWinEnter *
 \ if exists("b:doopenfold") |
 \ exe "normal zv" |
 \ if(b:doopenfold > 1) |
 \ exe "+".1 |
 \ endif |
 \ unlet b:doopenfold |
 \ endif
augroup END
 
" PHP code sniffer
" If code sniffer is installed you can run it on current php file by running 
" :Phpcs
function! RunPhpcs()
    let l:filename=@%
    let l:phpcs_output=system('phpcs --report=csv --standard=YMC '.l:filename)
"    echo l:phpcs_output
    let l:phpcs_list=split(l:phpcs_output, "\n")
    unlet l:phpcs_list[0]
    cexpr l:phpcs_list
    cwindow
endfunction
 
set errorformat+=\"%f\"\\,%l\\,%c\\,%t%*[a-zA-Z]\\,\"%m\"
command! Phpcs execute RunPhpcs()

" Don't visually wrap lines
set nowrap

" Trim trailing spaces
autocmd BufWritePre *.php :%s/\s\+$//e
autocmd BufWritePre *.pl :%s/\s\+$//e
autocmd BufWritePre *.pm :%s/\s\+$//e
autocmd BufWritePre *.java :%s/\s\+$//e

" Status bar
set statusline=%F%m%r%h%w\ \ Line\ %l,\ Col\ %v\ \(%p%%\)
set laststatus=2

" Fonts
set gfn=Monospace\ 12
set encoding=utf8

"set shell=/bin/bash

" line numbers
set nu

"set t_Co=256

if $TERM == ('xterm')
  set t_Co=256
endif

" Syntax highlighting
hi Comment		term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=#80a0ff guibg=NONE
hi Constant		term=underline cterm=NONE ctermfg=Magenta ctermbg=NONE gui=NONE guifg=#ffa0a0 guibg=NONE
hi Special		term=bold cterm=NONE ctermfg=LightRed ctermbg=NONE gui=NONE guifg=Orange guibg=NONE
hi Identifier	term=underline cterm=bold ctermfg=Cyan ctermbg=NONE gui=NONE guifg=#40ffff guibg=NONE
hi Statement	term=bold cterm=NONE ctermfg=Yellow ctermbg=NONE gui=bold guifg=#ffff60 guibg=NONE
hi PreProc		term=underline cterm=NONE ctermfg=LightBlue ctermbg=NONE gui=NONE guifg=#ff80ff guibg=NONE
hi Type			term=underline cterm=NONE ctermfg=LightGreen ctermbg=NONE gui=bold guifg=#60ff60 guibg=NONE
hi Underlined	term=underline cterm=underline ctermfg=LightBlue gui=underline guifg=#80a0ff
hi Ignore		term=NONE cterm=NONE ctermfg=Black ctermbg=NONE gui=NONE guifg=bg guibg=NONE
hi String		term=NONE cterm=NONE ctermfg=DarkGreen ctermbg=NONE gui=NONE guifg=bg guibg=NONE  
hi Search       term=bold cterm=bold ctermfg=white ctermbg=blue
if &diff
   colorscheme darkblue
endif

set nofoldenable    " disable folding


cmap w!! w !sudo tee %

highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=21 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
"highlight! link DiffText MatchParen





