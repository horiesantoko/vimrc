
set nocompatible
filetype off                   " (1)
"
if has('vim_starting')
set rtp+=~/.vim/neobundle/neobundle.vim/    " (2)
call neobundle#rc()               " (3)
endif
"
NeoBundle 'https://github.com/Shougo/vimproc'
NeoBundle 'https://github.com/Shougo/neocomplcache'
NeoBundle 'https://github.com/Shougo/unite.vim'
NeoBundle 'https://github.com/Shougo/vimfiler'
NeoBundle 'https://github.com/tomasr/molokai'
NeoBundle 'https://github.com/Shougo/vimshell'
NeoBundle 'https://github.com/thinca/vim-quickrun'
NeoBundle 'https://github.com/vim-jp/vital.vim'
NeoBundle 'https://github.com/vim-jp/vimdoc-ja'
NeoBundle 'https://github.com/vim-scripts/GoogleReader.vim'
NeoBundle 'https://github.com/vim-scripts/FastLadder.vim'
NeoBundle 'https://github.com/vim-scripts/TwitVim'
NeoBundle 'https://github.com/Lokaltog/vim-powerline'
NeoBundle 'https://github.com/mattn/calendar-vim'
"
" vim-scripts repos
"Bundle 'rails.vim'
"
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
"
filetype plugin indent on     " (5)

set nowrap
set number
set clipboard+=unnamed

let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default=0


vnoremap < <gv
vnoremap > >gv
au FocusLost *memo* :w
au FocusLost *todo* :w

let g:unite_enable_start_insert=1
map <Leader>u :execute "Unite buffer file_mru directory_mru line file:" . substitute( expand("%:p:h"),"\\","/","g")<CR>
map <Leader>f :execute "VimFiler " . substitute( expand("%:p:h"),"\\","/","g")<CR>

map <Leader>d 0idone <Esc>
map <Leader>t 0itodo <Esc>

"Cygwin‚ð PATH‚É’Ç‰Á
let $PATH = $PATH.';c:\cygwin\bin\'"PATH‚É’Ç‰Á
let $CYGWIN = 'nodosfilewarning'

let twitvim_enable_perl = 1

call delete(expand('~/scratchpad.txt'))
call writefile([""], expand("~/scratchpad.txt"), "b")


"call Pl#Theme#InsertSegment('charcode', 'after', 'filetype')
