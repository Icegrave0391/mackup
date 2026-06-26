# ============================================================================
#  Path / Environment
# ============================================================================
export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"
export OPENCODE_DISABLE_MODELS_FETCH=1

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# go binaries (gopls, goimports, gofumpt, etc.)
export PATH="$HOME/go/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ============================================================================
#  Platform detection (macOS=brew, Linux container=mise)
# ============================================================================
# Homebrew (macOS): set up env + rust toolchain path if present
if [ -x /opt/homebrew/bin/brew ]; then
  # rust toolchain (rustup is keg-only on homebrew)
  export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
fi

# mise (Linux container / no-sudo userspace tool manager)
# Activates language runtimes and CLI tools installed under ~/.local
if [ -x "$HOME/.local/bin/mise" ]; then
  eval "$("$HOME/.local/bin/mise" activate zsh)"
elif command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# ============================================================================
#  oh-my-zsh
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"

# starship handles the prompt, so disable the omz theme
ZSH_THEME=""

# omz plugins (only lightweight, non-duplicated ones; autosuggestions &
# syntax-highlighting are sourced separately below for faster updates)
plugins=(
  git
  sudo
  extract
  colored-man-pages
  command-not-found
)
# macos plugin only makes sense on macOS
[ "$(uname)" = "Darwin" ] && plugins+=(macos)

source "$ZSH/oh-my-zsh.sh"

# ============================================================================
#  History
# ============================================================================
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="$HOME/.zsh_history"
setopt SHARE_HISTORY          # share history across sessions
setopt HIST_IGNORE_ALL_DUPS   # remove older duplicate entries
setopt HIST_REDUCE_BLANKS     # strip superfluous blanks
setopt HIST_VERIFY            # show command before executing from history
setopt EXTENDED_HISTORY       # record timestamps

# ============================================================================
#  Zsh enhancements (autosuggestions)
# ============================================================================
# Try multiple locations: brew (macOS), oh-my-zsh custom plugin (Linux), distro paths
for _f in \
  /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  "$ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh; do
  [ -f "$_f" ] && { source "$_f"; break; }
done
unset _f

# ============================================================================
#  Tool integrations
# ============================================================================
# starship prompt
command -v starship >/dev/null && eval "$(starship init zsh)"

# zoxide (smart cd -> use `z <dir>`)
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# fzf (Ctrl-R history, Ctrl-T files, Alt-C cd)
if command -v fzf >/dev/null 2>&1; then
  # fzf 0.48+ ships shell integration via `fzf --zsh` (cross-platform)
  if fzf --zsh >/dev/null 2>&1; then
    source <(fzf --zsh)
  else
    # fallback to brew-installed integration scripts (older fzf on macOS)
    [ -f /opt/homebrew/opt/fzf/shell/completion.zsh ] \
      && source /opt/homebrew/opt/fzf/shell/completion.zsh
    [ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] \
      && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  fi
fi

# atuin (SQLite shell history, cross-machine sync) - keep up arrow native
command -v atuin >/dev/null && eval "$(atuin init zsh --disable-up-arrow)"

# ============================================================================
#  Aliases
# ============================================================================
# eza (modern ls)
if command -v eza >/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -lh --icons --group-directories-first --git'
  alias la='eza -lah --icons --group-directories-first --git'
  alias lt='eza --tree --level=2 --icons'
fi

# bat (modern cat)
if command -v bat >/dev/null; then
  alias cat='bat --paging=never'
  export BAT_THEME="ansi"
fi

# fd / ripgrep are used directly as `fd` / `rg`

# nvim
alias n='nvim'
alias vi='nvim'
alias vim='nvim'

# git shortcuts
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate -20'

# gitignore generator
function gi() { curl -sLw '\n' "https://www.toptal.com/developers/gitignore/api/$*" ; }

# ============================================================================
#  Proxy helpers
# ============================================================================
set_proxy() {
    local proxy="socks5h://192.168.30.99:3130"
    local bypass="localhost,127.0.0.1,::1,.local,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"

    export ALL_PROXY="$proxy"
    export all_proxy="$proxy"
    export HTTP_PROXY="$proxy"
    export HTTPS_PROXY="$proxy"
    export http_proxy="$proxy"
    export https_proxy="$proxy"
    export NO_PROXY="$bypass"
    export no_proxy="$bypass"

    echo "Terminal proxy enabled: $proxy"
    echo "Bypass: $bypass"
}

unset_proxy() {
    unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY all_proxy ALL_PROXY no_proxy NO_PROXY
    echo "Proxy disabled"
}

# ============================================================================
#  opencode (wrapped with its own proxy)
# ============================================================================
opencode() {
  local proxy_url='http://deepseek:<PROXY_PASSWORD>@ss.deepseek.com:3128'
  local no_proxy='localhost,127.0.0.1,::1,10.0.0.0/8,10.9,200.200,.high-flyer.cn,.high-five-ai.xyz,.deepseek.com'

  HTTP_PROXY="$proxy_url" \
  HTTPS_PROXY="$proxy_url" \
  http_proxy="$proxy_url" \
  https_proxy="$proxy_url" \
  NO_PROXY="$no_proxy" \
  no_proxy="$no_proxy" \
  command opencode "$@"
}

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# ============================================================================
#  Syntax highlighting (MUST be sourced last)
# ============================================================================
for _f in \
  /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  "$ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
  [ -f "$_f" ] && { source "$_f"; break; }
done
unset _f
