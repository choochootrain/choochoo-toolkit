FINDUP := $(shell command -v findup 2> /dev/null)

.PHONY: default
default:
ifndef FINDUP
	ln -sf $(shell pwd)/findup ~/.bin/findup
endif
	ln -sf $(shell pwd)/dir_colors ~/.dir_colors
	ln -sf $(shell pwd)/zshrc ~/.zshrc
	ln -sf $(shell pwd)/zaliases ~/.zaliases
	ln -sf $(shell pwd)/zshenv ~/.zshenv
