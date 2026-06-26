#!/usr/bin/env bash
# Do not use `sudo` to run this script
#
# Usage:
#   ./bootstrap.sh                  # auto-detect platform (macOS or Linux)
#   ./bootstrap.sh macos            # force macOS path (Homebrew)
#   ./bootstrap.sh linux            # force Linux path (apt + sudo)
#   ./bootstrap.sh linux-container  # no-sudo container path (mise, user space)
#
# The `linux-container` mode is for dev containers without sudo / apt.
# It installs everything in user space via mise (https://mise.jdx.dev) and a
# git-cloned oh-my-zsh, then restores dotfiles with a pip --user mackup.

# color
GREEN='\033[0;32m'
NC='\033[0m' # No Color
RED='\033[0;31m'

# install prefix
PREFIX="/usr/local/"

# ----------------------------------------------------------------------------
# Determine mode: explicit arg wins, otherwise auto-detect by OS.
# ----------------------------------------------------------------------------
MODE="$1"
if [ -z "$MODE" ]; then
    if [ "$(uname)" == "Darwin" ]; then
        MODE="macos"
    else
        MODE="linux"
    fi
fi
printf "${GREEN}bootstrap mode: ${MODE}${NC}\n"

# ============================================================================
#  miniconda3 (macOS only; needs sudo, skipped in container mode)
# ============================================================================
CONDA_SCRIPT="conda_install.sh"
CONDA_URL=""
if [ "$MODE" == "macos" ]; then
    # macOS
    brew install wget
    if [ "$(uname -m)" == "arm64" ]; then
        # Apple Silicon
        CONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-py38_4.10.1-MacOSX-arm64.sh"
    elif [ "$(uname -m)" == "x86_64" ]; then
        # Intel
        CONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-py38_4.10.3-MacOSX-x86_64.sh"
    fi
    wget $CONDA_URL -O $CONDA_SCRIPT
    chmod +X $CONDA_SCRIPT
    sudo bash $CONDA_SCRIPT -p $PREFIX"miniconda3" -b
    rm $CONDA_SCRIPT
fi


if [ "$MODE" == "macos" ]; then
    # macOS

    # Settings
    # Install app from anywhere
    sudo spctl --master-disable

    Killall SystemUIServer
    # Accept Xcode license (needed by some CLI tools)
    sudo xcodebuild -license accept

    chmod +x osx_preference_setup.sh
    bash osx_preference_setup.sh

    # Command Tools
    # git (not Apple git)
    printf "${GREEN}git${NC}\n"
    brew install git
    # mackup
    printf "${GREEN}mackup${NC}\n"
    brew install mackup
    # neovim
    printf "${GREEN}neovim${NC}\n"
    brew install neovim
    # tmux
    printf "${GREEN}tmux${NC}\n"
    brew install tmux
    # ranger
    printf "${GREEN}ranger${NC}\n"
    brew install ranger
    brew install highlight

    # zsh shell stack
    printf "${GREEN}zsh + modern CLI stack${NC}\n"
    # zsh ships with macOS, but make sure it is present
    brew install zsh
    # prompt
    brew install starship
    # zsh plugins (sourced from brew in .zshrc)
    brew install zsh-autosuggestions zsh-syntax-highlighting
    # modern CLI replacements / helpers
    brew install eza bat zoxide fzf fd ripgrep
    # shell history (SQLite, cross-machine sync)
    brew install atuin
    # set zsh as the login shell
    echo `which zsh` | sudo tee -a /etc/shells
    chsh -s `which zsh`

    # neovim language toolchains (for LSP via the kickstart-based init.lua)
    printf "${GREEN}neovim language toolchains${NC}\n"
    # tree-sitter CLI is required to compile treesitter parsers
    brew install tree-sitter-cli
    # Go (gopls / goimports / gofumpt are installed via `go install` below)
    brew install go
    # Node.js (required by the pyright language server)
    brew install node
    # Rust toolchain (rust-analyzer / cargo / rustfmt). rustup is keg-only.
    brew install rustup
    export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
    rustup default stable
    # Go LSP/format tools (use a reachable proxy if the default is blocked)
    go env -w GOPROXY=https://goproxy.cn,direct
    go install golang.org/x/tools/gopls@latest
    go install golang.org/x/tools/cmd/goimports@latest
    go install mvdan.cc/gofumpt@latest

    # Softwares
    # OpenInTerminal
    printf "${GREEN}OpenInTerminal${NC}\n"
    brew install --cask openinterminal
    brew install --cask openinterminal-lite
    brew install --cask openineditor-lite
    # IINA
    printf "${GREEN}IINA${NC}\n"
    brew install --cask iina
    # Mos
    printf "${GREEN}Mos${NC}\n"
    brew install --cask mos
    # stats
    printf "${GREEN}stats${NC}\n"
    brew install --cask stats
    # ghostty terminal
    printf "${GREEN}ghostty${NC}\n"
    brew install --cask ghostty
    # JetBrainsMono Nerd Font (used by ghostty / starship)
    printf "${GREEN}JetBrainsMono Nerd Font${NC}\n"
    brew install --cask font-jetbrains-mono-nerd-font
    # Copy mackup config
    ln -s -f ~/GitHub/config/.mackup.cfg.mac ~/.mackup.cfg
    # Custom mackup application definitions (e.g. neovim-pack-lock)
    ln -s -n -f ~/GitHub/config/mackup-apps ~/.mackup

