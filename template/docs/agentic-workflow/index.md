# OSS Library Agentic Workflow

This project follows an 8-agent workflow for AI-assisted open-source library development. Each agent has a specific role, trigger, and output contract, orchestrated through GitHub's native event system.

## Architecture

```
Human → Deep Research → Roadmap Planning → Workload Queue → Dev Agents
                                                              ↓
                                         Release ← QA ← Code Review
                                           ↓
                                    Project Memory → Feedback Loop
```

## Core Principles

- **Mandatory TDD**: Every functional change begins with failing tests. Implementation follows.
- **Assembly First**: MVPs focus on pure functionality (actions, data streams) before styling.

## Agents

| # | Agent | Tool | Purpose |
|---|-------|------|---------|
| 1 | [Deep Research](deep-research-agent.md) | Claude Opus | Clarify ideas through structured Q&A |
| 2 | [Roadmap Planning](roadmap-planning-agent.md) | Claude Opus/{{ default_ai_model }} | Decompose specs into milestones/epics/tasks |
| 3 | [Dev Agents](dev-agents.md) | Jules / Gemini CLI / Claude Code | Implement code changes |
| 4 | [Code Review](code-review-agent.md) | {{ default_ai_model }} | Automated review with audit trail |
| 5 | [QA](qa-agent.md) | Jules + {{ default_ai_model }} | Compatibility matrix + test analysis |
| 6 | [Release](release-agent.md) | {{ default_ai_model }} + GitHub Actions | Changelog, versioning, publish |
| 7 | [Scheduled](scheduled-agent.md) | GitHub Actions + {{ default_ai_model }} | Weekly health monitoring |
| 8 | [Community Ingestion](community-ingestion.md) | GitHub Actions + {{ default_ai_model }} | Triage external contributions |

## Cross-Agent Orchestration

See [Orchestration](orchestration.md) for the event flow, label-based state machine, and project memory.

## Cost Model

See [Cost Model](cost-model.md) for subscription-based budgeting and throughput planning.

## Label-Based State Machine

```
idea → researched → planned → approved → in-progress → review → qa-passed → released
                                  ↑                        │
                                  └── rejected (with ctx) ──┘
```

## Human Checkpoints

Every critical transition requires human approval:

1. **Plan review** — approve the GitHub Project board
2. **Cost approval** — approve estimated spend
3. **Milestone gate** — approve next phase
4. **Release approval** — approve publish
5. **Escalation** — review agent failures
