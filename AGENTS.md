# AGENTS.md - 开发指南

本文档为 AI 编码助手（如 OpenCode、Claude Code 等）提供此仓库的开发指南。

## 项目概述

Open Ralph Wiggum 是一个基于 Bun + TypeScript 的 CLI 工具，实现了 Ralph Wiggum 技术——AI 编码代理的自主迭代循环。支持多种 AI 代理（OpenCode、Claude Code、Codex、Copilot CLI）。

**技术栈**: Bun + TypeScript  
**主要文件**: `ralph.ts` (2380 行), `completion.ts`, `tests/ralph.test.ts`  
**运行时**: Bun (需要 Bun 运行时)

---

## 构建/测试/类型检查

### 开发运行
```bash
bun ralph.ts "your prompt here" --max-iterations 10
bun start
```

### 构建
```bash
bun run build  # 构建可执行文件到 bin/ralph
```

### 测试
```bash
bun test                                    # 运行所有测试
bun test ./tests/ralph.test.ts              # 运行特定测试文件
bun test ./tests/ralph.test.ts -t "testName" # 运行单个测试
```

### 类型检查
```bash
bun build ralph.ts --outfile /dev/null  # TypeScript 类型检查
```

### CI 流程
GitHub Actions (`.github/workflows/ci.yml`)：
1. `bun install` - 安装依赖
2. `bun test` - 运行测试
3. `bun build ralph.ts --outfile /dev/null` - 类型检查

---

## 详细文档

- **[代码风格指南](docs/CODE_STYLE.md)** - 导入顺序、类型定义、命名约定、错误处理、异步代码、格式化
- **[测试指南](docs/TESTING.md)** - 测试框架、运行测试、最佳实践
- **[常见任务](docs/TASKS.md)** - 添加代理、修改逻辑、调试、环境变量、项目结构
- **[Git 工作流](WORKFLOW.md)** - 分支管理、提交规范、同步上游
- **[批量任务模式](docs/BATCH_TASKS.md)** - 批量执行任务文档
- **[自定义 Slash Commands](docs/SLASH_COMMANDS.md)** - 创建自定义命令

---

## 批量任务模式

项目支持批量任务模式，可以自动执行 `.ralph/tasks/` 文件夹中的任务。

### 使用方法

```bash
# 执行批量任务
bun ralph.ts --batch-tasks

# 指定代理
bun ralph.ts --batch-tasks --agent claude-code
```

### 任务文档格式

```markdown
---
priority: HIGH
title: 任务标题
created_at: 2026-03-05
---

## 任务描述
[详细的任务描述]

## 实施计划
[具体的实施步骤]
```

### 创建任务

使用 `/create-task` 命令（OpenCode TUI 中）：
```
/create-task 实现用户登录功能
```

---

## 自定义 Slash Commands

项目包含自定义的 OpenCode slash commands，位于 `.opencode/commands/`。

### 可用命令

- `/create-task` - 根据描述生成任务文档
  - 自动调研项目代码
  - 讨论技术方案
  - 生成详细的实施计划
  - 不包含具体代码

### 创建新命令

在 `.opencode/commands/` 中创建 `.md` 文件：

```markdown
---
description: "命令描述"
allowed-tools: ["read", "write", "bash"]
---

命令内容... $ARGUMENTS
```

---

## 核心规则

### 代码风格
- **导入顺序**: 内置模块 → 本地模块，使用具名导入
- **类型定义**: 简单用 `type`，复杂用 `interface`，常量数组用 `as const`
- **命名**: 常量 `UPPER_SNAKE_CASE`，函数 `camelCase`，类型 `PascalCase`
- **错误处理**: 使用 `try-catch`，非关键错误可静默，关键错误记录并退出
- **异步代码**: 优先 `async/await`，使用 Bun `$` API

### 测试
- 测试框架: Bun Test (`import { describe, expect, it } from "bun:test"`)
- 测试位置: `tests/*.test.ts`
- 运行单个测试: `bun test -t "testName"`

### Git 工作流
- **分支**: `master` (主分支), `upstream-sync` (同步上游), `feature-xxx` (功能分支)
- **提交信息**: 遵循约定式提交 (`feat:`, `fix:`, `refactor:`, `docs:`)
- **同步频率**: 每周或每两周同步上游

---

## 注意事项

1. **不要添加注释**: 除非用户明确要求，否则不要添加代码注释
2. **保持简洁**: 遵循现有代码风格，不要过度工程化
3. **类型安全**: 使用 TypeScript 类型系统，避免 `any`
4. **错误恢复**: Ralph 循环应该能够从错误中恢复并继续
5. **跨平台**: 考虑 Windows/macOS/Linux 兼容性（使用 `IS_WINDOWS` 标志）

---

**最后更新**: 2026-03-05  
**维护者**: 基于 open-ralph-wiggum 项目分析生成
