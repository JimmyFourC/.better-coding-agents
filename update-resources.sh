#!/bin/bash
# Update all library resources from their upstream repositories

cd ~/.better-coding-agents

echo "📦 Updating library resources..."
echo ""

# Update opencode
if [ -d "resources/opencode" ]; then
    echo "⬇️  Updating opencode..."
    git subtree pull --prefix=resources/opencode https://github.com/Anthropic/opencode.git main --squash
    echo ""
fi

# Update stagehand
if [ -d "resources/stagehand" ]; then
    echo "⬇️  Updating stagehand..."
    git subtree pull --prefix=resources/stagehand https://github.com/browserbase/stagehand.git main --squash
    echo ""
fi

echo "✅ Update complete!"
echo "💡 Don't forget to push changes: git push origin main"
