" An example for a vimrc file.
"
" Maintainer:  Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" 非GUI日本語コンソールを使っている場合の設定
if !has('gui_running') && &encoding != 'cp932' && &term == 'win32'
  set termencoding=cp932
endif

"---------------------------------------------------------------------------
" メニューファイルが存在しない場合は予め'guioptions'を調整しておく
if 1 && !filereadable($VIMRUNTIME . '/menu.vim') && has('gui_running')
  set guioptions+=M
endif

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=4
" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set list
" どの文字でタブや改行を表示するかを設定
set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
"colorscheme evening " (Windows用gvim使用時はgvimrcを編集すること)

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
"set nobackup


"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

"---------------------------------------------------------------------------
" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
if has('unix') && !has('gui_running')
  let uname = system('uname')
  if uname =~? "linux"
    set term=builtin_linux
  elseif uname =~? "freebsd"
    set term=builtin_cons25
  elseif uname =~? "Darwin"
    set term=beos-ansi
  else
    set term=builtin_xterm
  endif
  unlet uname
endif

"---------------------------------------------------------------------------
" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

"---------------------------------------------------------------------------
" プラットホーム依存の特別な設定

" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
endif


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
NeoBundle 'https://github.com/Lokaltog/vim-powerline'
NeoBundle 'https://github.com/mattn/calendar-vim'
NeoBundle 'https://github.com/vim-scripts/mayansmoke'
NeoBundle 'https://github.com/nanotech/jellybeans.vim'
NeoBundle 'https://github.com/basyura/TweetVim'
NeoBundle 'https://github.com/basyura/twibill.vim'
NeoBundle 'https://github.com/tyru/open-browser.vim'
NeoBundle 'https://github.com/mattn/webapi-vim'
NeoBundle 'https://github.com/mattn/togetter-vim'
NeoBundle 'https://github.com/koron/minimap-vim'
NeoBundle 'https://github.com/jceb/vim-orgmode'
NeoBundle 'https://github.com/fuenor/qfixhowm'
NeoBundle 'https://github.com/vim-scripts/HybridText'

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

"Git(github for windows)を PATHに追加
let $PATH = $PATH.';'.(expand('~\AppData\Local\GitHub\PortableGit_410d4c9397bbdbf295ae33a7fa27ec568849e539\bin')) "PATHに追加

"CygwinをPATHに追加
"let $PATH = $PATH.';c:\cygwin\bin\'
"let $CYGWIN = 'nodosfilewarning'

au BufNewFile,BufRead \[tweetvim\] :set wrap
let g:tweetvim_tweet_per_page = 100

call delete(expand('~/scratchpad.txt'))
call writefile([""], expand("~/scratchpad.txt"), "b")


call Pl#Theme#InsertSegment('charcode', 'after', 'filetype')

let g:neocomplcache_enable_at_startup = 1

let g:quickrun_config = {}
let g:quickrun_config.javascript = {'command' : 'node'}

let g:Powerline_mode_i = '挿入'
let g:Powerline_mode_R = '置換'
let g:Powerline_mode_n = '通常'
let g:Powerline_mode_v = 'ビジュアル'
let g:Powerline_mode_V = '行ビジュアル'
let g:Powerline_mode_cv = '矩形ビジュアル'
let g:Powerline_mode_s = '選択'
let g:Powerline_mode_S = '行選択'
let g:Powerline_mode_cs = '矩形選択'
