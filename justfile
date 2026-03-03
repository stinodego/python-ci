alias t := test

# Run autoformatting and linting
fmt:
  @uv run pre-commit run --all-files

# Run tests
test:
  @uv run pytest

# Run tests and report coverage
cov:
  @uv run coverage run -m pytest
  @uv run coverage report
