# Batch Task Examples

This folder contains example task files for batch task mode, demonstrating how to create and use batch tasks.

## File Descriptions

- **[HIGH]-example-task.md** - High priority example task
- **[MEDIUM]-example-test.md** - Medium priority example task
- **[LOW]-formatting.md** - Low priority example task

## Usage

To use these example tasks, copy them to the `.ralph/tasks/` folder:

```bash
# Copy example tasks to task folder
cp docs/tasks-example/*.md .ralph/tasks/

# Execute batch tasks
bun ralph.ts --batch-tasks
```

## Creating Your Own Tasks

Create your own tasks using the format shown in these examples:

```markdown
---
priority: HIGH
title: Task Title
created_at: 2026-03-05
---

## Task Description

Detailed task description...

## Requirements

- Requirement 1
- Requirement 2
```

## More Information

See [Batch Tasks Documentation](../BATCH_TASKS.md) for more details.
