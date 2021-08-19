
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
Plug 'tomlion/vim-solidity'
Plug 'vimwiki/vimwiki'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'drmikehenry/vim-fontsize'
Plug 'kchmck/vim-coffee-script'
Plug 'dustractor/dazi'
" Plug 'dustractor/vimtkcolor', {'branch':'py2'}
Plug 'flazz/vim-colorschemes'
Plug 'overcache/neosolarized'
Plug 'relastle/bluewery.vim'
Plug 'rigellute/rigel'
Plug 'glepnir/oceanic-material'
Plug 'gcmt/taboo.vim'
Plug 'jsit/toast.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-repeat'
Plug 'leafgarland/typescript-vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'djjcast/mirodark'
Plug 'preservim/tagbar'
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
Plug '~/vimtkcolor'
Plug '~/verdelma'

call plug#end()
" }}}1
" {{{1 set
" set splitright
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
    let $TMP = expand("$HOMEDRIVE$HOMEPATH")."\\.vimtemp"
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
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
fun! NamelessWipeout()
    for i in range(bufnr('$'),1,-1)
        if bufname(i) == ""
            exe "bw ".i
        endif
    endfor
endfun

"contents of ~/vimfiles/fuck.ahk:
"DetectHiddenWindows, On
"WinWait, ahk_exe winpty-agent.exe
"WinHide, ahk_exe winpty-agent.exe
";purpose:hide that fucking cmd.exe window!

fun! Blender()
    let l:b = escape(expand("$BLENDER")," \\")
    let l:fuck = expand("~\\vimfiles\\fuck.ahk")
    exe printf("Havetermsay foo \"%s\"&\"%s\"",l:b,l:fuck)
endfun

fun! PyThis() abort
    let l:pdir = expand("%:p:h")
    let l:ppdir = expand("%:p:h:h")
    let l:run = "python3 %s"
    if filereadable(l:pdir."\\__init__.py")
        let l:arg = l:pdir
        if !filereadable(l:pdir."\\__main__.py")
            let l:arg = expand("%:p:h:t")
            let l:run = "cd \"".l:ppdir."\" & python3 -m %s"
        endif
    else
        let l:arg = expand("%:p")
    endif
    let l:cmd = printf(l:run,l:arg)
    exe "Havetermsay desk " . escape(l:cmd," \\")
endfun

let g:themes_i = 0
fun! Prevtheme() abort
    if !exists("g:themes")
        let g:themes = airline#util#themes('')
    endif
    let g:themes_i -= 1
    let g:airline_theme = g:themes[g:themes_i%len(g:themes)]
    AirlineRefresh
    echo g:airline_theme
endfun
fun! Nexttheme() abort
    if !exists("g:themes")
        let g:themes = airline#util#themes('')
    endif
    let g:themes_i += 1
    let g:airline_theme = g:themes[g:themes_i%len(g:themes)]
    AirlineRefresh
    echo g:airline_theme
endfun

fun! VimWikiSetup() abort
    nmap <buffer><f12> :VimwikiAll2HTML<CR>
    
endfun
fun! VWTree2(path)
py << EOF
import os,vim
path = vim.eval("a:path")
out = vim.current.buffer.append
list(map(out,list(map(lambda _:"- [ ] "+_+" [[file:"+path+_+"|"+_+"]]",os.listdir(path)))))
EOF
endfun
" {{{1 com
com! NextTheme call Nexttheme()
com! PrevTheme call Prevtheme()
com! Google !start https://google.com
com! Tall set lines=99 columns=333 foldcolumn=8 nu
com! Fontwhat set gfn=*
com! FontXHuge set gfn=Droid_Sans_Mono_Slashed_for_Pow:h36:cANSI:qDRAFT
com! FontHuge set gfn=Droid_Sans_Mono_Slashed_for_Pow:h28:cANSI:qDRAFT
com! FontNorm set gfn=Droid_Sans_Mono_Slashed_for_Pow:h20:cANSI:qDRAFT
com! FontTiny set gfn=Droid_Sans_Mono_Slashed_for_Pow:h16:cANSI:qDRAFT
com! FontXTiny set gfn=Droid_Sans_Mono_Slashed_for_Pow:h11:cANSI:qDRAFT
com! UnTall set lines=33 columns=137 foldcolumn=0 nu& | on
com! WipeoutNameless call NamelessWipeout()
com! ToggleFullScreen call libcall("c:\\Users\\dustr\\vimfiles\\gvimfullscreen_64.dll","ToggleFullScreen",0)
" {{{1 map
" toggle fullscreen

" not have what f1 does

