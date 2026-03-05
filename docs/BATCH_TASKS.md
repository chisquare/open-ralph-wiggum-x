# 批量任务模式 (Batch Tasks Mode)

## 概述

批量任务模式允许你将多个任务文档放在 `.ralph/tasks/` 文件夹中，程序会按照优先级顺序自动执行这些任务。

## 文件夹结构

```
.ralph/
  tasks/                      # 任务文件夹
    [HIGH]-task-name.md       # 高优先级任务
    [MEDIUM]-task-name.md     # 中等优先级任务
    [LOW]-task-name.md        # 低优先级任务
    completed/                # 已完成的任务
      [HIGH]-task-name.md     # 完成后移动到这里
```

## 任务文件格式

任务文件使用 Markdown 格式，包含 YAML frontmatter：

```markdown
---
priority: HIGH
title: 任务标题
created_at: 2026-03-05
---

## 任务描述

详细的任务描述内容...

## 要求

- 要求 1
- 要求 2
```

### Frontmatter 字段

- **priority**: 优先级，可选值：`URGENT`, `HIGH`, `MEDIUM`, `LOW`
- **title**: 任务标题（可选，如果未提供会从文件名提取）
- **created_at**: 创建时间（可选，格式：YYYY-MM-DD）

### 文件命名规范

文件名格式：`[PRIORITY]-task-name.md`

示例：
- `[URGENT]-fix-critical-bug.md`
- `[HIGH]-implement-login.md`
- `[MEDIUM]-update-docs.md`
- `[LOW]-cleanup-code.md`

## 使用方法

### 1. 创建任务

在 `.ralph/tasks/` 文件夹中创建任务文件：

```bash
# 复制示例任务
cp docs/tasks-example/*.md .ralph/tasks/

# 或创建新任务
cat > .ralph/tasks/[HIGH]-my-task.md << 'EOF'
---
priority: HIGH
title: 我的任务
created_at: 2026-03-05
---

## 任务描述
请实现某个功能...
EOF
```

### 2. 执行批量任务

```bash
# 基本用法
bun ralph.ts --batch-tasks

# 指定代理
bun ralph.ts --batch-tasks --agent claude-code

# 指定模型
bun ralph.ts --batch-tasks --model claude-sonnet-4

# 组合其他参数
bun ralph.ts --batch-tasks --no-commit --verbose-tools
```

### 3. 查看执行结果

执行完成后：
- 成功的任务会移动到 `.ralph/tasks/completed/` 文件夹
- 失败的任务保留在原位置，并在文件末尾追加执行结果

## 执行顺序

任务按以下顺序执行：
1. 优先级：URGENT > HIGH > MEDIUM > LOW
2. 同优先级按 `created_at` 升序排列
3. 如果没有 `created_at`，按文件名排序

## 执行结果

每个任务执行后，会在文件末尾追加执行结果：

```markdown
---
## 执行结果

- **状态**: ✅ 成功 / ❌ 失败
- **开始时间**: 2026-03-05T10:30:00.000Z
- **结束时间**: 2026-03-05T10:35:20.000Z
- **耗时**: 5分20秒
- **迭代次数**: 1
- **使用的工具**:
  - Read: 5
  - Write: 3
  - Bash: 8
- **输出摘要**: 任务执行成功
```

## 失败处理

如果任务执行失败：
1. 文件保留在原位置（不移动到 completed 文件夹）
2. 错误信息会追加到文件末尾
3. 程序会继续执行下一个任务

## 最佳实践

1. **任务拆分**: 将大任务拆分为多个小任务，便于管理和重试
2. **优先级设置**: 合理设置优先级，确保重要任务优先执行
3. **描述清晰**: 在任务描述中提供详细的上下文和要求
4. **定期清理**: 定期清理 completed 文件夹中的旧任务

## 示例

### 示例 1: 修复 Bug

```markdown
---
priority: URGENT
title: 修复生产环境登录失败问题
created_at: 2026-03-05
---

## 问题描述

生产环境中部分用户无法登录，报错信息：
```
Error: Invalid token
```

## 复现步骤

1. 打开登录页面
2. 输入用户名和密码
3. 点击登录按钮
4. 观察错误信息

## 要求

- 找出根本原因
- 修复 bug
- 添加相关测试
- 更新 CHANGELOG
```

### 示例 2: 添加功能

```markdown
---
priority: HIGH
title: 实现用户头像上传功能
created_at: 2026-03-05
---

## 任务描述

实现用户头像上传和显示功能。

## 功能要求

- 支持上传 JPG、PNG 格式
- 图片大小限制 2MB
- 自动裁剪为正方形
- 生成缩略图

## 技术要求

- 使用 TypeScript
- 添加单元测试
- 添加 API 文档
```

## 注意事项

1. 批量任务模式会串行执行所有任务
2. 每个任务执行完成后会等待 2 秒再执行下一个
3. 可以随时使用 Ctrl+C 停止执行
4. 已执行的任务（包含"执行结果"块）不会重复执行
