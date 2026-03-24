# oss-scaffold

A production-grade [Copier](https://copier.readthedocs.io/) template for bootstrapping open-source projects with batteries included.

## What you get

- **Python** (uv + ruff + pytest) — with Go and TypeScript support planned
- **CI/CD** — GitHub Actions and/or GitLab CI
- **Docker** — multi-stage Dockerfile + docker-compose
- **Documentation** — MkDocs Material with GitHub Pages deployment
- **AI Agentic Layer** — CLAUDE.md, GEMINI.md, JULES.md, .mcp.json, Claude slash commands
- **OSS Agentic Workflow** — full 8-agent workflow spec for AI-assisted library development
- **Release tooling** — conventional commits, semver, justfile automation
- **OSS essentials** — LICENSE, CONTRIBUTING, SECURITY, CHANGELOG, PR template

## Usage

### Create a new project

```bash
# Install copier
pip install copier

# Scaffold from this template
copier copy gh:yevheniidehtiar/oss-scaffold my-new-project

# Answer the interactive prompts, then:
cd my-new-project
just bootstrap
```

### Update existing projects when template evolves

```bash
copier update
```

## Template structure

```
oss-scaffold/
├── copier.yml          # Interactive question spec
├── README.md           # This file
└── template/           # All generated files live here
    ├── src/            # Python package source
    ├── tests/          # Test suite
    ├── docs/           # MkDocs + agentic workflow specs
    ├── scripts/        # Automation helpers
    ├── .github/        # GitHub Actions + templates
    ├── .claude/        # Claude Code slash commands
    └── ...             # Config files, Docker, justfile, AI layer
```

## OSS Agentic Workflow

This template includes a complete 8-agent workflow specification for AI-assisted open-source library development. See `docs/agentic-workflow/` in generated projects for the full spec:

1. **Deep Research Agent** — clarifies ideas through structured Q&A
2. **Roadmap Planning Agent** — decomposes specs into GitHub milestones/epics/tasks
3. **Dev Agents (tiered)** — Jules / Gemini CLI / Claude Code implementation
4. **Code Review Agent** — automated review with audit trail
5. **QA Agent** — compatibility matrix + test analysis
6. **Release Agent** — changelog, versioning, publish pipeline
7. **Scheduled Agent** — weekly health monitoring
8. **Community Signal Ingestion** — triage external contributions

## License

MIT
