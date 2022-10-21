# Standard Python project CI setup

There are many ways to set up continuous integration for your Python project. This is my personal flavour of doing things. Feel free to pick-and-choose the parts that you like.

This README includes some justification and references for the choices made in this setup.

## Table of contents
- [pre-commit](#pre-commit)
- [poetry](#poetry)
- [pytest](#pytest)
- [GitHub Actions](#github-actions)
- [Makefile](#makefile)


## pre-commit

[pre-commit](https://pre-commit.com/) is an awesome tool, which is the standard many Python projects use.


Make sure to add your core dependencies to the mypy `additional_dependencies` arg.

## poetry

Local install (include linting dependencies for your IDE):

```shell
poetry install --with lint
```

## pytest

[pytest](https://docs.pytest.org/) is without question the best Python testing framework out there. Tests written in this framework are much more readable than when using Python's built-in `unittest` framework.

pytest is extensible. I advise using [`pytest-mock`](https://pytest-mock.readthedocs.io/) for your mocking needs. [`pytest-spark`](https://github.com/malexer/pytest-spark) is useful if you're working with pyspark.


## GitHub Actions

[GitHub Actions](https://github.com/features/actions) is GitHub's CI/CD offering. It allows you to enforce your linting checks and tests for new features, making sure your repo remains in good shape.

I included two separate workflows, one for linting and one for testing. Both workflows utilize [caching](https://github.com/actions/cache) to speed up subsequent runs, and define [concurrency](https://docs.github.com/en/actions/using-jobs/using-concurrency) to save some more compute.

For open source repos, I recommend use the [official pre-commit CI](https://pre-commit.ci/) instead of the linting workflow in this repository. It has some nice bonuses, like keeping your pre-commit hooks up-to-date automatically.

### Dependabot

The repo also includes a Dependabot configuration. This can help keep your Python dependencies and GitHub Actions up-to-date.

Because Dependabot can get a bit spammy with its pull requests, it's configured to skip patch versions and only open pull requests once a week.


## Makefile

The [Makefile](https://www.gnu.org/software/make/manual/make.html) is used in this repo as a collection of small useful scripts. Most notably:

* `make fmt` runs autoformatting and linting
* `make test` runs tests
* `make coverage` runs tests and generates a coverage report

Simply run `make` to get an overview of available commands.
