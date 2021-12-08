#!/usr/bin/env bash

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

    # mackup
    printf "${GREEN}mackup${NC}\n"
    brew install mackup
    # Install neovim
    printf "${GREEN}neovim${NC}\n"
    brew install neovim
    # Install autojump
    printf "${GREEN}autojump${NC}\n"
    brew install autojump
    echo "[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh" >> ~/.zshrc
    # Install tmux
    printf "${GREEN}tmux${NC}\n"
    brew install tmux
    # fish
    printf "${GREEN}fish${NC}\n"
    brew install fish

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
    echo ". /usr/share/autojump/autojump.sh" >> ~/.zshrc
    # Install tmux
    printf "${GREEN}tmux${NC}\n"
    sudo apt-get install tmux -y
    # Install ranger
    printf "${GREEN}ranger${NC}\n"
    sudo apt-get install ranger -y
    # fish
    printf "${GREEN}fish${NC}\n"
    sudo apt-add-repository ppa:fish-shell/release-3
    sudo apt-get update
    sudo apt-get install fish -y
fi

# shell-commands
echo "source ~/.my-config/shell-commands.sh" >> ~/.bashrc

# .tmux
printf "${GREEN}.tmux${NC} "
if [ -d "$HOME/.tmux" ]; then
    printf "exists\n"
else
    printf "installing\n"
    git clone https://github.com/gpakosz/.tmux.git ~/.tmux
    ln -s -f ~/.tmux/.tmux.conf ~/
    cp ~/.tmux/.tmux.conf.local ~/
fi

# git config
git config --global user.name "Ji4n1ng"
git config --global user.email "wjnmailg@gmail.com"
git config --global core.editor "nvim"

# Install fonts: 
# https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k

# Copy mackup config
cp ./.mackup.cfg ~/.mackup.cfg

# nvim minipac
git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac

mackup restore

# oh my fish
printf "${GREEN}oh my fish${NC}\n"
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
# theme
# omf install bobthefish

