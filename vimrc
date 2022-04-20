" {{{1 Bootstrap

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

" }}}1
" {{{1 Plugins

call plug#begin()
Plug '~/dazi'
Plug '~/ritmus'
Plug '~/argloco'

Plug 'gosukiwi/vim-zen-coding'
Plug 'fladson/vim-kitty'
Plug 'preservim/vim-pencil'
Plug 'preservim/vim-lexical'
Plug 'tpope/vim-fugitive'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'djjcast/mirodark'
Plug 'drmikehenry/vim-fontsize'
Plug 'flazz/vim-colorschemes'
Plug 'gcmt/taboo.vim'
Plug 'glepnir/oceanic-material'
Plug 'jsit/toast.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-repeat'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'overcache/neosolarized'
Plug 'preservim/tagbar'
Plug 'relastle/bluewery.vim'
Plug 'rigellute/rigel'
Plug 'scrooloose/nerdtree'
Plug 'severij/vadelma'
Plug 'skywind3000/asyncrun.vim'
Plug 'tomlion/vim-solidity'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-liquid'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'
Plug 'fholgado/minibufexpl.vim'
Plug 'davidhalter/jedi-vim'
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

" }}}1
" {{{1 Options

set autoindent
set backspace=indent,eol,start
set clipboard=unnamedplus
set colorcolumn=80
set cursorline
set encoding=utf-8
set expandtab
set foldenable
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

" }}}1
" {{{1 Variables
if has('win32')
    let g:fugitive_git_executable = '"C:\\Program Files\\Git\\cmd\\git.exe"'
endif
let g:jedi#popup_on_dot = 0
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#show_call_signatures = "2"
" let g:jedi#environment_path = "venv"
" let g:jedi#goto_command = "<leader>d"
" let g:jedi#goto_assignments_command = "<leader>g"
" let g:jedi#goto_stubs_command = "<leader>s"
" let g:jedi#goto_definitions_command = ""
" let g:jedi#documentation_command = "K"
" let g:jedi#usages_command = "<leader>n"
" let g:jedi#completions_command = "<C-Space>"
" let g:jedi#rename_command = "<leader>r"
" let g:jedi#auto_initialization = 0
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#use_tabs_not_buffers = 1

let g:NERDTreeQuitOnOpen = 1
let g:airline_powerline_fonts = 1
let g:argloco_map_all = 1
let g:bufferline_echo = 0
let g:bufferline_show_bufnr = 0
let g:dazimap = '<F7>'
let g:mapleader = "\<space>"
let g:miniBufExplAutoStart = 0
let g:miniBufExplBRSplit = 1
let g:miniBufExplBuffersNeeded = 3
let g:miniBufExplShowBufNumbers = 1
let g:miniBufExplSplitToEdge = 0
let g:miniBufExplVSplit = 21
let g:proseon = 0
let g:seoul256_background=234
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:themes_i = 0
let python_highlight_all = 1
let g:ctrlp_cmd = "CtrlPBuffer"
let g:ctrlp_map = "<F2>"

" }}}1
" {{{1 Functions

" {{{2 CommitAndPush

fun CommitAndPush()
    let l:temp_cwd = getcwd()
    exe "cd ". expand("%:p:h")
    Git add %
    let l:message = input("message:\n")
    exe "Git commit -m '". l:message ."'"
    Git push
    exe "cd ". l:temp_cwd
endfun

" {{{2 Termsay [win32]

if has('win32')
    fun! Termsay(msg)
        let l:filename = expand("%:p:t")
        let l:parentdirname = expand("%:p:h:t")
        let l:servername = toupper(l:parentdirname . "_" . l:filename)
        let l:startcmdfmt = "start /B gvim.exe --servername %s"
        let l:startcmd = printf(l:startcmdfmt,l:servername)
        if match(serverlist(),l:servername) == -1
            call system(l:startcmd)
            sleep 333m
            call remote_send(l:servername,":term ++curwin ++kill=kill<cr>")
        endif
        call remote_send(l:servername,a:msg."<cr>")
    endfun
endif

