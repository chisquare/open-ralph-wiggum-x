# 项目工作流指南

本文档说明如何在此 fork 项目中开发新功能，同时保持与上游仓库的同步。

## 📋 分支结构

```
origin (你的 fork: chisquare/open-ralph-wiggum-x)
├── master           # 你的主分支，用于自己的功能开发
├── upstream-sync    # 跟踪上游仓库的分支
└── feature-xxx      # 你的功能分支

upstream (原项目: Th0rgal/open-ralph-wiggum)
└── master           # 上游主分支
```

## 🔧 初始设置

如果还没有设置远程仓库，运行：

```bash
# 添加 upstream 远程仓库
git remote add upstream https://github.com/Th0rgal/open-ralph-wiggum.git

# 创建 upstream-sync 分支（如果不存在）
git fetch upstream
git checkout -b upstream-sync upstream/master
git push -u origin upstream-sync
git checkout master
```

## 📝 日常工作流

### 1. 在 master 上开发新功能

```bash
# 确保在 master 分支
git checkout master

# 创建新的功能分支
git checkout -b feature-my-new-feature

# 进行开发...
# 修改文件、测试等

# 提交更改
git add .
git commit -m "feat: add my new feature"

# 切回 master 并合并功能分支
git checkout master
git merge feature-my-new-feature

# 推送到你的 fork
git push origin master

# 可选：删除功能分支
git branch -d feature-my-new-feature
```

### 2. 定期同步上游更新

**步骤 A：更新 upstream-sync 分支**

```bash
# 切换到 upstream-sync 分支
git checkout upstream-sync

# 从 upstream 拉取最新更新
git pull upstream master

# 推送到你的 fork（备份）
git push origin upstream-sync
```

**步骤 B：合并到 master**

```bash
# 切换到 master 分支
git checkout master

# 合并 upstream-sync 的所有更新
git merge upstream-sync

# 解决冲突（如果有）
# 查看冲突文件：git status
# 编辑冲突文件，然后：
# git add <冲突文件>
# git commit

# 推送合并后的 master
git push origin master
```

### 3. 查看分支状态

```bash
# 查看所有分支
git branch -a

# 查看 upstream-sync 与 master 的差异
git log master..upstream-sync --oneline

# 查看 master 与 upstream-sync 的差异
git log upstream-sync..master --oneline

# 查看远程仓库配置
git remote -v
```

## ⚠️ 冲突处理

当合并 `upstream-sync` 到 `master` 时可能会遇到冲突：

```bash
# 合并时遇到冲突
git checkout master
git merge upstream-sync

# 查看冲突文件
git status

# 编辑冲突文件，选择保留的代码
# 冲突标记：
# <<<<<<< HEAD
# 你的修改
# =======
# upstream 的修改
# >>>>>>> upstream-sync

# 解决冲突后标记为已解决
git add <冲突文件>

# 完成合并
git commit

# 推送
git push origin master
```

## 🎯 最佳实践

### 1. 功能分支开发
- ✅ 总是在功能分支上开发，不在 master 上直接修改
- ✅ 功能分支名称使用描述性前缀：`feat/`, `fix/`, `refactor/`
- ✅ 完成后合并回 master 并删除功能分支

### 2. 同步频率
- 📅 建议每周或每两周同步一次 upstream
- 📅 在开始大的新功能前先同步 upstream
- 📅 同步后运行测试确保没有破坏现有功能

### 3. 提交信息
- ✅ 使用清晰的提交信息
- ✅ 遵循约定式提交格式：
  - `feat: 添加新功能`
  - `fix: 修复bug`
  - `refactor: 重构代码`
  - `docs: 更新文档`

### 4. 推送策略
- ✅ master 分支保持稳定可运行状态
- ✅ upstream-sync 分支仅用于同步，不在其上开发
- ✅ 定期推送 upstream-sync 到 origin 作为备份

## 🔄 完整同步流程（推荐脚本）

创建 `scripts/sync-upstream.sh`：

```bash
#!/bin/bash
set -e

echo "🔄 开始同步上游仓库..."

# 1. 更新 upstream-sync
echo "📥 拉取上游更新..."
git checkout upstream-sync
git pull upstream master
git push origin upstream-sync

# 2. 合并到 master
echo "🔀 合并到 master..."
git checkout master
git merge upstream-sync

# 3. 显示最近的上游提交
echo "✅ 同步完成！最近的上游提交："
git log --oneline -5 --graph --decorate

echo ""
echo "💡 记得："
echo "   - 运行测试确保功能正常"
echo "   - 推送到 origin: git push origin master"
```

使用方法：
```bash
chmod +x scripts/sync-upstream.sh
./scripts/sync-upstream.sh
```

## 📚 相关资源

- [GitHub Fork 工作流文档](https://docs.github.com/en/get-started/quickstart/fork-a-repo)
- [Git 分支管理](https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell)
- [约定式提交](https://www.conventionalcommits.org/)

## ❓ 常见问题

### Q: upstream-sync 分支需要推送到 origin 吗？
A: 建议推送，作为备份和记录。

### Q: 如果不想合并上游的某个功能怎么办？
A: 使用 `git cherry-pick` 选择性合并特定提交，或者使用 `git merge --no-commit` 后手动调整。

### Q: 如何查看上游有哪些新功能？
A: 运行 `git log upstream-sync --oneline -10` 查看最近的提交。

### Q: 合并后发现破坏了我的功能怎么办？
A: 如果还没推送，可以用 `git reset --hard HEAD~1` 撤销。如果已推送，使用 `git revert` 创建反向提交。

---

**最后更新**: 2026-03-05
**维护者**: @chisquare
