.PHONY: help build init install test uninstall
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .' $(MAKEFILE_LIST) | sort | awk -F ':.*?## ' '{printf "%s\t\t\t%s\n",$$1,$$2}'

build: ## Build a release binary
	crystal deps
	crystal build --release bin/svn-diff-with-json.cr -o bin/svn-diff-with-json

test: ## Test
	find src spec -type f -name '*.cr' | xargs -L1 -P4 crystal tool format --check
	crystal spec
