CONFIG_DIRS=git vim zsh skhd yabai mac-scripts nix

.PHONY: default
default:
	for dir in $(CONFIG_DIRS); do \
		$(MAKE) -C $$dir; \
	done

.PHONY: brew
brew:
	brew install \
	n \
	koekeishiya/formulae/skhd \
	koekeishiya/formulae/yabai
