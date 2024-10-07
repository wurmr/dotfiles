export PATH="$HOME/.local/bin:$PATH"
[ -f /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Completions
autoload -Uz compinit
compinit

if (( $+commands[kubectl] )); then
  alias k="kubectl"
  source <(kubectl completion zsh)
fi

alias l="ls"

alias c="clear"
alias lg="lazygit"
# alias t="talosctl"

zstyle ':completion:*' menu select

# Tool setup
if (( $+commands[exa] )); then
    alias ls="exa --icons"
    alias ll="exa --icons -l --git"
fi

if (( $+commands[bat] )); then
    alias cat="bat"
fi

if (( $+commands[zoxide] )); then
    eval "$(zoxide init --cmd cd zsh)"
fi

if (( $+commands[fnm] )); then
    eval "`fnm env`"
fi

if (( $+commands[thefuck] )); then
  eval $(thefuck --alias fk)
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#
export STARSHIP_CONFIG=~/.starship/starship.toml
eval "$(starship init zsh)"

if (( $+commands[tmux] )); then
  if [ -z "$TMUX" ] && [ -z "$SSH_TTY" ]
  then
    tmux attach -t TMUX || tmux new -s TMUX
  fi
fi

export EDITOR=nvim
