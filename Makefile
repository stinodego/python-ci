.DEFAULT: help
help:
	@echo "make lint"
	@echo "	   Run lints"
	@echo "make test"
	@echo "	   Run tests"
	@echo "make coverage"
	@echo "	   Run tests and coverage"
	@echo "make build"
	@echo "	   Build Python wheel"
	@echo "make clean"
	@echo "	   Clean up .pyc files and caches"

.PHONY: lint
lint:
	pre-commit run --all-files
	mypy

.PHONY: test
test:
	pytest

.PHONY: coverage
coverage:
	coverage run -m pytest && coverage report

.PHONY: build
build:
	poetry build --format wheel

.PHONY: clean
clean:
	@rm -rf ./.pytest_cache/
	@rm -rf ./.mypy_cache/
	@rm -rf ./.coverage
	@rm -rf ./dist/
	@find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
