# 批量任务示例文件

这个文件夹包含了批量任务模式的示例任务文件，用于演示如何创建和使用批量任务。

## 文件说明

- **[HIGH]-example-task.md** - 高优先级示例任务
- **[MEDIUM]-example-test.md** - 中等优先级示例任务
- **[LOW]-formatting.md** - 低优先级示例任务

## 使用方法

要使用这些示例任务，可以将它们复制到 `.ralph/tasks/` 文件夹中：

```bash
# 复制示例任务到任务文件夹
cp docs/tasks-example/*.md .ralph/tasks/

# 执行批量任务
bun ralph.ts --batch-tasks
```

## 创建自己的任务

参考这些示例文件的格式创建你自己的任务：

```markdown
---
priority: HIGH
title: 任务标题
created_at: 2026-03-05
---

## 任务描述

详细的任务描述...

## 要求

- 要求 1
- 要求 2
```

## 更多信息

查看 [批量任务文档](../BATCH_TASKS.md) 了解更多详情。
