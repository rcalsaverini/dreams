# Define commonly used paths and commands
JB_CMD := jb build
BUILD_DIR := _build/html
GHP_CMD := ghp-import -n -p -f

# Define patterns to watch for changes
WATCH_CONTENTS := 'contents/**/*.md'
WATCH_YML := '_config.yml' '_toc.yml'
WATCH_SOURCE := 'source/**/*.hs'
WATCH_IMAGES := 'images/**/*'
WATCH_REFERENCES := 'references.bib'
WATCH_MAKEFILE := 'Makefile'

# Combine all watch patterns
WATCH_PATTERNS := $(WATCH_CONTENTS) $(WATCH_YML) $(WATCH_SOURCE) $(WATCH_IMAGES) \
                  $(WATCH_REFERENCES) $(WATCH_MAKEFILE)

# Publish the Jupyter Book to GitHub Pages
.PHONY: publish
publish:
	$(JB_CMD) .
	$(GHP_CMD) $(BUILD_DIR)

# Build the Jupyter Book for preview
.PHONY: preview
preview:
	$(JB_CMD) .

# Open the built Jupyter Book in the default web browser
.PHONY: view
view:
	open $(BUILD_DIR)/index.html

# Automatically rebuild the Jupyter Book when files change
.PHONY: watch
watch:
	watchman-make -p $(WATCH_PATTERNS) -t preview
