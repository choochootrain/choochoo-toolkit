.PHONY: default
default:
	mkdir -p ~/.config/nvim/bundle
	ln -sf $(shell pwd)/vimrc ~/.config/nvim/init.vim
	ln -snf $(shell pwd)/vundle ~/.config/nvim/bundle/vundle

	mkdir -p ~/.vim/
	ln -sf ~/.config/nvim/init.vim ~/.vimrc
	ln -sf ~/.config/nvim/bundle ~/.vim/bundle

	vim +PluginInstall +qall
