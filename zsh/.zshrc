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
alias n="nvim"
# alias t="talosctl"

zstyle ':completion:*' menu select

# Tool setup
if (( $+commands[eza] )); then
    alias ls="eza --icons"
    alias ll="eza --icons -l --git"
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

if (( $+commands[pay-respects] )); then
  eval $(pay-respects zsh --alias fk)
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

if (( $+commands[tmux] )); then
  if [ -z "$TMUX" ] && [ -z "$SSH_TTY" ]
  then
    tmux attach -t TMUX || tmux new -s TMUX
  fi
fi

bindkey -v

export EDITOR=nvim
