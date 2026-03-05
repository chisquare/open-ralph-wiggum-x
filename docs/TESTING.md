# 测试指南

本文档说明如何编写和运行测试。

## 测试框架

项目使用 **Bun Test** 框架。

```typescript
import { describe, expect, it } from "bun:test";
```

## 测试文件结构

```typescript
import { describe, expect, it } from "bun:test";
import { functionToTest } from "../sourceFile";

describe("functionToTest", () => {
  it("should do something specific", () => {
    const result = functionToTest("input");
    expect(result).toBe("expected");
  });
});
```

## 运行测试

### 运行所有测试
```bash
bun test
```

### 运行特定测试文件
```bash
bun test ./tests/ralph.test.ts
```

### 运行单个测试（使用名称匹配）
```bash
# 使用 describe/it 名称匹配
bun test ./tests/ralph.test.ts -t "checkTerminalPromise"
```

## 测试最佳实践

1. **测试文件位置**: `tests/` 目录
2. **命名约定**: `*.test.ts`
3. **一个测试一个功能**: 每个测试应该只验证一个具体行为
4. **清晰的描述**: 使用描述性的测试名称
5. **隔离性**: 测试之间不应该有依赖关系

## CI 集成

GitHub Actions 自动运行测试（`.github/workflows/ci.yml`）：
1. `bun install` - 安装依赖
2. `bun test` - 运行测试
3. `bun build ralph.ts --outfile /dev/null` - 类型检查
