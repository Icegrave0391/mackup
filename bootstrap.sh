#!/usr/bin/env bash
# Do not use `sudo` to run this script
# $ bash bootstrap.sh

# color
GREEN='\033[0;32m'
NC='\033[0m' # No Color
RED='\033[0;31m'

# install prefix
PREFIX="/usr/local/"

# Install miniconda3 (only for macOS now)
CONDA_SCRIPT="conda_install.sh"
CONDA_URL=""
if [ "$(uname)" == "Darwin" ]; then
    # macOS
    brew install wget
    if [ "$(uname -m)" == "arm64" ]; then
        # Apple Silicon
        CONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-py38_4.10.1-MacOSX-arm64.sh"
    elif [ "$(uname -m)" == "x86_64" ]; then
        # Intel
        CONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-py38_4.10.3-MacOSX-x86_64.sh"
    fi
fi
if [ "CONDA_URL" ]; then
    wget $CONDA_URL -O $CONDA_SCRIPT
    chmod +X $CONDA_SCRIPT
    sudo bash $CONDA_SCRIPT -p $PREFIX"miniconda3" -b
    rm $CONDA_SCRIPT
else
    echo "Failed to install miniconda3."
fi


if [ "$(uname)" == "Darwin" ]; then
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

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Linux

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

    # Copy mackup config
    ln -s -f ~/GitHub/config/.mackup.cfg ~/.mackup.cfg
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

# nvim minipac
git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac

# oh-my-zsh (install before restore so the framework dir exists)
printf "${GREEN}oh-my-zsh${NC}\n"
RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# On a fresh machine ~/.zshrc does not exist yet, so the oh-my-zsh installer
# generates its own default template. Remove it so `mackup restore` can create
# the symlink to our managed .zshrc without conflict.
[ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ] && rm -f "$HOME/.zshrc"

# restore (mackup will symlink .zshrc, .zprofile, starship.toml, ghostty config, etc.)
mackup restore
