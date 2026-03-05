# 代码风格指南

本文档定义了项目的代码风格和约定。

## 1. 导入顺序

```typescript
// 1. Bun/Node 内置模块
import { $ } from "bun";
import { existsSync, readFileSync, writeFileSync, mkdirSync, statSync } from "fs";
import { join } from "path";

// 2. 本地模块（使用相对路径）
import { checkTerminalPromise, stripAnsi, tasksMarkdownAllComplete } from "./completion";
```

**规则**:
- 内置模块在前，本地模块在后
- 使用具名导入（named imports），避免 `import *`
- 相对导入使用 `./` 前缀

## 2. TypeScript 类型定义

```typescript
// 使用 type 定义对象类型
type AgentType = "opencode" | "claude-code" | "codex" | "copilot";

type AgentEnvOptions = { 
  filterPlugins?: boolean; 
  allowAllPermissions?: boolean 
};

// 使用 interface 定义复杂对象结构
interface AgentConfig {
  type: AgentType;
  command: string;
  buildArgs: (prompt: string, model: string, options?: AgentBuildArgsOptions) => string[];
  buildEnv: (options: AgentEnvOptions) => Record<string, string>;
  parseToolOutput: (line: string) => string | null;
  configName: string;
}

// 使用 as const 定义常量数组
const AGENT_TYPES = ["opencode", "claude-code", "codex", "copilot"] as const;
type AgentType = (typeof AGENT_TYPES)[number];
```

**规则**:
- 优先使用 `type` 定义简单类型
- 使用 `interface` 定义复杂对象结构
- 使用 `as const` 创建类型安全的常量数组
- 可选参数使用 `?` 标记
- 使用 `Record<K, V>` 定义对象字典

## 3. 命名约定

```typescript
// 常量: UPPER_SNAKE_CASE
const VERSION = "1.2.2";
const IS_WINDOWS = process.platform === "win32";
const DEFAULT_CONFIG_PATH = join(process.env.HOME || "", ".config", "...");

// 函数: camelCase
function resolveCommand(cmd: string, envOverride?: string): string { }
function loadAgentConfig(configPath?: string): Record<string, JsonAgentConfig> | null { }

// 类型/接口: PascalCase
type AgentType = ...;
interface AgentConfig { ... }

// 私有辅助函数: 以动词开头
function stripAnsi(input: string): string { }
function escapeRegex(str: string): string { }

// 布尔变量/返回值: 使用 is/has/can 等前缀
const sawTask = false;
function tasksMarkdownAllComplete(...): boolean { }
```

**规则**:
- 常量: `UPPER_SNAKE_CASE`
- 函数/变量: `camelCase`
- 类型/接口: `PascalCase`
- 布尔值使用语义化前缀

## 4. 函数文档

```typescript
/**
 * Returns the last non-empty line of output, after ANSI stripping.
 */
export function getLastNonEmptyLine(output: string): string | null {
  // ...
}

/**
 * Checks whether the exact promise tag appears as the final non-empty line.
 */
export function checkTerminalPromise(output: string, promise: string): boolean {
  // ...
}
```

**规则**:
- 公共函数必须有 JSDoc 注释
- 注释说明函数用途，不重复参数类型（TypeScript 已提供）
- 使用简洁的第三人称动词（Returns, Checks, Validates）

## 5. 错误处理

```typescript
// 使用 try-catch 捕获错误
try {
  const content = readFileSync(path, "utf-8");
  const config: RalphConfig = JSON.parse(content);
  // ...
} catch {
  return null;  // 静默失败，返回 null
}

// 错误日志 + 继续执行
try {
  await $`git commit -m "message"`.quiet();
} catch {
  // Git commit failed, that's okay
}

// 致命错误处理
runRalphLoop().catch(error => {
  console.error("Fatal error:", error);
  clearState();
  process.exit(1);
});
```

**规则**:
- 使用 `try-catch` 包裹可能失败的操作
- 非关键错误可以静默处理（空 catch 块需要注释说明）
- 关键错误记录到 `console.error` 并退出
- 优先使用 `async/await` 而非 `.then()/.catch()`

## 6. 异步代码

```typescript
// 使用 async/await
async function runRalphLoop(): Promise<void> {
  const result = await $`command`.text();
  await new Promise(r => setTimeout(r, 1000));
}

// Bun shell API ($)
const output = await $`git status --porcelain`.cwd(cwd).text();
await $`git add -A`.cwd(cwd);
```

**规则**:
- 优先使用 `async/await`
- 使用 Bun 的 `$` API 执行 shell 命令
- 使用 `.text()`, `.quiet()`, `.cwd()` 链式调用

## 7. 代码格式化

```typescript
// 对象/数组: 单行或换行
const cmdArgs = ["run"];
if (model) cmdArgs.push("-m", model);

// 长链式调用: 合理换行
const result = await $`git status --porcelain`
  .cwd(cwd)
  .text();

// 条件语句: 简洁的单行
if (!cmdPath) {
  const cmdWithExt = `${cmd}.cmd`;
  // ...
}
```

**规则**:
- 没有配置 Prettier/ESLint，保持与现有代码一致
- 使用 2 空格缩进
- 字符串使用双引号 `"` 或反引号 `` ` ``
- 最多 100-120 字符行宽

## 8. 文件组织

```typescript
// 文件顶部顺序:
// 1. Shebang (如果是可执行文件)
#!/usr/bin/env bun

// 2. 模块文档注释
/**
 * Ralph Wiggum Loop for AI agents
 */

// 3. 导入
import { $ } from "bun";

// 4. 常量定义
const VERSION = "1.2.2";

// 5. 类型定义
type AgentType = ...;
interface AgentConfig { ... }

// 6. 辅助函数
function helperFunction() { }

// 7. 主逻辑/导出
async function main() { }
main().catch(console.error);
```
