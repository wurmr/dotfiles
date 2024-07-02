# Setup fzf
# ---------
if [[ ! "$PATH" == */$HOME/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

if [[ -n $(command -v fzf) ]] ; then
  source <(fzf --zsh)
fi