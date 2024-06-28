export PATH="$PATH:~/.local/bin"

alias k="kubectl"
alias t="talosctl"

if (( $+commands[exa] )); then
    alias ls="exa --icons"
    alias ll="exa --icons -l"
fi

if (( $+commands[bat] )); then
    alias cat="bat"
fi

if (( $+commands[zoxide] )); then
    eval “$(zoxide init zsh)”
fi

#
export STARSHIP_CONFIG=~/.starship/starship.toml
eval "$(starship init zsh)"

