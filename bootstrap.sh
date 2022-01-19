#!/usr/bin/env bash
# Do not use `sudo` to run this script
# $ bash bootstrap.sh

# color
GREEN='\033[0;32m'
NC='\033[0m' # No Color
RED='\033[0;31m'

# Install miniconda

if [ "$(uname)" == "Darwin" ]; then
    # macOS

    # Settings
    # Install App from Anywhere
    sudo spctl --master-disable
    # Remove Screenshot Shadow
    defaults write com.apple.screencapture disable-shadow -bool TRUE
    Killall SystemUIServer
    # xcodebuild to accelerate launching iTerm2
    sudo xcodebuild -license accept
    # hold key to repeat
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
    printf "${GREEN}${NC}\n"
    brew install --cask iina
    # Mos
    brew install --cask mos
    # stats
    brew install --cask stats

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
