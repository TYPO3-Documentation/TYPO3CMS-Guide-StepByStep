.PHONY: help
help: ## Displays this list of targets with descriptions
	@echo "The following commands are available:\n"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: docs
docs: prepare-docs render-docs restore-docs ## Prepare, generate, and clean up docs.

.PHONY: render-docs
render-docs: ## Render docs base on Documentation directory
	mkdir -p Documentation-GENERATED-temp

	docker run --rm --pull always -v "$(shell pwd)":/project -t ghcr.io/typo3-documentation/render-guides:latest --config=Documentation

.PHONY: test-docs
test-docs: ## Test the documentation rendering
	mkdir -p Documentation-GENERATED-temp

	docker run --rm --pull always -v "$(shell pwd)":/project -t ghcr.io/typo3-documentation/render-guides:latest --config=Documentation --no-progress --fail-on-log

.PHONY: stage-docs
stage-docs: ## Make a backup of the Documentation directory in Documentation-BACKUP-temp
	cp -r Documentation Documentation-BACKUP-temp

.PHONY: index-files
index-files: ## Indexes all files and links in files.json
	docker run --rm -v "$(shell pwd)":/app php:8.3-cli php app/bin/index-files

.PHONY: generate-tos
generate-tos: ## Generates table of contents in all Index.md files
	docker run --rm -v "$(shell pwd)":/app php:8.3-cli php app/bin/generate-tos

.PHONY: expand-tags
expand-tags: ## Expands tags into Markdown
	docker run --rm -v "$(shell pwd)":/app php:8.3-cli php app/bin/expand-tags

.PHONY: prepare-docs ## Prepares files for rendering: Backing up, generating TOS, expanding tags, etc.
prepare-docs: stage-docs index-files generate-tos expand-tags

.PHONY: restore-docs
restore-docs: ## Restores the Documentation folder from Documentation-BACKUP-temp
	rm -rf Documentation
	cp -r Documentation-BACKUP-temp Documentation
	rm -rf Documentation-BACKUP-temp
