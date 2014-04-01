if !has('gui_running')
  finish
endif

"--- カラースキーマの設定
syntax enable
set background=dark
colorscheme Tomorrow-Night

"--- font & font size (hはwindowsのみ付ける必要あり)
set guifont=Ricty:h10.5
set guifontwide=Ricty:h10.5

"--- 画面を半透明化
autocmd GUIEnter * set transparency=170
autocmd FocusGained * set transparency=200
autocmd FocusLost * set transparency=150

"--- ツールバー非表示
set guioptions-=T

"--- ビープ音を無効にする
set visualbell t_vb=

"--- どのモードでもマウスを利用(甘えが抜けない･･･)
set mouse=a
