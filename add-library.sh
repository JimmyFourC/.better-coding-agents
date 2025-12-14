#!/bin/bash
# Add a new library resource from a GitHub repository

if [ -z "$1" ]; then
    echo "Usage: ./add-library.sh <github-url> [library-name]"
    echo ""
    echo "Example:"
    echo "  ./add-library.sh https://github.com/browserbase/stagehand"
    echo "  ./add-library.sh https://github.com/browserbase/stagehand stagehand-js"
    exit 1
fi

GITHUB_URL=$1

# Extract repo name from URL if not provided
if [ -z "$2" ]; then
    LIBRARY_NAME=$(echo $GITHUB_URL | sed 's/.*\///' | sed 's/\.git$//')
else
    LIBRARY_NAME=$2
fi

# Detect default branch
echo "🔍 Detecting default branch..."
DEFAULT_BRANCH=$(git ls-remote --symref $GITHUB_URL HEAD | head -1 | sed 's/.*refs\/heads\///' | sed 's/\s.*//')

if [ -z "$DEFAULT_BRANCH" ]; then
    echo "⚠️  Could not detect default branch, assuming 'main'"
    DEFAULT_BRANCH="main"
fi

echo ""
echo "📦 Adding library: $LIBRARY_NAME"
echo "🔗 Repository: $GITHUB_URL"
echo "🌿 Branch: $DEFAULT_BRANCH"
echo ""

# Add the subtree
cd ~/.better-coding-agents
git subtree add --prefix=resources/$LIBRARY_NAME $GITHUB_URL $DEFAULT_BRANCH --squash

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Successfully added $LIBRARY_NAME!"
    echo ""
    echo "📝 Next steps:"
    echo "1. Create command file: nano OPENCODE_ASSETS/command/$LIBRARY_NAME.md"
    echo "2. Copy to Cursor (optional): cp OPENCODE_ASSETS/command/$LIBRARY_NAME.md CURSOR_ASSETS/commands/"
    echo "3. Install: cp OPENCODE_ASSETS/command/$LIBRARY_NAME.md ~/.config/opencode/command/"
    echo "4. Commit: git add . && git commit -m 'Add $LIBRARY_NAME resource' && git push"
else
    echo "❌ Failed to add $LIBRARY_NAME"
    exit 1
fi
