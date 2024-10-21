# source /etc/profile with bash
if status is-login
    exec bash -c "test -e /etc/profile && source /etc/profile;\
    exec fish"
end

if status is-interactive
  # Commands to run in interactive sessions can go here
  set -g fish_greeting

  alias l="ls"
  alias c="clear"

  if type -q lazygit
    alias lg="lazygit"
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

  if type -q thefuck
    thefuck --alias fk | source
  end

  fish_vi_key_bindings

  set fish_history ""

  starship init fish | source

  # TMUX
  if type -q tmux
  and not set -q TMUX
  and not set -q SSH_TTY
    tmux attach -t TMUX || tmux new -s TMUX    
  end
end

