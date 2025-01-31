# Standard Python project CI setup

There are many ways to set up continuous integration for your Python project. This is my personal flavour of doing things. Feel free to pick-and-choose the parts that you like.

This README includes some justification and references for the choices made in this setup.

## Table of contents

- [pre-commit](#pre-commit)
- [pytest](#pytest)
- [Makefile](#makefile)
- [uv](#uv)
- [GitHub Actions](#github-actions)

## pre-commit

[pre-commit](https://pre-commit.com/) is an awesome framework which many Python projects use. It allows you to select 'hooks' for various formatters and linters you want to use.

Run `pre-commit install` after setting up your local environment to enable pre-commit to run all hooks whenever you do a git commit. The commit will be cancelled if not all hooks run successfully. To commit anyway, run with `--no-verify`.

The following hooks have been selected for this CI setup:

- [ruff](https://github.com/charliermarsh/ruff/): An extremely fast Python linter and formatter. Includes lints and formatting popularized by various other tools like `black`, `flake8` and `pyupgrade`, all in one tool. Replaces all linting and autoformatting tools except for `mypy`. Install the [VSCode](https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff) or [PyCharm](https://plugins.jetbrains.com/plugin/20574-ruff) extension for the best developer experience. Adjust settings in the `pyproject.toml` as desired.
- [pre-commit-hooks](https://github.com/pre-commit/pre-commit-hooks): Some auto-formatting for non-Python files. Includes a JSON formatter - a common format for config files. Remove the hook if you have no use for it.
- [language-formatters](https://github.com/macisamuele/language-formatters-pre-commit-hooks): Formatters for TOML and YAML. Useful for keeping your `pyproject.toml` and your GitHub Actions workflows clean.
- [mdformat](https://github.com/igorshubovych/markdownlint-cli): Almost all projects will include some documentation in Markdown format. This hook makes sure these files are formatted consistently.
- [typos](https://github.com/crate-ci/typos): A source code spell checker. While it does produce some false positives, it can be helpful. Address false positives by adding ignore patterns to the `typos` section of `pyproject.toml`.
- [mypy](https://mypy.readthedocs.io/): mypy is a static type checker for Python. One of the best things you can do for your code base is add type hints and be consistent with them. In this repo, mypy is configured with [all strictness options](https://mypy.readthedocs.io/en/stable/command_line.html#cmdoption-mypy-strict) enabled. Note that for mypy to work correctly as a pre-commit hook, **you must define your main dependencies as `additional_dependencies` in the pre-commit hook**. If you have many dependencies, it may be better to remove the mypy pre-commit hook and run mypy alongside your tests.

## pytest

[pytest](https://docs.pytest.org/) is without question the best Python testing framework out there. Tests written in this framework are much more readable than when using Python's built-in `unittest` framework.

pytest is extensible. I advise using [`pytest-mock`](https://pytest-mock.readthedocs.io/) for your mocking needs. [`pytest-spark`](https://github.com/malexer/pytest-spark) is useful when you're working with pyspark.

Test coverage is calculated using the `coverage` package.

## Makefile

The [Makefile](https://www.gnu.org/software/make/manual/make.html) is used in this repo as a collection of small useful scripts. Most notably:

- `make fmt` runs autoformatting and linting
- `make test` runs tests
- `make coverage` runs tests and generates a coverage report

Simply run `make` to get an overview of available commands.

## uv

[uv](https://docs.astral.sh/uv/) is an amazing, modern tool for developing Python packages.

Note that the dependency specification for this repository contains a single `dev` [dependency group](https://docs.astral.sh/uv/concepts/projects/dependencies/#dependency-groups).
With the speed that uv offers, it's not really required to further split this out into a `test` and `lint` group, for example.
Furthermore, using `dev` is the default and this offers some minor integration benefits.

## GitHub Actions

[GitHub Actions](https://github.com/features/actions) is GitHub's CI/CD offering. It allows you to enforce your linting checks and tests for new features, making sure your repo remains in good shape.

I included two separate workflows, one for linting and one for testing. Both workflows utilize [caching](https://github.com/actions/cache) to speed up subsequent runs, and define [concurrency](https://docs.github.com/en/actions/using-jobs/using-concurrency) to save some more compute.

For open source repos, I recommend use the [official pre-commit CI](https://pre-commit.ci/) instead of the linting workflow in this repository. It has some nice bonuses, like keeping your pre-commit hooks up-to-date automatically.

### Dependabot

The repo also includes a Dependabot configuration. This can help keep your Python dependencies and GitHub Actions up-to-date.

Because Dependabot can get a bit spammy with its pull requests, it's configured to skip patch versions and only open pull requests once a week.

> [!WARNING]
> Dependabot does not yet support uv.
> Support is planned for Q1 2025 and can be tracked [here](https://github.com/dependabot/dependabot-core/issues/10478).
