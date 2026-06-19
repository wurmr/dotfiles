# source /etc/profile with bash
if status is-login
    exec bash -c "test -e /etc/profile && source /etc/profile;\
    exec fish"
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting

    # keychain
    # keychain --eval --quiet id_rsa | source

    alias l="ls"
    alias c="clear"

    if type -q lazygit
        alias lg="lazygit"
    end

    if type -q kubectl
        alias k="kubectl"
    end

    if type -q pcalc
        alias pcalc="pcalc --colors"
    end

    if type -q eza
        alias ls="eza --icons"
        alias ll="eza --icons -l --git"
    end

    if type -q bat
        alias cat="bat"
    end

    if type -q zoxide
        zoxide init --cmd cd fish | source
    end

    if type -q pay-respects
        pay-respects fish --alias | source
    end

    if type -q nvim
        alias n=nvim
    end

    fish_vi_key_bindings

    set fish_history ""

    # set -Ux FZF_REVERSE_ISEARCH_COMMAND history

    starship init fish | source

    # TMUX
    if type -q tmux
        and not set -q TMUX
        and not set -q SSH_TTY
        tmux attach -t TMUX || tmux new -s TMUX
    end

    if test -d ~/.local/bin
        fish_add_path ~/.local/bin
    end

    if test -d ~/.cargo/bin
        fish_add_path ~/.cargo/bin
    end

    set -gx SSH_AUTH_SOCK /run/user/(id -u)/ssh-agent.socket

    set COPILOT true
    set EDITOR nvim
    set OLLAMA_HOST 192.168.27.72
end
