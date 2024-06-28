alias k="kubectl"
alias t="talosctl"

if (( $+commands[exa] )); then
    alias ls="exa --icons"
    alias ll="exa --icons -l"
fi

if (( $+commands[bat] )); then
    alias cat="bat"
fi

#
export STARSHIP_CONFIG=~/.starship/starship.toml
eval "$(starship init zsh)"

# Created by `pipx` on 2023-11-26 17:18:23
export PATH="$PATH:~/.local/bin"