" {{{2 BpySetup

fun! BpySetup(afile)
    if has('win32')
        let l:prog = expand("~/anaconda3/python.exe")
        exe printf("nmap <buffer><F12> :Termsay %s %s <cr>",l:prog,a:afile)
    else
        nnoremap <silent><buffer><F12> :silent! Ritmus<CR>
        nnoremap <silent><buffer><F11> :silent! RitmusCancel<CR>
    endif
endfun

" {{{2 DeskPySetup

fun! DeskPySetup(afile)
    if has('win32')
        let l:prog = expand("~/anaconda3/python.exe")
        exe printf("nmap <buffer><F12> :Termsay %s %s <cr>",l:prog,a:afile)
    else
        nnoremap <silent><buffer><F12> :silent! Ritmus<CR>
        nnoremap <silent><buffer><F11> :silent! RitmusCancel<CR>
    endif
endfun

" {{{2 DoAutoCommitGithubSite

fun! DoAutoCommitGithubSite()
    echom "AUTOCOMMIT"
    call system(expand("~")."\\Documents\\dustractor.github.io\\autocommit.cmd")
endfun

" {{{2 SynStack

fun! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfun


" {{{2 Prevtheme

fun! Prevtheme() abort
    if !exists("g:themes")
        let g:themes = airline#util#themes('')
    endif
    let g:themes_i -= 1
    let g:airline_theme = g:themes[g:themes_i%len(g:themes)]
    AirlineRefresh
    echo g:airline_theme
endfun

" {{{2 Nexttheme

fun! Nexttheme() abort
    if !exists("g:themes")
        let g:themes = airline#util#themes('')
    endif
    let g:themes_i += 1
    let g:airline_theme = g:themes[g:themes_i%len(g:themes)]
    AirlineRefresh
    echo g:airline_theme
endfun

" {{{2 ProseToggle

fun! ProseToggle()
    if g:proseon == 0
    let g:proseon = 1
    set textwidth=72
    set wrapmargin=8
    set spell
    set cursorcolumn
    set foldcolumn=8
else
    let g:proseon = 0
    set textwidth&
    set wrapmargin&
    set spell&
    set cursorcolumn&
    set foldcolumn&
endif
endfun

" {{{2 VimWikiSetup

fun! VimWikiSetup() abort
    nmap <buffer><f12> :VimwikiAll2HTML<CR>
    set textwidth=72
    set wrapmargin=8
endfun

" {{{2 VWTree2

fun! VWTree2(path)
py << EOF
import os,vim
path = vim.eval("a:path")
out = vim.current.buffer.append
list(map(out,list(map(lambda _:"- [ ] "+_+" [[file:"+path+_+"|"+_+"]]",os.listdir(path)))))
EOF
endfun

" {{{2 ColorPost

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

" {{{2 DoAutoCommitGithubSite

fun! DoAutoCommitGithubSite()
    echom "AUTOCOMMIT"
    call system(expand("~")."\\Documents\\dustractor.github.io\\autocommit.cmd")
endfun

" {{{2 Day

fun! Day()
    set bg=light
    colo pencil
    let g:airline_theme = "papercolor"
endfun

" {{{2 Nite

fun! Nite()
    set bg=dark
    colo molokai
    let g:airline_theme = "transparent"
    hi ColorColumn guibg=#234363
endfun

" }}}1
" {{{1 Autocommands


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

aug XresourceReload
    au!
    au BufWritePost ~/.Xresources call system("xrdb -load ~/.Xresources")
aug END

