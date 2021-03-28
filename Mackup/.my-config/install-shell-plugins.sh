#!/usr/bin/env bash

# color
GREEN='\033[0;32m'
NC='\033[0m' # No Color
RED='\033[0;31m'

if [ "$(uname)" == "Darwin" ]; then
  # macOS
  # Install App from Anywhere
  sudo spctl --master-disable
  # Remove Screenshot Shadow
  defaults write com.apple.screencapture disable-shadow -bool TRUE
  Killall SystemUIServer
  # Install autojump
  printf "${GREEN}autojump${NC}\n"
  brew install autojump
  echo "[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh" >> ~/.zshrc
  # Install tmux
  printf "${GREEN}tmux${NC}\n"
  brew install tmux
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  # GNU/Linux
  # autojump
  printf "${GREEN}autojump${NC}\n"
  sudo apt-get install autojump
  echo ". /usr/share/autojump/autojump.sh" >> ~/.zshrc
  # Install tmux
  printf "${GREEN}tmux${NC}\n"
  sudo apt-get install tmux
#elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  # Do something under 32 bits Windows NT platform
#elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
  # Do something under 64 bits Windows NT platform
fi

# shell plugins
# powerlevel10k 
printf "${GREEN}powerlevel10k${NC} "
if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  printf "exists\n"
else
  printf "installing\n"
  git clone --depth=0 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi
# zsh-syntax-highlighting
printf "${GREEN}zsh-syntax-highlighting${NC} "
if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
  printf "exists\n"
else
  printf "installing\n"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi
# zsh-autosuggestions 
printf "${GREEN}zsh-autosuggestions${NC} "
if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
  printf "exists\n"
else
  printf "installing\n"
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

# shell-commands
echo "source ~/.my-config/shell-commands" >> ~/.zshrc

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


