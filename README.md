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

The Neovim config is a [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)-based
`init.lua` using the built-in `vim.pack` plugin manager (Neovim 0.12+).

On first launch, plugins, treesitter parsers, and LSP servers (via
[mason](https://github.com/mason-org/mason.nvim)) install automatically.

LSP is configured for **C/C++** (clangd), **Python** (pyright + ruff),
**Go** (gopls), and **Rust** (rust-analyzer). The required language toolchains
(go, node, rustup, tree-sitter-cli) are installed by `bootstrap.sh`.

```vim
:Lazy        " not used — this config uses vim.pack
:checkhealth " verify everything is wired up correctly
:Mason       " manage LSP servers / formatters
" update plugins:
:lua vim.pack.update()
```

The `nvim-pack-lock.json` plugin lock file is synced via mackup
(custom app `neovim-pack-lock` under `mackup-apps/`) so plugin versions stay
consistent across machines.

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


