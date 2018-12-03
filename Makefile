CONFIG_DIRS=git vim zsh

.PHONY: default
default:
	for dir in $(CONFIG_DIRS); do \
		$(MAKE) -C $$dir; \
	done
