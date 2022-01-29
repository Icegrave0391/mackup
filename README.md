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

### 4. Miscs

**macOS `defaults`**    

The command `defaults` under macOS system is used for interaction with applications preferences, and we could adjust programs preference by this command. For examples and domains, please refer to [this website](https://macos-defaults.com/#%F0%9F%99%8B-what-s-a-defaults-command).    
For the domains binded to Apple's system applications, please refer to [real-world-systems](http://www.real-world-systems.com/docs/defaults.1.html).    
    
**macOS TextInput**    

This document [symbol codes](https://sites.psu.edu/symbolcodes/mac/codemac/) shows how to input some special symbols via the combination of different hotkeys.    

**macOS iTerm2**    

[iTerm2](https://iterm2.com/) is a powerful terminal emulator with amazing features to enhance the effciency to operate the command line. This article helps to [level-up your terminal game with iTerm2](https://www.typefloundry.com/1-800-iterm-bling.html).

