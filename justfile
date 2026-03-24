# oss-scaffold justfile
set shell := ["bash", "-c"]

# List available recipes
default:
    @just --list

# ── Setup ─────────────────────────────────────────────────────

# Bootstrap development environment
bootstrap:
    uv sync --all-extras
    uv run pre-commit install
    @echo "✓ Environment ready"

# ── Quality ───────────────────────────────────────────────────

# Run linter and formatter
lint:
    uv run ruff check . --fix
    uv run ruff format .

# Alias for lint
fmt: lint

# Run scaffolding tests
test:
    uv run pytest

# Run full QA suite
qa: lint test
    @echo "✓ QA passed"

# ── Infrastructure ────────────────────────────────────────────

# Configure GitHub labels for the 8-agent workflow
setup-github repo="":
    bash scripts/setup-github.sh '{{repo}}'

# Harden repository security and branch rules
secure repo="":
    bash scripts/secure-repo.sh '{{repo}}'
