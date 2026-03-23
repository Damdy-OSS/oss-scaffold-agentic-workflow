#!/usr/bin/env bash
set -euo pipefail

echo "==> Setting up GitHub repository labels for Agentic Workflow..."

# Orchestration Labels
gh label create "idea" --color "D4C5F9" --description "Raw idea, needs research" || true
gh label create "researched" --color "C2E0C6" --description "Deep Research complete, score > 85%" || true
gh label create "planned" --color "BFD4F2" --description "Roadmap Planning complete, issues created" || true
gh label create "approved" --color "0E8A16" --description "Human approved, ready for implementation" || true
gh label create "in-progress" --color "FBCA04" --description "Dev agent working on it" || true
gh label create "review" --color "E99695" --description "PR submitted, awaiting review" || true
gh label create "qa-passed" --color "0E8A16" --description "All tests green, compat matrix clean" || true
gh label create "released" --color "5319E7" --description "Shipped in a release" || true
gh label create "needs-human" --color "D93F0B" --description "Agent escalation, human intervention needed" || true

# Sizing & Triage Labels
gh label create "size:S" --color "C5DEF5" --description "1-2 hours effort" || true
gh label create "size:M" --color "BFD4F2" --description "2-4 hours effort" || true
gh label create "size:L" --color "A2C4EA" --description "4-8 hours effort" || true
gh label create "agent:jules" --color "D4E5AE" --description "Assigned to Jules" || true
gh label create "agent:ai" --color "F9D0C4" --description "Assigned to AI" || true
gh label create "epic" --color "7057FF" --description "Parent issue with sub-issues" || true
gh label create "community" --color "BFDADC" --description "From external contributor" || true
gh label create "scheduled:auto" --color "FEF2C0" --description "Created by scheduled agent (high confidence)" || true
gh label create "scheduled:review-needed" --color "F9D0C4" --description "Needs human review" || true

echo "✓ GitHub labels configured"
