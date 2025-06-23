.PHONY: default
default:
	# copy so we don't mess up git email/gpg keys when switching branches
	cp $(shell pwd)/gitconfig ~/.gitconfig
	ln -sf $(shell pwd)/gitignore_global ~/.gitignore_global
	ln -sf $(shell pwd)/gpg-agent.conf ~/.gnupg/gpg-agent.conf
