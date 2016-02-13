#!/bin/bash
#.bashrc 

# disable ctrl+s, ctrl+q
stty -ixon

export PATH=~/bin:"$PATH":~/code/node/bin
export PATH="$PATH":~/.gem/ruby/2.2.0/bin
export PATH="$PATH":~/.ppmck/bin

export LS_OPTIONS="-F --color=auto"
export HISTFILESIZE=100000
export HISTIGNORE="&:ls:[bf]g:exit"
shopt -s histappend #makes bash append to history rather than overwrite
PROMPT_COMMAND='history -a' #write to history whenever the prompt is displayed
export HISTCONTROL=ignoredups

export EDITOR=nvim
export PAGER=less

# Dynamic resizing 
shopt -s checkwinsize 
shopt -s cdspell

#vi mode FTW
set -o vi

# Custom prompt 
export PS1=" \e[32;1m[\h] \e[0;37m[\$(date -Is)] \e[33m\w\e[0m\n > "

# Add color 
eval `dircolors -b` 
export LS_COLORS="$LS_COLORS:di=01;37:*.java=01;36:*.sh=01;32:*.py=01;32:*.js=01;37:*.csv=01;97:*.zip=01;31"

# Managing dotfiles with git
# idea from here: https://news.ycombinator.com/item?id=11070797
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

# User defined aliases 
alias ls='ls $LS_OPTIONS'
alias ll='ls -l' 
alias vi='nvim'
alias vim='nvim'
alias du='du -h'
alias df='df -h'
alias pss='python2 -m SimpleHTTPServer'
alias mplayer=mpv

#Locale stuff
export LC_TIME=C
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

#tmux aliases
alias tn='tmux new-session -s'
alias ta='tmux attach -t'
alias tl='tmux list-sessions'

#twitter stuff
alias tweettrim="cut -d' ' -f8-"
alias tw="t timeline -l | tweettrim"
alias shortlist="t list timeline shortlist -l | tweettrim"

# Deltos
export DELTOS_HOME=~/.deltos

alias ds='deltos search'

textify(){
  python2 -m readability.readability -u "$1" | html2text
}

alias site-sync='deltos build-site && rsync -r -e ssh ~/.deltos/site/ operator23_dampfkraft@ssh.phx.nearlyfreespeech.net:'

alias giffer="~/code/giffer/giffer.sh 320"
alias giffer640="~/code/giffer/giffer.sh 640"

# put the site up for checking
alias siteup="devd -l ~/.deltos/site -a -p 23500"

archive (){
  site="${1#http://}"
  cd /media/aether/archive/
  wget -mpck --user-agent="" -e robots=off --wait 1 "$site"
  cd -
}

kiroku() {
  read words
  if [ ! -z "$words" ] ; then echo -e "$(date -Is)\t$words" >> ~/kiroku; fi
  tail ~/kiroku
}
