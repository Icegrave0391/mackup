### 0. Install mackup

- macOS: `brew install mackup`
- Linux: `pip3 install --system mackup`

### 1. Run `bootstrap.sh`

> **Note: do not use `sudo` to run this script.**

```
(optional) chmod +x bootstrap.sh
bash bootstrap.sh
```

### 2. Install [NerdFonts](https://www.nerdfonts.com/)

Recommend: JetBrainsMono Nerd Font

### 3. Neovim

```
PackStatus
PackUpdate
# if there is network problem, set proxy for git:
git config --global http.proxy 'socks5://10.27.133.113:7890'
```
