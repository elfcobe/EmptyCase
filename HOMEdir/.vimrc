"================================================================================
set nocompatible

"--- 一旦ファイルタイプ関連を無効化する(vimrc先頭に記入)
filetype off
filetype plugin indent off



"================================================================================
"--- NeoBundleの設定
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'


"--- Bundle
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'itchyny/lightline.vim'



"--- Advanced settings for Bundle
"------------------------------------
" unite.vim
"------------------------------------
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    f [unite]

nnoremap [unite]u  :<C-u>Unite -no-split<Space>

" 全部乗せ
nnoremap <silent> [unite]a  :<C-u>UniteWithCurrentDir -no-split -buffer-name=files buffer file_mru bookmark file<CR>
" ファイル一覧
nnoremap <silent> [unite]f  :<C-u>Unite -no-split -buffer-name=files file<CR>
" バッファ一覧
nnoremap <silent> [unite]b  :<C-u>Unite -no-split buffer<CR>
" 常用セット
nnoremap <silent> [unite]u  :<C-u>Unite -no-split buffer file_mru<CR>
" 最近使用したファイル一覧
nnoremap <silent> [unite]m  :<C-u>Unite -no-split file_mru<CR>
" 現在のバッファのカレントディレクトリからファイル一覧
nnoremap <silent> [unite]d  :<C-u>UniteWithBufferDir -no-split file<CR>
" snippet一覧
nnoremap <silent> [unite]s  :<C-u>Unite snippet<CR>

" nnoremap <silent> [unite]b  :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

let g:yankring_zap_keys = ""
" from basyura/unite-rails
nnoremap <silent> [unite]rm  :<C-u>Unite -no-split rails/model<CR>
nnoremap <silent> [unite]rc  :<C-u>Unite -no-split rails/controller<CR>
nnoremap <silent> [unite]rv  :<C-u>Unite -no-split rails/view<CR>
nnoremap <silent> [unite]rl  :<C-u>Unite -no-split rails/lib<CR>
nnoremap <silent> [unite]rj  :<C-u>Unite -no-split rails/javascript<CR>
nnoremap <silent> [unite]rs  :<C-u>Unite -no-split rails/spec<CR>


autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " Overwrite settings.

  " ESCキーを2回押すと終了する
  nmap <buffer> <ESC>      <Plug>(unite_exit)
  nmap <buffer> <ESC><ESC> <Plug>(unite_exit)
  imap <buffer> jj      <Plug>(unite_insert_leave)
  nnoremap <silent><buffer> <C-k> :<C-u>call unite#mappings#do_action('preview')<CR>
  imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
  " Start insert.
  let g:unite_enable_start_insert = 1

  " ウィンドウを分割して開く
  nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('split')
  inoremap <silent> <buffer> <expr> <C-l> unite#do_action('split')

  " ウィンドウを縦に分割して開く
  nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
  inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
endfunction"}}}

let g:unite_source_file_mru_limit = 200

" unite-plugins
cnoremap UH Unite help<Enter>
cnoremap UO Unite outline<Enter>


"------------------------------------
" lightline.vim
"------------------------------------
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction



"================================================================================
"--- 編集中のファイル名を表示
set title

"--- 括弧入力時の対応する括弧を表示
set showmatch

"--- スワップファイルとバックアップファイルの出力先を指定
set backup
set swapfile
set backupdir=~/.vim/backup
set directory=~/.vim/swap

"--- モードラインを有効化
set modeline

"--- 行番号を表示
set number
set numberwidth=5

"--- text color
set t_Co=256

"--- カレント行をハイライト
set cursorline

"--- 常にステータスラインを表示
set laststatus=2

"--- タブ幅とインデント幅を設定
set tabstop=2
set autoindent
set expandtab
set shiftwidth=2

"--- OSのクリップボードを利用
set clipboard=unnamed,autoselect

"--- 10進数として数値をインクリメント
set nrformats=

"--- Vimを終了してもUndo
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/undo
endif



"================================================================================
"--- 大文字/小文字の区別なく検索する
set ignorecase

"--- 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

"--- 検索時に最後まで行ったら最初に戻る
set wrapscan

"--- ESCを2回入力で検索時のハイライトを解除
nnoremap <ESC><ESC> :nohlsearch<CR>



"================================================================================
"--- .vimrcや.gvimrcの表示と変更後保存(:w)で自動的に変更が反映されるようにする
"--- .vimrcや.gvimrcの表示
nnoremap <F5> :<C-u>edit $MYVIMRC<CR>
nnoremap <F6> :<C-u>edit $MYGVIMRC<CR>

"--- Set augroup.(変更後自動反映)
augroup MyAutoCmd
    autocmd!
augroup END

if !has('gui_running') && !(has('win32') || has('win64'))
    " .vimrcの再読込時にも色が変化するようにする
    autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC
else
    " .vimrcの再読込時にも色が変化するようにする
    autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC | 
                \if has('gui_running') | source $MYGVIMRC  
    autocmd MyAutoCmd BufWritePost $MYGVIMRC if has('gui_running') | source $MYGVIMRC
endif



"================================================================================
"--- ファイルタイプ関連を有効にする(vimrc末尾に記入)
filetype plugin indent on

NeoBundleCheck
