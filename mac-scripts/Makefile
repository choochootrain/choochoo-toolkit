.PHONY: default
default:
	mkdir -p ~/.config/mac-scripts
	ln -sf $(shell pwd)/open_iterm2.sh ~/.config/mac-scripts/open_iterm2.sh
	ln -sf $(shell pwd)/float_window.sh ~/.config/mac-scripts/float_window.sh
	ln -sf $(shell pwd)/borders.sh ~/.config/mac-scripts/borders.sh

.PHONY: ensure-brew
ensure-brew:
	./ensure-brew.sh

.PHONY: brew
brew: ensure-brew
	./brew-leaves.sh
	# casks cant be listed with the full path because idk
	brew install --cask nikitabobko/tap/aerospace

.PHONY: update-brew
update-brew:
	./update-brew.sh
