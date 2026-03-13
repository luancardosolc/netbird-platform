# Project Management

## Why Trello

Trello is the execution board for this project because it gives a lightweight shared state between the operator and the AI while preserving a clear flow of work.

## AI Agent Workflow

The AI creates and updates cards for major tasks, moves active work into `Doing`, and closes completed tasks in `Done`.

## Task Flow

- `To Do`: queued work
- `Doing`: active implementation
- `Blocked`: work waiting on missing input, credentials, or external dependencies
- `Done`: completed work

## Blocked Tasks

When work cannot continue safely, the related card must move to `Blocked` with a comment describing the blocker and the exact operator action required.

## Sanity Value

The board prevents invisible work, keeps priorities explicit, and makes it easier to resume technical progress after interruptions.