elif [ "$MODE" == "linux" ]; then
    # Linux (with sudo / apt)

    sudo apt install curl -y

    # mackup
    printf "${GREEN}mackup${NC}\n"
    sudo pip3 install --system mackup
    # Install neovim
    printf "${GREEN}neovim${NC}\n"
    sudo apt-get install neovim -y
    # Install tmux
    printf "${GREEN}tmux${NC}\n"
    sudo apt-get install tmux -y
    # Install ranger
    printf "${GREEN}ranger${NC}\n"
    sudo apt-get install ranger -y
    sudo apt-get install highlight -y

    # zsh shell stack
    printf "${GREEN}zsh + modern CLI stack${NC}\n"
    sudo apt-get install zsh -y
    # modern CLI replacements / helpers (names per Debian/Ubuntu)
    # note: `fd` is `fd-find` and `bat` is `batcat` on Debian/Ubuntu
    sudo apt-get install zoxide fzf fd-find bat ripgrep -y
    # eza (may require its own apt repo on older releases)
    sudo apt-get install eza -y || echo "eza not in apt; install manually if needed"
    # starship prompt
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    # atuin shell history
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    # set zsh as the login shell
    echo `which zsh` | sudo tee -a /etc/shells
    chsh -s `which zsh`

    # neovim language toolchains (for LSP via the kickstart-based init.lua)
    printf "${GREEN}neovim language toolchains${NC}\n"
    sudo apt-get install golang-go nodejs npm -y
    # tree-sitter CLI (for compiling treesitter parsers)
    sudo apt-get install tree-sitter-cli -y || cargo install tree-sitter-cli
    # Rust toolchain
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    . "$HOME/.cargo/env" 2>/dev/null || true
    # Go LSP/format tools
    go install golang.org/x/tools/gopls@latest
    go install golang.org/x/tools/cmd/goimports@latest
    go install mvdan.cc/gofumpt@latest

    # Copy mackup config
    ln -s -f ~/GitHub/config/.mackup.cfg ~/.mackup.cfg
    # Custom mackup application definitions (e.g. neovim-pack-lock)
    ln -s -n -f ~/GitHub/config/mackup-apps ~/.mackup

