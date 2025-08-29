.PHONY: default
default:
	mkdir -p ~/.config/mac-scripts
	ln -sf $(shell pwd)/open_iterm2.sh ~/.config/mac-scripts/open_iterm2.sh
	ln -sf $(shell pwd)/float_window.sh ~/.config/mac-scripts/float_window.sh

	# could use https://github.com/odlp/bluesnooze instead
	ln -sf $(shell pwd)/sleepwatcher/sleep ~/.sleep
	ln -sf $(shell pwd)/sleepwatcher/wakeup ~/.wakeup

.PHONY: ensure-brew
ensure-brew:
	./ensure-brew.sh

.PHONY: brew
brew: ensure-brew
	./brew-leaves.sh

.PHONY: update-brew
update-brew:
	./update-brew.sh
