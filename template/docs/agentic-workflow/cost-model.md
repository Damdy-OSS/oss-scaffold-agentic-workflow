# Cost Model: Subscription-Based (€47/month)

## Subscriptions

| Subscription | Cost | What you get |
|---|---|---|
| Google AI Pro | €22/mo | Jules: 100 tasks/day, 15 concurrent · Gemini 3 Pro · Gemini CLI + Code Assist |
| Claude Pro | €25/mo | ~45 msgs per 5h window (~200/day) · All models · Claude Code · Projects |
| **Total** | **€47/mo** | |

## Task-Based Capacity Planning

With flat-rate subscriptions, your constraint is **throughput** (tasks/day, messages/window), not cost-per-token.

### Daily Capacity Budget

| Resource | Daily capacity | Best for |
|---|---|---|
| Jules tasks | 100/day (15 concurrent) | Implementation, refactoring, bug fixes |
| {{ default_ai_model }} msgs | ~200/day (45 per 5h) | Planning, review, QA, release decisions |
| Claude Opus msgs | ~60/day (3-5x faster consumption) | Deep research, architecture analysis |
| Gemini CLI | Higher daily limits | Quick code generation, scripts |

### Monthly Throughput (solo dev, 10h/week)

| Activity | Tool | Per week | Monthly |
|---|---|---|---|
| Planning + research | Claude Opus | 15-20 msgs | ~70 |
| Roadmap updates | {{ default_ai_model }} | 20-30 msgs | ~100 |
| Dev tasks | Jules | 30-50 tasks | ~160 |
| Code review | {{ default_ai_model }} | 25-40 msgs | ~130 |
| QA / test analysis | {{ default_ai_model }} | 15-25 msgs | ~80 |
| Release management | {{ default_ai_model }} | 10-15 msgs | ~50 |
| Ad-hoc coding | Gemini CLI | 20-40 calls | ~120 |
| **Total** | | **~170/week** | **~710/month** |

Effective cost per task at 710 tasks/month: **€0.07/task**.

## Throughput Tracking

```
Weekly capacity report:
  Jules tasks used:     42 / 700 available (6%)
  Claude msgs used:    156 / 1400 available (11%)
  Bottleneck:          None

  If bottleneck detected:
    → Claude msgs > 80%: batch questions, shorter conversations, use Gemini CLI
    → Jules tasks > 80%: combine small tasks, use Gemini CLI for trivial fixes
    → Opus msgs > 70%: defer non-critical analysis to next week
```

## Monthly Workflow Rhythm

| Week | Focus | Key activities |
|---|---|---|
| 1 | Planning | Deep Research (Claude Opus), Roadmap Planning, human review |
| 2-3 | Implementation | Dispatch Jules tasks, PR reviews, QA analysis |
| 4 | Release | Final QA, RC preparation, publish, community + next cycle |

At ~7-10% capacity utilisation, you can run **3-4 OSS projects in parallel** on the same subscriptions.

## Optimisation Tips

### Hitting Claude Pro limits?

- Batch planning into one focused session
- Use Gemini CLI for simple questions
- Start new conversations (msg 30 costs 5-10x more than msg 1)
- Use Projects to upload codebase once
- Prefer {{ default_ai_model }} over Claude Opus (3-5x less quota)

### Hitting Jules limits?

- Combine related small tasks into one
- Front-load concurrent tasks (leverage 15-concurrent limit)
- Use Gemini CLI for < 10 min tasks
