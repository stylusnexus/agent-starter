---
name: experiment
description: Use for experiment-driven development. Run a generation or process N times, measure results, compare approaches, and iterate based on data.
---

# Experiment-Driven Development

Measure first, fix targeted metric, re-measure. Don't guess at quality improvements.

## Process

1. **Define what you're measuring.** Pick a specific metric: parse success rate, output quality score, response time, error rate.
2. **Write the experiment script.** Run the target operation N times (10 is a good default), collect results.
3. **Run the baseline.** Record current performance before making changes.
4. **Make one change.** Adjust one variable (prompt, model, configuration, algorithm).
5. **Re-run the experiment.** Same script, same N, same conditions.
6. **Compare.** Did the metric improve? By how much? Any regressions in other metrics?
7. **Document.** Save results to `docs/experiments/YYYY-MM-DD-<topic>.md`.

## Example Script Pattern

```bash
#!/bin/bash
# Run generation 10 times and count successes
TOTAL=10
SUCCESS=0
FAIL=0

for i in $(seq 1 $TOTAL); do
  if your_command_here 2>/dev/null; then
    SUCCESS=$((SUCCESS + 1))
  else
    FAIL=$((FAIL + 1))
  fi
done

echo "Results: $SUCCESS/$TOTAL succeeded ($FAIL failures)"
```

## Rules

- Always run a baseline before changing anything
- Change one variable at a time. Multiple changes make results uninterpretable.
- N=10 is the minimum for meaningful results. N=30+ for statistical confidence.
- Save experiment results. Future you will want to compare.
- If your intuition says "this should be better" but the data says otherwise, trust the data.
