CONFIG_DIRS=git vim zsh skhd chunkwm mac-scripts

.PHONY: default
default:
	for dir in $(CONFIG_DIRS); do \
		$(MAKE) -C $$dir; \
	done
