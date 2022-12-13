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
	helm \
	htop \
	jq \
	kind \
	koekeishiya/formulae/skhd \
	koekeishiya/formulae/yabai \
	kubectx \
	mysql-client \
	neovim \
	shopify/shopify/ejson \
	the_silver_searcher