aug DeskPy
    au!
    au BufNew,BufReadPost ~/Desktop/*.py call DeskPySetup(expand("<afile>"))
aug END

aug BpyEdit
    au!
    au BufNew,BufReadPost ~/bpy/addons/*.py call BpySetup(expand("<afile>"))
aug END

" aug EditText
"     au!
"     au FileType markdown,text call pencil#init()
"                 \ | call lexical#init()
" aug END


aug PyAnyHook
    au!
    au BufWritePost ~/Documents/GitHub/randomalt/flask_app.py call CommitAndPush()
aug END
" }}}1
" {{{1 Commands


com! NextTheme call Nexttheme()
com! PrevTheme call Prevtheme()
com! Tall set lines=62 columns=239 foldcolumn=8 nu
com! Fontwhat set gfn=*
com! UnTall set lines=30 columns=119 foldcolumn=0 nu&
if has('win32')
    com! -nargs=1 Termsay call Termsay(<q-args>)
    com! Google !start https://google.com
    com! ToggleFullScreen call libcall(expand("~/vimfiles/gvimfullscreen_64.dll"),"ToggleFullScreen",0)
endif
" }}}1
" {{{1 Mappings

map <esc>OP <F1>
map <F1> <nop>
cnoremap <C-r><C-l> <C-r>=getline('.')<CR>
inoremap <F1> <esc>
inoremap <C-]> <esc>
inoremap <C-s> <C-o>:write<CR>
nnoremap <C-s> :write<cr>
nnoremap <C-h> :GoBackth<CR>
nnoremap <C-l> :GoForth<CR>
nnoremap <F10> :NERDTreeToggle<CR>
nnoremap <F9> :MBEToggle<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <leader>sp :call <SID>SynStack()<CR>
nnoremap <leader>/ :set hls!<CR>
nnoremap <leader>d :e .<cr>
nnoremap <leader>t :Tall<CR>
nnoremap <leader>T :UnTall<CR>
nnoremap <leader>; :
nnoremap <leader>C :set colorcolumn inv<CR>
nnoremap <leader>p :s/print(\(.*\))/print("\1:",\1)/<CR>
nnoremap <leader>en :call ProseToggle()<CR>
nnoremap <leader>V :e $MYVIMRC<CR>
inoremap <RightMouse> <esc>
nnoremap <MiddleMouse> :
" nnoremap <2-LeftMouse> za
" nnoremap <C-MiddleMouse> gf
" nnoremap <C-LeftMouse> gf
" nnoremap <X2Mouse> :bn<CR>
" nnoremap <X1Mouse> :bN<CR>

" }}}1
" {{{1 Abbreviations

cabbrev qq qa!
cabbrev we wa

" }}}1
" {{{1 GUI

if has('gui_running')
    set guioptions=Ma
    if has('win32')
        set renderoptions=type:directx
        set gfn=Fira_Code:h13
        nnoremap <A-F11> :ToggleFullScreen<cr>
        tnoremap <A-F11> <c-w>:ToggleFullScreen<cr>
    else
        set gfn=monofur\ for\ Powerline\ 32
        set bg=dark
        colo vadelma
        let g:airline_theme = "transparent"
        hi ColorColumn guibg=#133343
    endif
    nnoremap <F3> :PrevTheme<cr>
    nnoremap <F4> :NextTheme<cr>
    " }}}1
    " {{{1 TERM
else
    let &t_SI = "\e[6 q"
    let &t_EI = "\e[2 q"
    nnoremap <F3> :PrevTheme<cr>
    nnoremap <F4> :NextTheme<cr>

    let s:t_theme = expand("$T_THEME")
    let s:t_term = expand("$TERM")

    let g:airline_theme = "transparent"
    set bg=dark

    if s:t_theme == "vadelma"
        colo vadelma
    elseif s:t_theme == "gruvbox"
        colo gruvbox
        let g:airline_theme = "base16_gruvbox_dark_pale"
    elseif s:t_theme == "solarized"
        colo solarized8_dark_low
        let g:airline_theme = "solarized_flood"
        hi CursorLine term=NONE cterm=bold ctermbg=234
    elseif s:t_theme == "pencillight"
        set bg=light
        colo pencil
        let g:airline_theme = "papercolor"
    elseif s:t_theme == "molokai"
        colo molokai
        let g:airline_theme = "minimalist"
        hi TabLine term=NONE cterm=NONE ctermbg=234 ctermfg=25
        hi TabLineFill term=NONE cterm=NONE ctermbg=234
        hi TabLineSel term=italic cterm=italic ctermfg=27
    else
        colo pencil
    endif


endif

" }}}1
