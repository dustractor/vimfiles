
if has('win32')
  if empty(glob(expand('$HOMEDRIVE/$HOMEPATH/vimfiles/autoload/plug.vim')))
    exe 'silent !curl -fLo '.expand('$HOMEDRIVE/$HOMEPATH/vimfiles/autoload/plug.vim').' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
else
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif
" {{{1 plugs
call plug#begin()
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dustractor/dazi'
Plug 'flazz/vim-colorschemes'
Plug 'gcmt/taboo.vim'
Plug 'jsit/toast.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-repeat'
Plug 'leafgarland/typescript-vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'preservim/tagbar'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'scrooloose/nerdtree'
Plug 'severij/vadelma'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'weynhamz/vim-plugin-minibufexpl'
Plug '~/havetermsay'
call plug#end()
" }}}1
" {{{1 set
set cursorline
set autoindent
set backspace=indent,eol,start
set clipboard=unnamed
set colorcolumn=80
set encoding=utf-8
set expandtab
set foldenable
" set foldmarker={{{,}}}
set foldmethod=marker
set hidden
set laststatus=2
set modeline
set mouse=nvir
set mousefocus
set nowrap
set ruler
set scrolloff=5
set shiftwidth=4
set shortmess=aoOIFt
set smartindent
set smarttab
set softtabstop=4
set switchbuf=useopen,usetab
set tabpagemax=17
set tabstop=4
set wildignore+=__pycache__,\.pyc

" {{{1 let
if has('win32')
    let $TMP = expand('$HOMEDRIVE/$HOMEPATH/.vimtemp')
else
    let $TMP = expand("~/.vimtemp")
endif

let g:NERDTreeQuitOnOpen = 1
let g:airline_powerline_fonts = 1
let g:bufferline_echo = 0
let g:bufferline_show_bufnr = 0
let g:dazimap = '<F7>'
let g:mapleader = "\<space>"
let g:miniBufExplAutoStart = 1
let g:miniBufExplBRSplit = 1
let g:miniBufExplBuffersNeeded = 9
let g:miniBufExplShowBufNumbers = 1
let g:miniBufExplSplitToEdge = 0
let g:miniBufExplVSplit = 22
let g:seoul256_background=234
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let python_highlight_all = 1

" {{{1 fun
function! NamelessWipeout()
    for i in range(bufnr('$'),1,-1)
        if bufname(i) == ""
            exe "bw ".i
        endif
    endfor
endfunction

" function! HaveTermSay(termname,what)
"     echom a:termname . "<--"
"     if match(serverlist(),toupper(a:termname)) == -1
"         call system("start /min gvim.exe --servername " . a:termname)
"         sleep 777m
"         call remote_send(a:termname,":term ++curwin<cr>")
"     endif
"     call remote_send(a:termname,a:what)
"     call remote_send(a:termname,"<cr>")
" endfunction

" {{{1 com
com! Google !start https://google.com
com! Full set lines=99 columns=255
com! Tall set lines=99 columns=100 foldcolumn=8 nu
com! UnTall set lines=20 columns=80 foldcolumn=0 nu&
com! WipeoutNameless call NamelessWipeout()
" {{{1 map
" not have what f1 does
map <esc>OP <F1>
map <F1> <nop>
inoremap <F1> <esc>
" if i miss
inoremap <C-]> <esc>
" or if i am totally lazy which i am
inoremap <C-> <esc>
" insert blank likes and stay in normal mode
nnoremap <C-> o<esc>
nnoremap <C-S-> O<esc>
" trying to encourage this habit
inoremap <C-s> <C-o>:write<CR>
nnoremap <C-s> :write<cr>
" rarely use tabs but this is traverse
nnoremap <C-h> gT
nnoremap <C-l> gt
" toggles file sidebar
nnoremap <F10> :NERDTreeToggle<CR>
" toggles buffer sidebar
nnoremap <F9> :MBEToggle<CR>
" toggles tag sidebar
nnoremap <F8> :TagbarToggle<CR>
" leader stuff
nnoremap <leader>/ :set hls!<CR>
nnoremap <leader>t :Tall<CR>
nnoremap <leader>T :UnTall<CR>
nnoremap <leader>K :WipeoutNameless<CR>
nnoremap <leader>; :
nnoremap <leader>p :s/print(\(.*\))/print("\1:",\1)/<CR>
nnoremap <leader>V :e $MYVIMRC<CR>
" control r then l to insert the line in command mode
cnoremap <C-r><C-l> <C-r>=getline('.')<CR>
" double click to toggle a fold
nnoremap <2-LeftMouse> za
" yet another way to do escape
inoremap <RightMouse> <esc>
" jump to next occur
nnoremap <MiddleMouse> *
" go to file
nnoremap <C-MiddleMouse> gf
nnoremap <C-LeftMouse> gf
" back and forth buttons on the mouse to do the buffer cycle
nnoremap <X2Mouse> :bn<CR>
nnoremap <X1Mouse> :bN<CR>



" {{{1 abbrev
cabbrev qq qa!
cabbrev we wa

" {{{1 au

aug KeepCursorPlace
    au!
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
aug END

aug VimReload
    au!
    au BufWritePost  $MYVIMRC  source $MYVIMRC
aug END

fun Blender()
    let l:b = escape(expand("$BLENDER")," \\")
    exe "Havetermsay foo \"".l:b."\""
endfun

aug Bpying
    au!
    au BufNew,BufReadPost ~/bpy/*.py nmap <buffer><F12> :silent! call Blender()<CR>
aug END

fun PyThis()
    let l:p = escape("python3 " . expand("%:t")," \\")
    exe "Havetermsay desk " . l:p

endfun
aug Desktoppin
    au!
    au BufNew,BufReadPost ~/Desktop/*.py nmap <buffer><F12> :call PyThis()<CR>
aug END
" }}}1

syntax on
filetype plugin indent on

set bg=dark

" {{{1 gui

if has('gui_running')
    if has('win32')
        set guifont=Source_Code_Pro_for_Powerline:h12:cANSI:qDRAFT
    else
        set guifont=Inconsolata \18
    endif

    set guioptions=Ma
    colo vadelma
    let g:airline_theme = "seagull"

endif

" {{{1 hi
hi ErrorMsg guibg='#CAACAA'
hi MatchParen gui=NONE guibg=NONE guifg='#40F080' term=NONE ctermbg=NONE ctermfg=37 " [ ]
hi Cursor gui=NONE guibg='#802060'
hi StatusLineTerm guibg='#882269'
hi StatusLineTermNC guibg='#504c50'
" hi Folded gui=bold guibg='#242424' guifg='#555555' term=NONE ctermbg=NONE ctermfg=212
"
" MiniBufExpl Colors
hi MBENormal               guifg=#808080 guibg=#101010

hi MBEChanged              guifg=#CD5907 guibg=#100000
hi MBEVisibleNormal        guifg=#5DC2D6 guibg=#101010
hi MBEVisibleChanged       guifg=#F1266F guibg=#101010
hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=#101010
hi MBEVisibleActiveChanged guifg=#FF00FF guibg=#00FF00

