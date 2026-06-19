function claude-work --wraps='CLAUDE_CONFIG_DIR=$HOME/.claude-work claude' --description 'alias claude-work CLAUDE_CONFIG_DIR=$HOME/.claude-work claude'
    CLAUDE_CONFIG_DIR=$HOME/.claude-work claude $argv
end
