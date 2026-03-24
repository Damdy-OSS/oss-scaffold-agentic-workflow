# Migrating an Existing OSS Repo to This Template

**Audience**: maintainers of an existing OSS project who want to adopt this scaffold.

## Prerequisites

- `copier >= 9` installed (`pip install copier` or `uv tool install copier`)
- `just` installed
- Git repo in a clean state (no uncommitted changes)

## Before You Start: Protect Critical Files

Before running copier, snapshot files that contain project-specific content that copier will overwrite:

- `pyproject.toml` — your real dependencies
- `CLAUDE.md` / any AI instructions (if customized)
- `.pre-commit-config.yaml` (if customized)
- `justfile` (if customized)
- Any custom GitHub Actions workflows

```bash
cp pyproject.toml pyproject.toml.bak
cp CLAUDE.md CLAUDE.md.bak  # if exists
```

## Scenario A: First-Time Apply (No Previous Copier Scaffold)

Run from your repo root:

```bash
copier copy gh:Damdy-OSS/oss-scaffold-agentic-workflow . \
  --overwrite \
  --trust \
  --vcs-ref=develop
```

Answer the prompts (see **Template Variables Reference** below).

## Scenario B: Migrating from a Different Copier Template

If your repo has a `.copier-answers.yml` pointing to a different `_src_path`:

1. Delete or rename `.copier-answers.yml` — copier will create a fresh one
2. Run the same `copier copy` command as Scenario A

## Template Variables Reference

| Variable | Description | Example |
|---|---|---|
| `project_name` | Human-readable project name | `My Awesome Tool` |
| `project_slug` | URL/repo slug | `my-awesome-tool` |
| `project_description` | One-line description | `A fast CLI for doing X` |
| `project_url` | Homepage URL | `https://github.com/org/repo` |
| `github_org` | GitHub org or username | `myorg` |
| `author_name` | Primary author full name | `Jane Doe` |
| `author_email` | Primary author email | `jane@example.com` |
| `language` | Primary language (`python`, `golang`, `typescript`, `polyglot`) | `python` |
| `python_version` | Python version (when `language` is `python` or `polyglot`) | `3.13` |
| `go_version` | Go version (when `language` is `golang` or `polyglot`) | `1.24` |
| `node_version` | Bun version (when `language` is `typescript` or `polyglot`) | `1.2` |
| `versioning` | Version strategy (`semver` or `calver`) | `semver` |
| `initial_version` | Starting version | `0.1.0` |
| `ci_target` | CI/CD platform (`github-actions`, `gitlab-ci`, `both`) | `github-actions` |
| `license` | OSS license (`MIT` or `Apache-2.0`) | `MIT` |
| `copyright_year` | Copyright year | `2026` |
| `use_docker` | Include Dockerfile and docker-compose? | `true` |
| `use_mkdocs` | Include MkDocs documentation site? | `true` |
| `use_ai_layer` | Include AI agentic layer? | `true` |
| `default_ai_model` | Default Claude model (when `use_ai_layer=true`) | `claude-sonnet-4-20250514` |
| `mcp_slack_enabled` | Enable Slack MCP server? (when `use_ai_layer=true`) | `true` |
| `agent_style` | AI instruction verbosity (`concise` or `detailed`) | `detailed` |

## Post-Copy Merge Checklist

After copier runs, work through these in order:

### 1. pyproject.toml

The template generates a minimal `pyproject.toml`. Merge your real dependencies back:

- Copy `[project.dependencies]` from your backup
- Copy `[project.optional-dependencies]` from your backup
- Copy all `[tool.*]` sections (ruff, mypy, pytest, etc.) from your backup
- Update metadata fields (name, version, description, authors) if needed

### 2. CLAUDE.md (if use_ai_layer=true)

The template generates a generic `CLAUDE.md`. If you had a customized one, merge project-specific sections back (e.g., pointers to `CONSTITUTION.md`, custom rules, project-specific commands).

### 3. GitHub Actions Workflows

Review new workflows added under `.github/workflows/`:

| Workflow | Purpose |
|---|---|
| `qa.yml` | CI quality gate |
| `release.yml` | Automated releases |
| `scheduled.yml` | Periodic tasks |
| `community.yml` | Issue/PR automation |
| `code-review.yml` | AI code review |

Keep any custom workflows you had. Remove generated ones you don't need.

### 4. Pre-commit and justfile

Compare with your backups. Add any custom hooks or recipes you had. The template versions are generally additive.

## Validation

```bash
just lint
just test
```

## Opening a PR

After review:

```bash
git add -p          # stage selectively, review each hunk
git commit -m "chore: migrate scaffold to oss-scaffold-agentic-workflow"
gh pr create --base develop --fill
```

## What the AI Agentic Layer Adds

When `use_ai_layer=true`, the template generates:

| File | Purpose |
|---|---|
| `CLAUDE.md` | Instructions for Claude Code / Claude agents |
| `GEMINI.md` | Instructions for Gemini agents |
| `JULES.md` | Instructions for Jules (Google's AI agent) |
| `.mcp.json` | MCP server configuration (Slack, etc.) |
| `.claude/` | Claude Code slash commands and agent configs |

These files are intentionally generic — update them with project-specific context after generation.

## Troubleshooting

**copier fails with "destination not empty"**: Add the `--overwrite` flag.

**Template variables are wrong after apply**: Edit `.copier-answers.yml` and re-run `copier update --trust`.

**pyproject.toml lost all my dependencies**: Restore from `pyproject.toml.bak`.

**CI workflows conflict with existing ones**: Resolve manually — template workflows are a starting point, not a replacement for project-specific automation.