elif [ "$MODE" == "linux-container" ]; then
    # ------------------------------------------------------------------------
    # Linux dev container WITHOUT sudo.
    # Everything is installed in user space via mise + git + pip --user.
    # Assumes: zsh, git, curl, and python3 are already present in the image.
    # ------------------------------------------------------------------------

    # 1. Install mise (user-space tool manager) -> ~/.local/bin/mise
    printf "${GREEN}mise${NC}\n"
    if ! command -v mise >/dev/null 2>&1 && [ ! -x "$HOME/.local/bin/mise" ]; then
        curl https://mise.run | sh
    fi
    export PATH="$HOME/.local/bin:$PATH"
    MISE="$HOME/.local/bin/mise"
    [ -x "$MISE" ] || MISE="$(command -v mise)"

    # 2. Trust + install all tools declared in the synced mise config.
    #    The config is restored by mackup below, but on first run it may not be
    #    present yet, so install directly from the repo copy if needed.
    printf "${GREEN}mise tools (starship, eza, bat, fzf, fd, rg, zoxide, atuin, nvim, node, go, rust, ...)${NC}\n"
    mkdir -p "$HOME/.config/mise"
    if [ ! -e "$HOME/.config/mise/config.toml" ]; then
        cp ~/GitHub/config/Mackup/.config/mise/config.toml "$HOME/.config/mise/config.toml"
    fi
    "$MISE" trust --all 2>/dev/null || "$MISE" trust "$HOME/.config/mise/config.toml" 2>/dev/null || true
    "$MISE" install

    # 3. mackup in user space (no sudo)
    printf "${GREEN}mackup (pip --user)${NC}\n"
    python3 -m pip install --user mackup || pip3 install --user mackup
    ln -s -f ~/GitHub/config/.mackup.cfg ~/.mackup.cfg
    ln -s -n -f ~/GitHub/config/mackup-apps ~/.mackup

    # 4. Go LSP/format tools for neovim (via the mise-managed go)
    printf "${GREEN}Go LSP tools${NC}\n"
    "$MISE" exec -- go env -w GOPROXY=https://goproxy.cn,direct 2>/dev/null || true
    "$MISE" exec -- go install golang.org/x/tools/gopls@latest || true
    "$MISE" exec -- go install golang.org/x/tools/cmd/goimports@latest || true
    "$MISE" exec -- go install mvdan.cc/gofumpt@latest || true

    # 5. Auto-enter zsh on login (cannot chsh without sudo in a container).
    #    Append an exec-zsh guard to ~/.bashrc if not already present.
    if ! grep -q 'exec zsh' "$HOME/.bashrc" 2>/dev/null; then
        cat >> "$HOME/.bashrc" <<'EOF'

# Launch zsh as the interactive shell (container has no chsh/sudo)
if [ -t 1 ] && command -v zsh >/dev/null 2>&1 && [ -z "$ZSH_VERSION" ]; then
    exec zsh
fi
EOF
    fi
fi

## .tmux
# printf "${GREEN}.tmux${NC} "
# if [ -d "$HOME/.tmux" ]; then
#     printf "exists\n"
# else
#     printf "installing\n"
#     git clone https://github.com/gpakosz/.tmux.git ~/.tmux
#     ln -s -f ~/.tmux/.tmux.conf ~/
#     cp ~/.tmux/.tmux.conf.local ~/
# fi

# ============================================================================
#  Shell framework + dotfile restore (all modes)
# ============================================================================

# oh-my-zsh (install before restore so the framework dir exists)
printf "${GREEN}oh-my-zsh${NC}\n"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# In container mode there is no Homebrew, so the zsh autosuggestions /
# syntax-highlighting plugins (sourced by .zshrc from several candidate paths)
# are git-cloned into the oh-my-zsh custom plugins directory.
if [ "$MODE" == "linux-container" ]; then
    ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    [ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
        git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
            "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    [ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || \
        git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting \
            "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# On a fresh machine ~/.zshrc does not exist yet, so the oh-my-zsh installer
# generates its own default template. Remove it so `mackup restore` can create
# the symlink to our managed .zshrc without conflict.
[ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ] && rm -f "$HOME/.zshrc"

# restore (mackup will symlink .zshrc, .zprofile, starship.toml, nvim config,
# mise config, ghostty config, etc.)
if command -v mackup >/dev/null 2>&1; then
    mackup restore
else
    # container: mackup was installed with pip --user, may not be on PATH yet
    python3 -m mackup restore || ~/.local/bin/mackup restore
fi

# Neovim plugins/LSP install automatically on first launch (kickstart + vim.pack).
printf "${GREEN}Done. Launch 'nvim' once to install plugins, then start a new shell.${NC}\n"
