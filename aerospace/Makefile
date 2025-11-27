.PHONY: default
default:
	mkdir -p ~/.config/aerospace
	ln -sf $(shell pwd)/aerospace.toml ~/.config/aerospace/aerospace.toml

.PHONY: configure
configure:
	# group windows by application setting
	defaults write com.apple.dock expose-group-apps -bool true && killall Dock
	# disable displays have separate spaces
	defaults write com.apple.spaces spans-displays -bool true && killall SystemUIServer
	echo "Ensure only 1 desktop then logout to apply settings"
