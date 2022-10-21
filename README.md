# python-cookiecutter

Example Python project with formatting / linting / etc. settings.

Local install (include linting dependencies for your IDE):

```shell
poetry install --with lint
```


CI testing:

```shell
poetry install --only main,test,mypy
```


Docker steps:

First

```shell
poetry install --only main --no-root
```

Then

```shell
poetry install --only main
```

## CI

For public repos, use the official hook instead: https://pre-commit.ci/

Make sure to add your core dependencies to the mypy `additional_dependencies` arg.
