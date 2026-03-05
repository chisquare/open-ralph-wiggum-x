# 常见开发任务

本文档说明常见的开发任务和操作。

## 添加新的 AI 代理支持

1. 在 `AGENT_TYPES` 数组添加代理名称
2. 在 `ARGS_TEMPLATES` 添加参数构建函数
3. 在 `ENV_TEMPLATES` 添加环境变量构建函数
4. 在 `PARSE_PATTERNS` 添加输出解析函数
5. 在 `BUILT_IN_AGENTS` 添加配置
6. 更新测试

示例位置：`ralph.ts:31-250`

## 修改完成检测逻辑

1. 编辑 `completion.ts`
2. 在 `tests/ralph.test.ts` 添加测试用例
3. 运行 `bun test` 验证

## 调试循环逻辑

```bash
# 使用 --status 查看状态
ralph --status

# 使用 --add-context 注入提示
ralph --add-context "Focus on fixing auth module"
```

## 环境变量配置

```bash
# AI 代理二进制路径配置
RALPH_OPENCODE_BINARY="opencode"      # OpenCode CLI 路径
RALPH_CLAUDE_BINARY="claude"          # Claude Code CLI 路径
RALPH_CODEX_BINARY="codex"            # Codex CLI 路径
RALPH_COPILOT_BINARY="copilot"        # Copilot CLI 路径
```

## 项目结构

```
open-ralph-wiggum-x/
├── ralph.ts              # 主文件 (2380 行), CLI 入口和循环逻辑
├── completion.ts         # 完成检测辅助函数
├── tests/
│   └── ralph.test.ts     # 单元测试 (Bun Test)
├── bin/
│   └── ralph.js          # npm 包装器 (调用 bun ralph.ts)
├── .github/workflows/
│   └── ci.yml            # CI: test + typecheck
├── scripts/
│   └── sync-upstream.sh  # 同步上游仓库脚本
├── package.json          # 包配置
├── README.md             # 用户文档
├── WORKFLOW.md           # Git 工作流指南
└── AGENTS.md             # 开发指南
```

**状态文件** (运行时生成在 `.ralph/` 目录):
- `ralph-loop.state.json` - 活动循环状态
- `ralph-history.json` - 迭代历史和指标
- `ralph-context.md` - 待注入的上下文
- `ralph-tasks.md` - 任务列表
- `ralph-questions.json` - 待回答的用户问题
