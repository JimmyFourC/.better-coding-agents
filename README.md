# Better Coding Agents

> **Forked and customized by Elijah** - Configuration and scripts for managing coding resources in OpenCode

This is a really dumb but incredibly effective way to get better coding agent responses for libraries and frameworks.

Basically you just clone the entire source repo for the library/framework as a git subtree, and then you can ask the agent to search the codebase for the answer to a question, and it works really well.

## Important Note

**This repo does NOT include the actual library source code.** It only contains:
- Helper scripts to manage libraries
- Command/agent configuration files
- Setup instructions

You'll use the scripts to add libraries locally. The library source code stays on your machine only.

## Getting Started

1. Clone this repo into your home directory as `~/.better-coding-agents`:
```bash
cd ~
git clone https://github.com/JimmyFourC/.better-coding-agents.git .better-coding-agents
cd .better-coding-agents
```

2. Add libraries you want (they stay local, not pushed to git):
```bash
# Example: Add OpenCode itself
./add-library.sh https://github.com/Anthropic/opencode

# Example: Add Dev Browser
./add-library.sh https://github.com/SawyerHood/dev-browser

# Example: Add Camoufox
./add-library.sh https://github.com/daijro/camoufox

# Example: Add Magnitude
./add-library.sh https://github.com/sagekit/magnitude
```

3. After adding a library, create its command file (see "Creating Command Files" below)

4. Run the setup commands to install OpenCode commands, agents, and themes:
```bash
# Create directories if they don't exist
mkdir -p ~/.config/opencode/agent
mkdir -p ~/.config/opencode/command
mkdir -p ~/.config/opencode/themes

# Copy agent files
cp -u ~/.better-coding-agents/OPENCODE_ASSETS/agent/*.md ~/.config/opencode/agent/

# Copy command files
cp -u ~/.better-coding-agents/OPENCODE_ASSETS/command/*.md ~/.config/opencode/command/

# Copy theme files
cp -u ~/.better-coding-agents/OPENCODE_ASSETS/themes/*.json ~/.config/opencode/themes/
```

5. **(Optional)** Setup Cursor commands:
```bash
mkdir -p ~/.cursor/commands
cp -u ~/.better-coding-agents/CURSOR_ASSETS/commands/*.md ~/.cursor/commands/
```

## Suggested Libraries to Add

Here are some useful libraries for AI-powered browser automation and development:

- **[opencode](https://github.com/Anthropic/opencode)** - OpenCode itself for meta-assistance
- **[dev-browser](https://github.com/SawyerHood/dev-browser)** - Browser automation for coding agents with persistent sessions
- **[camoufox](https://github.com/daijro/camoufox)** - Anti-detect browser with fingerprint evasion
- **[magnitude](https://github.com/sagekit/magnitude)** - Vision-first browser agent (94% WebVoyager SOTA)

## Helper Scripts

Three helper scripts are included to make library management easier:

### 1. Adding a New Library

Use the `add-library.sh` script to easily add new libraries:
```bash
./add-library.sh <github-url> [optional-custom-name]
```

**Examples:**
```bash
# Add with auto-detected name
./add-library.sh https://github.com/facebook/react

# Add with custom name
./add-library.sh https://github.com/tailwindlabs/tailwindcss tailwind
```

**Important:** Libraries are added locally only and are NOT pushed to git (they're in .gitignore).

**After adding**, you need to create a command file (see next section).

### 2. Creating Command Files

After adding a library, create a command file so OpenCode knows how to use it:
```bash
nano OPENCODE_ASSETS/command/<library-name>.md
```

**Template:**
```markdown
# <Library Name> Command

Search through <Library Name> source code for [brief description].

## About

[What the library does and key features]

## Usage

When the user asks about:
- [Topic 1]
- [Topic 2]
- [Library name] implementation details

Search through the codebase at:
~/.better-coding-agents/resources/<library-name>

## Instructions

1. Use file search to find relevant source files
2. Read the actual implementation code
3. Provide accurate answers based on the source code
4. Include code examples from the library when helpful
```

Then install it:
```bash
# Copy to Cursor (optional)
cp OPENCODE_ASSETS/command/<library-name>.md CURSOR_ASSETS/commands/

# Install to OpenCode config
cp OPENCODE_ASSETS/command/<library-name>.md ~/.config/opencode/command/

# Commit the command file (NOT the library source)
git add OPENCODE_ASSETS/command/<library-name>.md
git commit -m "Add <library-name> command file"
git push origin main
```

### 3. Updating Libraries

Use the `update-resources.sh` script to update all libraries to their latest versions:
```bash
./update-resources.sh
```

**Note:** You'll need to manually edit this script to add your libraries. Open it and add cases for each library you've added.

### 4. Removing a Library

Use the `remove-library.sh` script to cleanly remove a library and all its associated files:
```bash
./remove-library.sh <library-name>
```

**Example:**
```bash
./remove-library.sh camoufox
```

This removes the library locally and cleans up command files.

## Usage

After setup, you can use slash commands in OpenCode like:

- `/opencode` - Search OpenCode's source code
- `/dev-browser` - Search Dev Browser's source code
- `/camoufox` - Search Camoufox's source code
- `/magnitude` - Search Magnitude's source code

The `codebase-docs-agent` is also available to help search through library source code intelligently.

## Manual Management

If you prefer to manage libraries manually:

### Adding a Library Manually
```bash
cd ~/.better-coding-agents
git subtree add --prefix=resources/<library-name> <repo-url> <branch> --squash
```

### Updating a Library Manually
```bash
cd ~/.better-coding-agents
git subtree pull --prefix=resources/<library-name> <repo-url> <branch> --squash
```

## Project Structure
```
.better-coding-agents/
├── CURSOR_ASSETS/
│   └── commands/          # Cursor command files (committed to git)
├── OPENCODE_ASSETS/
│   ├── agent/            # OpenCode agent files (committed to git)
│   ├── command/          # OpenCode command files (committed to git)
│   └── themes/           # OpenCode color themes (committed to git)
├── resources/            # Git subtrees of library source code (LOCAL ONLY, not in git)
│   ├── opencode/
│   ├── dev-browser/
│   ├── camoufox/
│   └── magnitude/
├── .gitignore            # Excludes resources/ from git
├── add-library.sh        # Helper script to add libraries
├── update-resources.sh   # Helper script to update all libraries
├── remove-library.sh     # Helper script to remove libraries
└── README.md
```

## Why This Approach?

- **Lightweight repo** - Only scripts and configs are in git, not entire library source codes
- **Personalized libraries** - Each user adds only the libraries they need
- **Always up-to-date** - Users can update libraries independently
- **No copyright issues** - You're not redistributing other people's code

## Notes

- Library source code is stored locally in `resources/` and ignored by git
- Command files in `OPENCODE_ASSETS/` and `CURSOR_ASSETS/` ARE committed to git
- The `cp -u` flag ensures existing files are only overwritten if the source is newer
- Custom color theme for OpenCode is included in the themes folder

## Credits

Originally forked from [bmdavis419/.better-coding-agents](https://github.com/bmdavis419/.better-coding-agents)
