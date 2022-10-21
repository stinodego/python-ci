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



## poetry

Local install (include linting dependencies for your IDE):

```shell
poetry install --with lint
```

## pytest

The best testing framework.

## GitHub Actions

For public repos, use the official hook instead: https://pre-commit.ci/

Make sure to add your core dependencies to the mypy `additional_dependencies` arg.

## Makefile

Just some nice scripts.
