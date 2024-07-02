export PATH="$PATH:$HOME/.local/bin"
[ -f /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

alias k="kubectl"
alias t="talosctl"

# Tool setup
if (( $+commands[exa] )); then
    alias ls="exa --icons"
    alias ll="exa --icons -l"
fi

if (( $+commands[bat] )); then
    alias cat="bat"
fi

if (( $+commands[zoxide] )); then
    eval "$(zoxide init --cmd cd zsh)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#
export STARSHIP_CONFIG=~/.starship/starship.toml
eval "$(starship init zsh)"
