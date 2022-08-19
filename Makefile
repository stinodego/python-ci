.DEFAULT: help
help:
	@echo "make lint"
	@echo "	   run pre-commit"
	@echo "make test"
	@echo "	   run tests"
	@echo "make coverage"
	@echo "	   run tests and coverage"
	@echo "make build"
	@echo "	   build Python wheel"
	@echo "make clean"
	@echo "	   clean up pyc and caches"

.PHONY: lint
format:
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
