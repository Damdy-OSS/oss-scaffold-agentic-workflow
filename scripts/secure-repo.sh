#!/usr/bin/env bash
# Secure repository settings using GitHub CLI (gh)
set -euo pipefail

# Get repository context
REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)
OWNER=$(echo "$REPO" | cut -d'/' -f1)
NAME=$(echo "$REPO" | cut -d'/' -f2)

echo "==> Securing repository: $REPO"

# 1. Enable Basic GitHub Features
echo "--> Enabling vulnerability alerts and security fixes..."
gh api -X PUT "/repos/$REPO/vulnerability-alerts" > /dev/null
gh api -X PUT "/repos/$REPO/automated-security-fixes" > /dev/null

echo "--> Configuring repo settings (delete-branch-on-merge, secret scanning)..."
gh repo edit "$REPO" \
    --delete-branch-on-merge \
    --enable-secret-scanning \
    --enable-secret-scanning-push-protection

# 2. Create/Update Branch Protection Ruleset
echo "--> Applying 'Main Branch Protection' ruleset..."
# We use a ruleset named "Standard Protection"
# It applies to the 'main' branch

# Check if ruleset exists to decide POST or PUT (simplification: we delete and recreate or just try POST)
# For robustness in a script, we'll try to find existing ruleset ID first
RULESET_ID=$(gh api "/repos/$REPO/rulesets" -q '.[] | select(.name=="Main Branch Protection") | .id')

RULESET_PAYLOAD=$(cat <<EOF
{
  "name": "Main Branch Protection",
  "target": "branch",
  "enforcement": "enabled",
  "conditions": {
    "ref_name": {
      "include": ["refs/heads/main"],
      "exclude": []
    }
  },
  "rules": [
    { "type": "deletion" },
    { "type": "non_fast_forward" },
    { "type": "required_signatures" },
    {
      "type": "pull_request",
      "parameters": {
        "required_approving_review_count": 1,
        "dismiss_stale_reviews_on_push": true,
        "require_code_owner_review": false,
        "require_last_push_approval": true,
        "required_review_thread_resolution": true
      }
    },
    {
      "type": "required_status_checks",
      "parameters": {
        "strict_required_status_checks_policy": true,
        "required_status_checks": [
          { "context": "Scaffolding Tests" }
        ]
      }
    }
  ]
}
EOF
)

if [ -n "$RULESET_ID" ]; then
    echo "    (Updating existing ruleset ID: $RULESET_ID)"
    gh api -X PUT "/repos/$REPO/rulesets/$RULESET_ID" --input - <<< "$RULESET_PAYLOAD" > /dev/null
else
    echo "    (Creating new ruleset)"
    gh api -X POST "/repos/$REPO/rulesets" --input - <<< "$RULESET_PAYLOAD" > /dev/null
fi

echo "✓ Repository secured successfully!"
echo "Summary of protections applied:"
echo " - Dependabot Security Updates: ENABLED"
echo " - Secret Scanning: ENABLED"
echo " - Push Protection: ENABLED"
echo " - Force Pushes: BLOCKED on main"
echo " - Deletions: BLOCKED on main"
echo " - Signed Commits: REQUIRED on main"
echo " - PR Review: REQUIRED (min 1 approval)"
echo " - Status Checks: REQUIRED ('Scaffolding Tests')"
