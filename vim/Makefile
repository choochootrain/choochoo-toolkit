.PHONY: default
default:
	ln -sf $(shell pwd)/vimrc ~/.vimrc
	mkdir -p ~/.vim/bundle
	ln -snf $(shell pwd)/vundle ~/.vim/bundle/vundle
	vim +PluginInstall +qall
