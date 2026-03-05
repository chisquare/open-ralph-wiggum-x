# 自定义 Slash Commands 使用指南

## 📚 概述

OpenCode 支持自定义 slash commands，允许你创建可重用的命令来自动化常见任务。

## 🗂️ 文件位置

### 项目级命令（团队共享）
```
.opencode/commands/
  ├── create-task.md
  ├── test.md
  └── README.md
```

### 用户级命令（个人使用）
```
~/.opencode/commands/
  └── your-command.md
```

## 🚀 当前可用命令

### `/create-task` - 任务生成助手

**功能**：根据描述生成详细的批量任务文档

**使用方法**：
```bash
# 在 OpenCode TUI 中输入
/create-task 实现用户登录功能
```

**特点**：
- ✅ **深入调研**：自动搜索项目代码，了解现有实现
- ✅ **充分讨论**：对不明确的问题主动提问
- ✅ **详细计划**：生成包含完整实施计划的文档
- ✅ **不含代码**：任务文档只描述"做什么"，不写具体代码

**工作流程**：
1. 理解用户需求
2. 调研项目代码库
3. 提出需要讨论的问题
4. 制定技术方案
5. 拆分实施步骤
6. 生成任务文档

**生成位置**：`.ralph/tasks/[PRIORITY]-task-name.md`

## 📝 命令文件格式

### 基本结构

```markdown
---
description: "命令描述"
allowed-tools: ["read", "write", "bash", "glob", "grep"]
---

命令内容...

使用 $ARGUMENTS 引用用户输入的参数
```

### Frontmatter 字段

- **description**：命令描述，会显示在命令列表中
- **allowed-tools**：允许使用的工具列表

### 可用工具

- `read` - 读取文件
- `write` - 写入文件
- `bash` - 执行 shell 命令
- `glob` - 搜索文件
- `grep` - 搜索内容

### 特殊变量

- `$ARGUMENTS` - 用户输入的命令参数

## 🎯 使用示例

### 示例 1：创建登录功能任务

```bash
/create-task 添加用户登录功能，支持邮箱密码登录
```

命令会：
1. 调研项目现有的认证代码
2. 询问认证方式（JWT/Session）
3. 讨论安全要求
4. 生成包含详细实施计划的任务文档

### 示例 2：创建性能优化任务

```bash
/create-task 优化首页加载速度
```

命令会：
1. 分析首页相关的代码
2. 询问性能目标
3. 讨论优化策略
4. 生成优化任务文档

## 🔧 创建自定义命令

### 步骤 1：创建命令文件

```bash
# 在项目中创建
touch .opencode/commands/my-command.md

# 或创建个人命令
touch ~/.opencode/commands/my-command.md
```

### 步骤 2：编写命令内容

```markdown
---
description: "我的自定义命令"
allowed-tools: ["read", "write"]
---

你是一个助手，帮助用户完成某项任务。

用户输入：$ARGUMENTS

请按照以下步骤操作：
1. ...
2. ...
```

### 步骤 3：使用命令

在 OpenCode TUI 中：
```
/my-command 参数内容
```

## 📂 命名空间

使用子目录组织命令：

```
.opencode/commands/
  ├── frontend/
  │   ├── component.md    → /frontend:component
  │   └── style.md        → /frontend:style
  └── backend/
      ├── api.md          → /backend:api
      └── database.md     → /backend:database
```

## 💡 最佳实践

### 1. 明确的命令描述

```markdown
---
description: "生成 React 组件的样板代码"
---
```

### 2. 详细的工作流程

```markdown
## 工作流程

1. 理解用户需求
2. 调研相关代码
3. 提出问题
4. 执行任务
```

### 3. 主动交互

```markdown
如果用户的需求不明确，请主动提问：
- 你想要实现什么功能？
- 有什么特殊要求吗？
```

### 4. 使用合适的工具

```markdown
---
allowed-tools: ["read", "write", "bash"]
---

# 只使用必要的工具
```

## 🐛 故障排查

### 命令不显示

1. 检查文件位置是否正确
2. 检查文件名是否为 `.md`
3. 检查 frontmatter 格式是否正确

### 命令执行失败

1. 检查 `allowed-tools` 是否包含需要的工具
2. 检查命令内容是否有语法错误

## 📖 更多资源

- [OpenCode 官方文档](https://opencode.ai/docs/)
- [GitHub Issue #299](https://github.com/anomalyco/opencode/issues/299)
- [项目命令示例](./)

## 🤝 贡献

如果你创建了有用的命令，欢迎分享给团队！

将命令文件提交到 `.opencode/commands/` 目录即可。
