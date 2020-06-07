CONFIG_DIRS=git vim zsh skhd yabai mac-scripts

.PHONY: default
default:
	for dir in $(CONFIG_DIRS); do \
		$(MAKE) -C $$dir; \
	done
