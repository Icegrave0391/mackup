### 0. Install mackup

#### macOS

For macOS, follow the [guide](https://mac.install.guide/homebrew/index.html) to install homebrew first.

- macOS: `brew install mackup`
- Linux: `pip3 install --system mackup`

### 1. Run `bootstrap.sh`

> **Note: do not use `sudo` to run this script.**

```
(optional) chmod +x bootstrap.sh
bash bootstrap.sh
```

### 2. Install [NerdFonts](https://www.nerdfonts.com/)

Recommend: JetBrainsMono Nerd Font (installed automatically by `bootstrap.sh`
on macOS via `brew install --cask font-jetbrains-mono-nerd-font`).

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

**macOS Ghostty + Zsh**    

The default shell setup is [Ghostty](https://ghostty.org/) (GPU-accelerated
terminal) + `zsh`. The shell stack is installed by `bootstrap.sh` and consists
of:

- [oh-my-zsh](https://ohmyz.sh/) — plugin/framework
- [starship](https://starship.rs/) — cross-shell prompt (`~/.config/starship.toml`)
- `zsh-autosuggestions` + `zsh-syntax-highlighting` — fish-like UX
- [zoxide](https://github.com/ajeetdsouza/zoxide) (`z`), [eza](https://github.com/eza-community/eza) (`ls`),
  [bat](https://github.com/sharkdp/bat) (`cat`), [fzf](https://github.com/junegunn/fzf),
  [fd](https://github.com/sharkdp/fd), [ripgrep](https://github.com/BurntSushi/ripgrep)
- [atuin](https://atuin.sh/) — SQLite shell history with cross-machine sync

Ghostty config lives at `~/.config/ghostty/config` and is synced via mackup.
Reload the config in-app with `Cmd+Shift+,`.


