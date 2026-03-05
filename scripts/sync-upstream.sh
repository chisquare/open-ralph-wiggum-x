#!/bin/bash
set -e

echo "🔄 开始同步上游仓库..."

# 检查是否有未提交的更改
if ! git diff-index --quiet HEAD --; then
    echo "❌ 错误：当前有未提交的更改"
    echo "💡 请先提交或暂存你的更改："
    echo "   git stash  # 暂存更改"
    echo "   git add . && git commit -m 'your message'  # 提交更改"
    exit 1
fi

# 获取当前分支
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 当前分支: $CURRENT_BRANCH"

# 1. 更新 upstream-sync
echo ""
echo "📥 步骤 1/4: 拉取上游更新..."
git checkout upstream-sync
git pull upstream master

# 推送到 origin
echo "📤 步骤 2/4: 推送 upstream-sync 到 origin..."
git push origin upstream-sync

# 2. 合并到 master
echo ""
echo "🔀 步骤 3/4: 合并到 master..."
git checkout master
git merge upstream-sync

# 3. 显示最近的上游提交
echo ""
echo "✅ 步骤 4/4: 同步完成！"
echo ""
echo "📊 最近的上游提交："
git log --oneline -5 --graph --decorate

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✨ 同步成功完成！"
echo ""
echo "💡 接下来："
echo "   1. 运行测试确保功能正常："
echo "      bun test  # 或 npm test"
echo ""
echo "   2. 检查是否有冲突需要解决："
echo "      git status"
echo ""
echo "   3. 推送到你的 fork："
echo "      git push origin master"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
