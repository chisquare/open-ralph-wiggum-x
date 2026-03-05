# OpenCode 自定义 Slash Commands

这个文件夹包含了项目的自定义 slash commands。

## 什么是 Slash Command？

Slash command 是 OpenCode 中以 `/` 开头的特殊命令，用于快速执行预定义的任务。

## 自定义命令位置

OpenCode 支持两个级别的自定义命令：

- **项目级命令**（团队共享）：`.opencode/commands/` 
- **用户级命令**（个人使用）：`~/.opencode/commands/`

## 命令文件格式

命令文件是 Markdown 文件，可以包含 YAML frontmatter：

```markdown
---
description: "命令描述"
allowed-tools: ["read", "write", "bash"]
---

命令内容...

使用 $ARGUMENTS 引用用户输入的参数
```

## 当前项目的命令

### /create-task

根据任务描述生成批量任务文档。

**使用方法**：
```
/create-task 实现用户登录功能
```

**特点**：
- ✅ 调研技术方案
- ✅ 讨论不明确的问题
- ✅ 制定详细的实施计划
- ❌ 不在任务文档中写代码

**生成位置**：`.ralph/tasks/`

## 创建新命令

1. 在 `.opencode/commands/` 中创建 `.md` 文件
2. 文件名即为命令名（例如 `mycommand.md` → `/mycommand`）
3. 添加 frontmatter 和命令内容
4. 在 OpenCode TUI 中使用 `/mycommand [参数]`

## 命名空间

支持使用子目录组织命令：

- `.opencode/commands/frontend/component.md` → `/frontend:component`
- `.opencode/commands/backend/api.md` → `/backend:api`

## 更多信息

- [OpenCode 官方文档](https://opencode.ai/docs/)
- [GitHub Issue #299](https://github.com/anomalyco/opencode/issues/299)
