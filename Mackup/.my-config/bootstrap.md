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
tmux
oh-my-tmux
```
mackup restore

### 1. Install oh-my-zsh

```bash
1. zsh
sudo apt-get install zsh
brew install zsh
2. oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

### 2. Install powerlevel10k

```bash
bash install-shell-plugins.sh
vi ~/.zshrc
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
```

Install fonts: https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k

### 3. Neovim

```bash
git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac
```

```
PackStatus
PackUpdate
# if there is network problem, set proxy for git:
git config --global http.proxy 'socks5://10.27.133.113:7890'
```
