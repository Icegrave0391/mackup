# Homebrew (macOS only). Guarded so Linux machines that sync this file via
# mackup don't error with "no such file: /opt/homebrew/bin/brew".
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
  export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
  export HOMEBREW_INSTALL_FROM_API=1
  export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
  export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  # Linuxbrew (if ever installed on a Linux host)
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