map <esc>OP <F1>
map <F1> <nop>
inoremap <F1> <esc>
" if i miss
inoremap <C-]> <esc>
" or if i am totally lazy which i am
inoremap <C-> <esc>
" insert blank likes and stay in normal mode
nnoremap <C-> O<esc>
nnoremap <C-S-> o<esc>
" trying to encourage this habit
inoremap <C-s> <C-o>:write<CR>
nnoremap <C-s> :write<cr>
" buffer traverse
nnoremap <C-h> :bn<CR>
nnoremap <C-l> :bN<CR>
" toggles file sidebar
nnoremap <F10> :NERDTreeToggle<CR>
" toggles buffer sidebar
nnoremap <F9> :MBEToggle<CR>
" toggles tag sidebar
nnoremap <F8> :TagbarToggle<CR>
" leader stuff
nnoremap <leader>sp :call <SID>SynStack()<CR>
nnoremap <leader>/ :set hls!<CR>
nnoremap <leader>d :e .<cr>
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
fun! VisualSelectionToTextFileOnDesktop()
    let l:f = expand("~/Desktop/obs-title-text.txt")
    exe ":'<,'>w! ".l:f
endfun

vnoremap ¸ :call VisualSelectionToTextFileOnDesktop()<CR>


" {{{1 abbrev
cabbrev qq qa!
cabbrev we wa

" {{{1 au

aug KeepCursorPlace
    au!
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
aug END

aug SaveWiki
    au!
    au FocusLost *.wiki :w
aug END

aug VimReload
    au!
    au BufWritePost  $MYVIMRC nested source $MYVIMRC
aug END

aug VimWikiCompile
    au!
    au BufNew,BufReadPost  *.wiki call VimWikiSetup()
aug END

aug Bpying
    au!
    au BufNew,BufReadPost ~/bpy/*.py nmap <silent><buffer><F12> :silent! call Blender()<CR>
aug END

aug Desktoppin
    au!
    au BufNew,BufReadPost ~/Desktop/*.py nmap <buffer><F12> :call PyThis()<CR>
aug END

fun! ColorPost(csx) abort
    if a:csx == "pyte"
        hi ColorColumn guibg=#ccccee
    elseif a:csx == "seagull"
        hi ColorColumn guibg=#ccccee
    elseif a:csx == "verdelma"
        let g:airline_theme = "serene"
    elseif a:csx == "vadelma"
        hi Cursor gui=NONE guibg='#802060'
        hi ErrorMsg guibg='#CAACAA'
        hi Folded gui=bold guibg='#242424' guifg='#555555' term=NONE ctermbg=NONE ctermfg=212
        hi Function gui=bold
        hi MatchParen gui=bold guibg=NONE guifg='#00FF00' term=NONE ctermbg=NONE ctermfg=37 " [ ]
        hi StatusLineTerm guibg='#882269'
        hi StatusLineTermNC guibg='#504c50'
        let g:airline_theme = "solarized_flood"
    elseif a:csx == "neosolarized"
        hi Function gui=bold
        hi MatchParen gui=bold guibg=NONE guifg='#00FF00' term=NONE ctermbg=NONE ctermfg=37 " [ ]
        hi Cursor gui=NONE guibg='#808040'
        hi FoldColumn guibg=NONE
        let g:airline_theme = "solarized_flood"
    elseif a:csx == "neosolarized"
        hi Cursor guibg='#CC22CC' guifg='#101010'
        let g:airline_theme = "violet"
    elseif a:csx == "rigel"
        hi Function gui=bold
        hi MatchParen gui=bold guibg=NONE guifg='#00FF00' term=NONE ctermbg=NONE ctermfg=37 " [ ]
        hi Cursor gui=NONE guibg='#7000A0'
        hi FoldColumn guibg=NONE
    elseif a:csx == "oceanic_material"
        hi Cursor guibg='#CC22CC' guifg='#101010'
        let g:airline_theme = "violet"
    endif
endfun


aug Colors
    au!
    au ColorScheme * call ColorPost(expand("<amatch>"))
    au BufWritePost */colors/*.vim nested source <afile>
aug END
" }}}1

syntax on
filetype plugin indent on

" ~\verdelma\colors\verdelma.vim
"
" {{{1 gui

if has('gui_running')
    set guioptions=Ma
    if has('win32')
        nnoremap <A-F11> :ToggleFullScreen<cr>
        tnoremap <A-F11> <c-w>:ToggleFullScreen<cr>
        nnoremap <F3> :PrevTheme<cr>
        nnoremap <F4> :NextTheme<cr>
        FontNorm
        set bg=dark
        colo vadelma
        " set bg=light
        " colo Atelier_SavannaLight
        " colo papercolor
        " let g:airline_theme = "papercolor"

    else
        :
    endif
else
    " }}}1
    " terminals
    if has('win32')
        if expand("$TERM") == "cygwin"
            colo pencil
            let g:airline_theme = "dark_minimal"
            tnoremap <a-e> <c-w>:
        else
        endif
    endif
endif
" }}}1
if v:servername == "FOO"
    FontHuge
endif
