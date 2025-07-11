.PHONY: default
default:
	mkdir -p ~/.config/nvim
	ln -sf $(shell pwd)/init.lua ~/.config/nvim/init.lua

.PHONY: old
old:
	# keep old setup around for now
	mkdir -p ~/.config/nvim-old
	ln -sf $(shell pwd)/vimrc ~/.config/nvim-old/init.vim
	curl -fLo ~/.local/share/nvim-old/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	NVIM_APPNAME=nvim-old nvim +PlugUpgrade +PlugInstall +qall
