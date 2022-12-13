.PHONY: default
default:
	mkdir -p ~/.config/nvim
	ln -sf $(shell pwd)/vimrc ~/.config/nvim/init.vim

	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	vim +PlugUpgrade +PlugInstall +qall
