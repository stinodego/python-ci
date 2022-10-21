# Standard Python project CI setup

There are many ways to set up continuous integration for your Python project. This is my personal flavour of doing things. Feel free to pick-and-choose the parts that you like.

This README includes some justification and references for the choices made in this setup.

## Table of contents
- [pre-commit](#pre-commit)
- [pytest](#pytest)
- [Makefile](#makefile)
- [Poetry](#poetry)
- [GitHub Actions](#github-actions)


## pre-commit

[pre-commit](https://pre-commit.com/) is an awesome framework which many Python projects use. It allows you to select 'hooks' for various formatters and linters you want to use.

Run `pre-commit install` after setting up your local environment to enable pre-commit to run all hooks whenever you do a git commit. The commit will be cancelled if not all hooks run successfully. To commit anyway, run with `--no-verify`.

The following hooks have been selected for this CI setup:

* [pre-commit-hooks](https://github.com/pre-commit/pre-commit-hooks): Some generic hooks not specific to Python.
* [black](https://black.readthedocs.io/): The most popular autoformatter for Python. Note that the line length defaults to 88, which can be a [point of contention](https://black.readthedocs.io/en/stable/the_black_code_style/current_style.html#line-length) - adjust it in the `pyproject.toml` as desired. Don't forget to also update the `isort` and `flake8` settings to match.
* [pyupgrade](https://github.com/asottile/pyupgrade): pyupgrade makes sure the latest language features are used. The minimum supported Python version should be supplied as an argument to gain the full benefit of this tool.
* [pycln](https://github.com/hadialqattan/pycln): pycln cleans up unused imports for you. If your package has imports purely for side-effects, remove the `--all` argument here to preserve these.
* [isort](https://pycqa.github.io/isort/): isort sorts your imports and groups them in a nice way. The config specifies `force_single_line` in order to reduce merge conflicts.
* [yesqa](https://github.com/asottile/yesqa): yesqa complements `flake8` by removing unnecessary `# noqa` statements. The flake8 plugins are specified as `additional_dependencies`, as these are required to determine which `# noqa` statements are necessary.
* [flake8](https://github.com/pycqa/flake8): flake8 is a lightweight and extensible Python linter. In its most basic form, it alerts you whenever your code is not [PEP-8](https://peps.python.org/pep-0008/) compliant. The extensions selected in this repo help catch bugs, makes sure docstrings follow the specified convention, and add other niceties.
* [mypy](https://mypy.readthedocs.io/): mypy is a static type checker for Python. One of the best things you can do for your code base is add type hints and be consistent with them. In this repo, mypy is configured with [all strictness options](https://mypy.readthedocs.io/en/stable/command_line.html#cmdoption-mypy-strict) enabled. Note that for mypy to work correctly as a pre-commit hook, **you must define your main dependencies as `additional_dependencies` in the pre-commit hook**. If you have many dependencies, it may be better to remove the mypy pre-commit hook and run it alongside your tests.


## pytest

[pytest](https://docs.pytest.org/) is without question the best Python testing framework out there. Tests written in this framework are much more readable than when using Python's built-in `unittest` framework.

pytest is extensible. I advise using [`pytest-mock`](https://pytest-mock.readthedocs.io/) for your mocking needs. [`pytest-spark`](https://github.com/malexer/pytest-spark) is useful when you're working with pyspark.

Test coverage is calculated using the `coverage` package.


## Makefile

The [Makefile](https://www.gnu.org/software/make/manual/make.html) is used in this repo as a collection of small useful scripts. Most notably:

* `make fmt` runs autoformatting and linting
* `make test` runs tests
* `make coverage` runs tests and generates a coverage report

Simply run `make` to get an overview of available commands.


## Poetry

[Poetry](https://python-poetry.org/) is an amazing, modern tool for developing Python packages. See my [Poetry guide](https://github.com/stinodego/poetry-guide) for pointers on using Poetry effectively.

Note that the dependency specification for this repository contains three [dependency groups](https://python-poetry.org/docs/master/managing-dependencies/):

* `test`: Includes all testing dependencies.
* `pre-commit`: Only includes the `pre-commit` package. Having this in a separate dependency groups means we can exclude it when setting up the testing environment in the CI.
* `lint`: An optional group with linting dependencies. This can be useful to help your IDE do autoformatting or show in-line linting errors. Install these by running `poetry install --with lint`


## GitHub Actions

[GitHub Actions](https://github.com/features/actions) is GitHub's CI/CD offering. It allows you to enforce your linting checks and tests for new features, making sure your repo remains in good shape.

I included two separate workflows, one for linting and one for testing. Both workflows utilize [caching](https://github.com/actions/cache) to speed up subsequent runs, and define [concurrency](https://docs.github.com/en/actions/using-jobs/using-concurrency) to save some more compute.

For open source repos, I recommend use the [official pre-commit CI](https://pre-commit.ci/) instead of the linting workflow in this repository. It has some nice bonuses, like keeping your pre-commit hooks up-to-date automatically.

### Dependabot

The repo also includes a Dependabot configuration. This can help keep your Python dependencies and GitHub Actions up-to-date.

Because Dependabot can get a bit spammy with its pull requests, it's configured to skip patch versions and only open pull requests once a week.
