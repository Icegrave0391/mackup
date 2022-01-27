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
    # Remove screenshot shadow
    defaults write com.apple.screencapture disable-shadow -bool TRUE
    Killall SystemUIServer
    # To accelerate launching iTerm2
    sudo xcodebuild -license accept
    # Hold key to repeat
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

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
    # autojump
    printf "${GREEN}autojump${NC}\n"
    brew install autojump
    # tmux
    printf "${GREEN}tmux${NC}\n"
    brew install tmux
    # fish
    printf "${GREEN}fish${NC}\n"
    brew install fish
    # ranger
    printf "${GREEN}ranger${NC}\n"
    brew install ranger
    brew install highlight

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
    # iterm2
    printf "${GREEN}iterm2${NC}\n"
    brew install --cask iterm2
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
    # Install autojump
    printf "${GREEN}autojump${NC}\n"
    sudo apt-get install autojump -y
    # Install tmux
    printf "${GREEN}tmux${NC}\n"
    sudo apt-get install tmux -y
    # Install ranger
    printf "${GREEN}ranger${NC}\n"
    sudo apt-get install ranger -y
    sudo apt-get install highlight -y
    # fish
    printf "${GREEN}fish${NC}\n"
    sudo apt-add-repository ppa:fish-shell/release-3
    sudo apt-get update
    sudo apt-get install fish -y

    # Copy mackup config
    ln -s -f ~/GitHub/config/.mackup.cfg ~/.mackup.cfg
fi

# shell-commands
echo "source ~/GitHub/config/shell-commands.sh" >> ~/.bashrc

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

# restore
mackup restore

# oh my fish
printf "${GREEN}oh my fish${NC}\n"
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
# theme
# omf install bobthefish
