# Custom Slash Commands Guide

## 📚 Overview

OpenCode supports custom slash commands, allowing you to create reusable commands to automate common tasks.

## 🗂️ File Location

### Project-level Commands (Team Shared)
```
.opencode/commands/
  ├── create-task.md
  ├── test.md
  └── README.md
```

### User-level Commands (Personal Use)
```
~/.opencode/commands/
  └── your-command.md
```

## 🚀 Available Commands

### `/create-task` - Task Generation Assistant

**Function**: Generate detailed batch task documents based on descriptions

**Usage**:
```bash
# Enter in OpenCode TUI
/create-task implement user login feature
```

**Features**:
- ✅ **Deep Research**: Automatically searches project code to understand existing implementations
- ✅ **Full Discussion**: Proactively asks questions about unclear issues
- ✅ **Detailed Planning**: Generates documents with complete implementation plans
- ✅ **No Code**: Task documents only describe "what to do", no specific code

**Workflow**:
1. Understand user requirements
2. Research project codebase
3. Raise questions for discussion
4. Formulate technical approach
5. Break down implementation steps
6. Generate task document

**Output Location**: `.ralph/tasks/[PRIORITY]-task-name.md`

## 📝 Command File Format

### Basic Structure

```markdown
---
description: "Command description"
allowed-tools: ["read", "write", "bash", "glob", "grep"]
---

Command content...

Use $ARGUMENTS to reference user input parameters
```

### Frontmatter Fields

- **description**: Command description, displayed in command list
- **allowed-tools**: List of allowed tools

### Available Tools

- `read` - Read files
- `write` - Write files
- `bash` - Execute shell commands
- `glob` - Search files
- `grep` - Search content

### Special Variables

- `$ARGUMENTS` - Command parameters entered by user

## 🎯 Usage Examples

### Example 1: Create Login Feature Task

```bash
/create-task add user login feature, support email password login
```

The command will:
1. Research existing authentication code in project
2. Ask about authentication method (JWT/Session)
3. Discuss security requirements
4. Generate task document with detailed implementation plan

### Example 2: Create Performance Optimization Task

```bash
/create-task optimize homepage loading speed
```

The command will:
1. Analyze homepage-related code
2. Ask about performance goals
3. Discuss optimization strategies
4. Generate optimization task document

## 🔧 Creating Custom Commands

### Step 1: Create Command File

```bash
# Create in project
touch .opencode/commands/my-command.md

# Or create personal command
touch ~/.opencode/commands/my-command.md
```

### Step 2: Write Command Content

```markdown
---
description: "My custom command"
allowed-tools: ["read", "write"]
---

You are an assistant helping users complete a certain task.

User input: $ARGUMENTS

Please follow these steps:
1. ...
2. ...
```

### Step 3: Use Command

In OpenCode TUI:
```
/my-command parameter content
```

## 📂 Namespaces

Use subdirectories to organize commands:

```
.opencode/commands/
  ├── frontend/
  │   ├── component.md    → /frontend:component
  │   └── style.md        → /frontend:style
  └── backend/
      ├── api.md          → /backend:api
      └── database.md     → /backend:database
```

## 💡 Best Practices

### 1. Clear Command Description

```markdown
---
description: "Generate boilerplate code for React components"
---
```

### 2. Detailed Workflow

```markdown
## Workflow

1. Understand user requirements
2. Research related code
3. Ask questions
4. Execute task
```

### 3. Proactive Interaction

```markdown
If user requirements are unclear, proactively ask:
- What feature do you want to implement?
- Any special requirements?
```

### 4. Use Appropriate Tools

```markdown
---
allowed-tools: ["read", "write", "bash"]
---

# Only use necessary tools
```

## 🐛 Troubleshooting

### Command Not Showing

1. Check if file location is correct
2. Check if filename ends with `.md`
3. Check if frontmatter format is correct

### Command Execution Failed

1. Check if `allowed-tools` contains needed tools
2. Check if command content has syntax errors

## 📖 More Resources

- [OpenCode Official Documentation](https://opencode.ai/docs/)
- [GitHub Issue #299](https://github.com/anomalyco/opencode/issues/299)
- [Project Command Examples](./)

## 🤝 Contributing

If you create useful commands, feel free to share with the team!

Just commit the command file to the `.opencode/commands/` directory.
