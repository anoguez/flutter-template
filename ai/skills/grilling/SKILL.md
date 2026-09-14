---
name: grilling
description: Grill the user relentlessly about a plan, decision, or idea. Use when the user wants to stress-test their thinking, or uses any 'grill' trigger phrases.
---

Interview the user relentlessly until you reach a shared understanding. Map this as a **design tree**: every decision branches into the decisions that hang off it.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already settled: the questions you can ask _now_ without guessing at answers you haven't heard yet. Ask the whole frontier in one round, then wait for the user's answers before the next round.

## Asking a round

If an interactive question tool is available, use it for every question in the frontier. Claude Code's `AskUserQuestion` and Codex's `request_user_input` both render selectable option cards instead of plain text:

- One question per frontier item. Give it a short `header` and put the full question (multiple paragraphs are fine) in `question`.
- Offer concise options, with your recommended answer first and labeled "(Recommended)". Make the rest real alternatives, not filler — both tools add a free-text "Other" choice, so you don't need an option for every possible answer.
- Claude Code accepts 2-4 options and caps a call at 4 questions. Codex accepts 2-3 options and caps a call at 3 questions. If the frontier exceeds the available tool's limit, split it across consecutive calls (most decision-critical first) instead of dropping questions from the round.
- Even a genuinely open-ended item (a name, a free-form description) should go through the tool: give 2-3 illustrative options and let "Other" carry the free-form answer, rather than skipping the tool for that question.

If no such tool is available, fall back to plain text, formatted like so:

```
❓ **Q1** - **<question title>**: <question body, might be multiple paragraphs, including multiple choices>

➡️ <your recommended answer>

---

❓ **Q2** - **<question title>**: <question body, might be multiple paragraphs, including multiple choices>

➡️ <your recommended answer>
```

Each round the user answers reshapes the tree: settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier and ask the next round. A question whose answer depends on another question still open in this round belongs to a _later_ round, not this one.

Finding _facts_ is your job, never the user's. When a frontier question needs a fact from the environment (filesystem, tools, etc.), dispatch a sub-agent to find it; don't ask the user for anything you could look up yourself. Don't block on it: a running exploration is an unsettled prerequisite, so only the questions downstream of it wait for the sub-agent to report; ask the rest of the frontier now. The _decisions_ are the user's: put each to them and wait.

The session is done when the frontier is empty: every branch of the design tree visited, nothing left silently assumed. Do not act on it until the user confirms you have reached a shared understanding.
