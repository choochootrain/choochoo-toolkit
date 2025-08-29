.PHONY: default
default:
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/nvim/lua
	ln -sf $(shell pwd)/init.lua ~/.config/nvim/init.lua
	ln -sf $(shell pwd)/plugins ~/.config/nvim/lua/plugins
	ln -sf $(shell pwd)/lazy-lock.json ~/.config/nvim/lazy-lock.json

.PHONY: old
old:
	# keep old setup around for now
	mkdir -p ~/.config/nvim-old
	ln -sf $(shell pwd)/vimrc ~/.config/nvim-old/init.vim
	curl -fLo ~/.local/share/nvim-old/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	NVIM_APPNAME=nvim-old nvim +PlugUpgrade +PlugInstall +qall
