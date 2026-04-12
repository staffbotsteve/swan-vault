#!/bin/bash
# Swan Vault — Quick Start Setup
# Run this after cloning the vault repo locally

set -e

echo "=== Swan Vault Setup ==="

# Check prerequisites
command -v git >/dev/null 2>&1 || { echo "git is required but not installed."; exit 1; }
command -v gh >/dev/null 2>&1 || { echo "GitHub CLI (gh) is recommended. Install: brew install gh"; }

# Initialize git if not already
if [ ! -d ".git" ]; then
  echo "Initializing git repo..."
  git init
  git branch -M main
fi

# Create .gitignore
cat > .gitignore << 'EOF'
# Obsidian workspace files (local to each machine)
.obsidian/workspace.json
.obsidian/workspace-mobile.json
.obsidian/cache/
.obsidian/plugins/*/data.json

# OS files
.DS_Store
Thumbs.db

# Temp files
*.tmp
*.swp
EOF

# Create Obsidian Git plugin config directory
mkdir -p .obsidian/plugins/obsidian-git

cat > .obsidian/plugins/obsidian-git/data.json << 'EOF'
{
  "commitMessage": "vault: {{date}} auto-commit",
  "autoCommitMessage": "vault: {{date}} auto-commit",
  "autoPullInterval": 10,
  "autoPullOnBoot": true,
  "disablePush": false,
  "pullBeforePush": true,
  "disablePopups": false,
  "listChangedFilesInMessageBody": true,
  "showStatusBar": true,
  "updateSubmodules": false,
  "syncMethod": "merge",
  "gitPath": "",
  "customMessageOnAutoBackup": false,
  "autoBackupAfterFileChange": false,
  "treeStructure": false,
  "refreshSourceControl": true,
  "basePath": "",
  "differentIntervalCommitAndPush": false,
  "changedFilesInStatusBar": true,
  "showedMobileNotice": true,
  "refreshSourceControlTimer": 7000,
  "showBranchStatusBar": true,
  "setLastSaveToLastCommit": false
}
EOF

# Create community plugins list
mkdir -p .obsidian
cat > .obsidian/community-plugins.json << 'EOF'
[
  "obsidian-git"
]
EOF

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "  1. Create private GitHub repo:  gh repo create swan-vault --private --source=. --push"
echo "  2. Open this folder as an Obsidian vault"
echo "  3. Enable Community Plugins in Obsidian settings"
echo "  4. Install and enable 'Obsidian Git' plugin"
echo "  5. Create a fine-grained PAT for agent writes (see 00-System/vault-write-system.md)"
echo "  6. Request Managed Agents multi-agent access: https://claude.com/form/claude-managed-agents"
echo ""
echo "Your vault is ready."
