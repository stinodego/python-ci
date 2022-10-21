.DEFAULT_GOAL := help

.PHONY: fmt
fmt:  ## Run autoformatting and linting
	@pre-commit run --all-files

.PHONY: test
test:  ## Run tests
	@pytest

.PHONY: coverage
coverage:  ## Run tests and report coverage
	@coverage run -m pytest
	@coverage report

.PHONY: clean
clean:  ## Clean up caches and build artifacts
	@rm -rf .pytest_cache/
	@rm -rf .mypy_cache/
	@rm -f .coverage
	@find -type f -name '*.py[co]' -delete -or -type d -name __pycache__ -delete

.PHONY: help
help:  ## Display this help screen
	@echo -e '\033[1mAvailable commands:\033[0m'
	@grep -E '^[a-z.A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2}'
