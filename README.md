# python-cookiecutter

Example Python project with formatting / linting / etc. settings.

Local install (include linting dependencies for your IDE):

```shell
poetry install --with lint
```

CI linting:

```shell
poetry install --only pre-commit --no-root
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
