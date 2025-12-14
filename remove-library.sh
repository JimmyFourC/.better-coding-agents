#!/bin/bash
# Remove a library resource and its associated command files

if [ -z "$1" ]; then
    echo "Usage: ./remove-library.sh <library-name>"
    echo ""
    echo "Example:"
    echo "  ./remove-library.sh stagehand-python"
    exit 1
fi

LIBRARY_NAME=$1

echo "🗑️  Removing library: $LIBRARY_NAME"
echo ""

# Remove resource folder
if [ -d "resources/$LIBRARY_NAME" ]; then
    echo "📁 Removing resources/$LIBRARY_NAME..."
    rm -rf resources/$LIBRARY_NAME
else
    echo "⚠️  resources/$LIBRARY_NAME not found (skipping)"
fi

# Remove command files
if [ -f "OPENCODE_ASSETS/command/$LIBRARY_NAME.md" ]; then
    echo "📄 Removing OPENCODE_ASSETS/command/$LIBRARY_NAME.md..."
    rm OPENCODE_ASSETS/command/$LIBRARY_NAME.md
fi

if [ -f "CURSOR_ASSETS/commands/$LIBRARY_NAME.md" ]; then
    echo "📄 Removing CURSOR_ASSETS/commands/$LIBRARY_NAME.md..."
    rm CURSOR_ASSETS/commands/$LIBRARY_NAME.md
fi

if [ -f "$HOME/.config/opencode/command/$LIBRARY_NAME.md" ]; then
    echo "📄 Removing ~/.config/opencode/command/$LIBRARY_NAME.md..."
    rm ~/.config/opencode/command/$LIBRARY_NAME.md
fi

if [ -f "$HOME/.cursor/commands/$LIBRARY_NAME.md" ]; then
    echo "📄 Removing ~/.cursor/commands/$LIBRARY_NAME.md..."
    rm ~/.cursor/commands/$LIBRARY_NAME.md
fi

echo ""
echo "✅ Removal complete!"
echo "💡 Don't forget to commit: git add . && git commit -m 'Remove $LIBRARY_NAME' && git push"
