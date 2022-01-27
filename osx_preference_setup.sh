# disable the appearance delay for dock
defaults write com.apple.dock "autohide-delay" -float "0" && killall Dock
# disable the animation of showing dock
defaults write com.apple.dock "autohide-time-modifier" -int "0" && killall Dock
# set delay for repeat pressing keys
defaults write -g InitialKeyRepeat -int 13            # normal minimun is 15 (225ms)
defaults write -g KeyRepeat -float 1.5                # normal minimum is 2 (30ms)
# Hold key to repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Remove screenshot shadow
defaults write com.apple.screencapture disable-shadow -bool true