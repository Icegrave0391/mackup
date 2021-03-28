### 0. Install mackup

```
brew install mackup
pip3 install --system mackup
vi ~/.mackup.cfg
```

```
[storage]
engine = file_system
path = /home/jianing/GitHub/config
[applications_to_sync]
my-config
my-mackup
ssh
neovim
vim
```
mackup restore

### 1. Install oh-my-zsh

```bash
sudo apt-get install zsh
brew install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

### 2. Install powerlevel10k

```bash
bash install-shell-plugins.sh
vi ~/.zshrc
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
```
