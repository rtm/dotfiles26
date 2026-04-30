# Dotfiles bare repo alias — equivalent of bash alias dot='git --git-dir=~/.dotfiles --work-tree=~'
function dot { git --git-dir="$HOME\.dotfiles" --work-tree="$HOME" @args }
