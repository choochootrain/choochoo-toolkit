CONFIG_DIRS=dunst git i3 vim xfce4 zsh

.PHONY: default
default:
	for dir in $(CONFIG_DIRS); do \
		$(MAKE) -C $$dir; \
	done
