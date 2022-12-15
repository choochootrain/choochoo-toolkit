CONFIG_DIRS=git vim zsh skhd yabai mac-scripts

.PHONY: default
default:
	for dir in $(CONFIG_DIRS); do \
		$(MAKE) -C $$dir; \
	done

.PHONY: brew
brew:
	brew install \
	autojump \
	direnv \
	git \
	gnupg \
	htop \
	jq \
	kind \
	koekeishiya/formulae/skhd \
	koekeishiya/formulae/yabai \
	neovim \
	the_silver_searcher
