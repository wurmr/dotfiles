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
  eval "$(pay-respects zsh --alias fk)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# if (( $+commands[herdr] )); then
#   if [ -z "$HERDR_ENV" ] && [ -z "$SSH_TTY" ]
#   then
#     herdr
#   fi
# fi

bindkey -v

export EDITOR=nvim

# herdr-core terminals run under a long-lived daemon, so on a remote machine they
# never inherit the SSH_AUTH_SOCK of the ssh session that forwarded an agent.
# Point them at a stable symlink, re-aimed at a live forwarded socket whenever it
# goes stale. Machines that never had a forwarded agent (this laptop) keep theirs.
if [[ -n $HC_TERMINAL_ID ]]; then
  _hc_agent_link=~/.ssh/agent.sock
  _hc_agent_refresh() {
    [[ -S $_hc_agent_link ]] && return 0
    local s
    for s in /tmp/ssh-*/agent.*(N=om) /tmp/auth-agent*/listener.sock(N=om); do
      [[ -O $s ]] || continue
      SSH_AUTH_SOCK=$s ssh-add -l >/dev/null 2>&1
      (( $? == 2 )) && continue   # 2 = could not reach the agent
      ln -sfn $s $_hc_agent_link && return 0
    done
    return 1
  }
  if _hc_agent_refresh || [[ -L $_hc_agent_link ]]; then
    export SSH_AUTH_SOCK=$_hc_agent_link
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _hc_agent_refresh
  fi
fi

# Machine-local overrides, not tracked in git
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
