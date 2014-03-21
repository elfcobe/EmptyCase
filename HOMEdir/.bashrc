# less コマンド等のエラー回避
export TERM=msys
 
# lsで日本語を表示する
alias ls='ls --color=auto --show-control-chars'
alias ll='ls -l'
alias l='ls -CF'
 
# gettext用
export OUTPUT_CHARSET=UTF-8
 
# viコマンド
alias vi='vim.exe'
 
# git
alias git='git.exe'
 
# cmake
alias cmake='cmake.exe'
 
# svn
alias svn='svn.exe'
 
# perl
alias perl='/perl/perl.exe'
 
# SublimeText
alias sublime='/C/dev/"Sublime Text 3"/sublime_text.exe'
 
# gitコマンド用
source /etc/git-prompt.sh
# ロケール他
export TZ=JST-9
export LANG=ja_JP.UTF-8
export LC_ALL='C'
export TPUT_COLORS=256
export HOSTNAME=msys-bash
PS1='[\[\033[0m\]\u\[\033[00;32m\]@$HOSTNAME\[\033[0m\] \t \w\[\033[0m\]$(__git_ps1)\[\033[00m\]] \n\$ '
 
# Python virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export MSYS_HOME=/c/mingw64/msys
source /c/Python34/Scripts/virtualenvwrapper.sh

# Golang PATH
export GOROOT=/c/Go
export GOPATH=/c/gosrc
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
