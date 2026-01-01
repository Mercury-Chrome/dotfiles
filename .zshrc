export ZSH="$HOME/.oh-my-zsh"

# --- PYWAL ---
if [[ -f ~/.cache/wal/sequences ]]; then
    cat ~/.cache/wal/sequences &
fi

# --- THÈME ---
ZSH_THEME="agnosterzak"

# --- OPTIONS ---
DEFAULT_USER=$USER
AGNOSTER_PROMPT_SEGMENTS=( dir git status )

# --- PLUGINS (Corrigé : tout sur une ligne) ---
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf)
source $ZSH/oh-my-zsh.sh

# --- ALIASES ---
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first'
alias grep='grep --color=auto'
alias c='clear'
# alias cat='bat'
