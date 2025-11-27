CONFIG_DIRS=git vim zsh aerospace sketchybar mac-scripts misc

.PHONY: default
default:
	for dir in $(CONFIG_DIRS); do \
		$(MAKE) -C $$dir; \
	done

.PHONY: deps
deps:
	make -C mac-scripts brew
