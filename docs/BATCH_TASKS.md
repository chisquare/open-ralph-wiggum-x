# Batch Tasks Mode

## Overview

Batch Tasks Mode allows you to place multiple task documents in the `.ralph/tasks/` folder, and the program will automatically execute these tasks in priority order.

## Folder Structure

```
.ralph/
  tasks/                      # Tasks folder
    [HIGH]-task-name.md       # High priority task
    [MEDIUM]-task-name.md     # Medium priority task
    [LOW]-task-name.md        # Low priority task
    completed/                # Completed tasks
      [HIGH]-task-name.md     # Moved here after completion
```

## Task File Format

Task files use Markdown format with YAML frontmatter:

```markdown
---
priority: HIGH
title: Task Title
created_at: 2026-03-05
---

## Task Description

Detailed task description content...

## Requirements

- Requirement 1
- Requirement 2
```

### Frontmatter Fields

- **priority**: Priority level, available values: `URGENT`, `HIGH`, `MEDIUM`, `LOW`
- **title**: Task title (optional, extracted from filename if not provided)
- **created_at**: Creation time (optional, format: YYYY-MM-DD)

### File Naming Convention

Filename format: `[PRIORITY]-task-name.md`

Examples:
- `[URGENT]-fix-critical-bug.md`
- `[HIGH]-implement-login.md`
- `[MEDIUM]-update-docs.md`
- `[LOW]-cleanup-code.md`

## Usage

### 1. Create Tasks

Create task files in the `.ralph/tasks/` folder:

```bash
# Copy example tasks
cp docs/tasks-example/*.md .ralph/tasks/

# Or create new task
cat > .ralph/tasks/[HIGH]-my-task.md << 'EOF'
---
priority: HIGH
title: My Task
created_at: 2026-03-05
---

## Task Description
Please implement a certain feature...
EOF
```

### 2. Execute Batch Tasks

```bash
# Basic usage
bun ralph.ts --batch-tasks

# Specify agent
bun ralph.ts --batch-tasks --agent claude-code

# Specify model
bun ralph.ts --batch-tasks --model claude-sonnet-4

# Combine with other parameters
bun ralph.ts --batch-tasks --no-commit --verbose-tools
```

### 3. View Execution Results

After execution:
- Successful tasks are moved to `.ralph/tasks/completed/` folder
- Failed tasks remain in place with execution results appended

## Execution Order

Tasks are executed in the following order:
1. Priority: URGENT > HIGH > MEDIUM > LOW
2. Within same priority, sorted by `created_at` ascending
3. If no `created_at`, sorted by filename

## Execution Results

After each task execution, results are appended to the end of the file:

```markdown
---
## Execution Results

- **Status**: ✅ Success / ❌ Failed
- **Start Time**: 2026-03-05T10:30:00.000Z
- **End Time**: 2026-03-05T10:35:20.000Z
- **Duration**: 5 minutes 20 seconds
- **Iterations**: 1
- **Tools Used**:
  - Read: 5
  - Write: 3
  - Bash: 8
- **Output Summary**: Task executed successfully
```

## Failure Handling

If task execution fails:
1. File remains in place (not moved to completed folder)
2. Error information is appended to the end of file
3. Program continues to execute next task

## Best Practices

1. **Task Breakdown**: Split large tasks into smaller ones for easier management and retry
2. **Priority Setting**: Set priorities reasonably to ensure important tasks execute first
3. **Clear Descriptions**: Provide detailed context and requirements in task descriptions
4. **Regular Cleanup**: Periodically clean old tasks in completed folder

## Examples

### Example 1: Fix Bug

```markdown
---
priority: URGENT
title: Fix production login failure issue
created_at: 2026-03-05
---

## Problem Description

Some users cannot login in production environment, error message:
```
Error: Invalid token
```

## Reproduction Steps

1. Open login page
2. Enter username and password
3. Click login button
4. Observe error message

## Requirements

- Find root cause
- Fix bug
- Add related tests
- Update CHANGELOG
```

### Example 2: Add Feature

```markdown
---
priority: HIGH
title: Implement user avatar upload feature
created_at: 2026-03-05
---

## Task Description

Implement user avatar upload and display functionality.

## Feature Requirements

- Support JPG, PNG formats
- Image size limit 2MB
- Auto crop to square
- Generate thumbnail

## Technical Requirements

- Use TypeScript
- Add unit tests
- Add API documentation
```

## Notes

1. Batch task mode executes all tasks serially
2. After each task completes, waits 2 seconds before executing next
3. Can stop execution anytime with Ctrl+C
4. Already executed tasks (containing "Execution Results" block) will not be re-executed
