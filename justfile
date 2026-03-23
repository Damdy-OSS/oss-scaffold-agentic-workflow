# oss-scaffold justfile

default:
    @just --list

bootstrap:
    uv sync --all-extras
    uv run pre-commit install

lint:
    uv run ruff check . --fix
    uv run ruff format .

test:
    uv run pytest

qa: lint test
