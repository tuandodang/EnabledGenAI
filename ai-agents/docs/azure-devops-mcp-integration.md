# Azure DevOps MCP Integration Guide

**Version:** 1.0
**Last Updated:** November 18, 2024

---

## 📑 Table of Contents

1. [Overview](#overview)
2. [What is MCP?](#what-is-mcp)
3. [Prerequisites](#prerequisites)
4. [Installation & Setup](#installation--setup)
5. [Configuration](#configuration)
6. [Usage with Claude AI](#usage-with-claude-ai)
7. [Common Operations](#common-operations)
8. [Automation Workflows](#automation-workflows)
9. [Troubleshooting](#troubleshooting)
10. [Best Practices](#best-practices)

---

## Overview

This guide shows you how to integrate Azure DevOps with Claude AI using the Model Context Protocol (MCP). This enables Claude to directly interact with your Azure DevOps work items, enabling automated:

- Work item creation from requirements
- Task breakdown and estimation
- Sprint planning
- Status updates
- Progress tracking

**Benefits:**
- Seamless integration between AI agents and Azure DevOps
- Automated work item creation from requirements
- Real-time synchronization
- Reduced manual data entry

---

## What is MCP?

**Model Context Protocol (MCP)** is an open protocol that enables AI assistants like Claude to securely connect to external data sources and tools.

### How It Works

```
┌─────────────┐         ┌─────────────┐         ┌──────────────────┐
│             │  MCP    │             │  REST   │                  │
│  Claude AI  │◄───────►│ MCP Server  │◄───────►│  Azure DevOps    │
│             │         │             │         │                  │
└─────────────┘         └─────────────┘         └──────────────────┘
```

**Flow:**
1. Claude receives your request (e.g., "Create work items from these requirements")
2. Claude uses MCP to call Azure DevOps server
3. MCP server authenticates with Azure DevOps API
4. Work items are created/updated in Azure DevOps
5. Claude receives confirmation and responds

---

## Prerequisites

### Required

- **Azure DevOps Organization** (free tier available)
- **Personal Access Token (PAT)** with appropriate permissions
- **Claude Desktop App** or **Claude API access**
- **Node.js** (v18 or later) for running MCP server
- **Git** for cloning MCP server

### Optional

- **Docker** for containerized MCP server
- **ngrok** for local development tunneling

---

## Installation & Setup

### Step 1: Create Azure DevOps PAT (5 minutes)

#### 1.1 Navigate to Azure DevOps

```
https://dev.azure.com/{your-organization}
```

#### 1.2 Generate Personal Access Token

```
1. Click on User Settings (top right) → Personal Access Tokens
2. Click "+ New Token"
3. Fill in details:
   - Name: "Claude AI MCP Integration"
   - Organization: [Your organization]
   - Expiration: 90 days (or custom)
   - Scopes: Select:
     ✅ Work Items (Read, Write, Manage)
     ✅ Project and Team (Read)
     ✅ Build (Read) [optional]
     ✅ Code (Read) [optional]
4. Click "Create"
5. COPY THE TOKEN (you won't see it again!)
```

#### 1.3 Store PAT Securely

```bash
# macOS/Linux: Add to environment variables
echo 'export AZURE_DEVOPS_PAT="your-pat-here"' >> ~/.zshrc
source ~/.zshrc

# Windows PowerShell: Add to profile
$env:AZURE_DEVOPS_PAT = "your-pat-here"
# Or add to System Environment Variables
```

**⚠️ Security Note:** Never commit PAT to git! Add to `.gitignore` or use secret management.

### Step 2: Install MCP Server for Azure DevOps (10 minutes)

#### 2.1 Clone MCP Server Repository

```bash
# Navigate to your tools directory
cd ~/tools

# Clone the Azure DevOps MCP server
# Note: Replace with actual Azure DevOps MCP server URL when available
# For now, this is a placeholder for the concept
git clone https://github.com/your-org/azure-devops-mcp-server.git
cd azure-devops-mcp-server
```

**Note:** As of November 2024, you may need to build a custom MCP server for Azure DevOps. Reference implementation:

```bash
# Alternative: Use generic HTTP MCP server with Azure DevOps API
npm install -g @modelcontextprotocol/server-http
```

#### 2.2 Install Dependencies

```bash
# Install Node.js dependencies
npm install

# Or using Yarn
yarn install
```

#### 2.3 Build the Server

```bash
# Build TypeScript (if applicable)
npm run build

# Verify installation
npm run start -- --help
```

### Step 3: Configure MCP Server (10 minutes)

#### 3.1 Create Configuration File

```bash
# Create config directory
mkdir -p ~/.azure-devops-mcp

# Create configuration file
cat > ~/.azure-devops-mcp/config.json << 'EOF'
{
  "azureDevOps": {
    "organization": "your-org-name",
    "project": "your-project-name",
    "personalAccessToken": "${AZURE_DEVOPS_PAT}",
    "apiVersion": "7.0"
  },
  "server": {
    "port": 3000,
    "host": "localhost"
  },
  "logging": {
    "level": "info",
    "file": "~/.azure-devops-mcp/logs/server.log"
  }
}
EOF
```

#### 3.2 Update Configuration

```bash
# Edit config file
nano ~/.azure-devops-mcp/config.json

# Update these values:
# - organization: Your Azure DevOps organization name
# - project: Your project name
# - Keep ${AZURE_DEVOPS_PAT} as is (reads from environment)
```

#### 3.3 Test Configuration

```bash
# Start MCP server
cd ~/tools/azure-devops-mcp-server
npm run start

# Expected output:
# ✅ Azure DevOps MCP Server started
# ✅ Listening on http://localhost:3000
# ✅ Connected to organization: your-org
# ✅ Project: your-project
```

### Step 4: Configure Claude Desktop (15 minutes)

#### 4.1 Install Claude Desktop App

**macOS:**
```bash
# Download from:
https://claude.ai/download

# Or via Homebrew
brew install --cask claude
```

**Windows:**
```bash
# Download installer from:
https://claude.ai/download

# Run installer
```

#### 4.2 Configure MCP in Claude

**Location:** `~/Library/Application Support/Claude/config.json` (macOS)

```bash
# Create config directory if not exists
mkdir -p ~/Library/Application\ Support/Claude

# Create/edit config
cat > ~/Library/Application\ Support/Claude/config.json << 'EOF'
{
  "mcpServers": {
    "azure-devops": {
      "command": "node",
      "args": [
        "/Users/yourusername/tools/azure-devops-mcp-server/dist/index.js"
      ],
      "env": {
        "AZURE_DEVOPS_PAT": "your-pat-token-here"
      }
    }
  }
}
EOF
```

**Windows:** `%APPDATA%\Claude\config.json`

```json
{
  "mcpServers": {
    "azure-devops": {
      "command": "node",
      "args": [
        "C:\\tools\\azure-devops-mcp-server\\dist\\index.js"
      ],
      "env": {
        "AZURE_DEVOPS_PAT": "your-pat-token-here"
      }
    }
  }
}
```

#### 4.3 Restart Claude

```bash
# macOS
# Quit Claude completely (Cmd+Q)
# Reopen Claude

# Windows
# Exit Claude from system tray
# Reopen Claude
```

#### 4.4 Verify MCP Connection

In Claude Desktop:

```
Prompt: "Can you list my Azure DevOps work items?"

Expected: Claude should connect via MCP and list work items
```

---

## Configuration

### Environment Variables

```bash
# Required
export AZURE_DEVOPS_PAT="your-pat-here"
export AZURE_DEVOPS_ORGANIZATION="your-org"
export AZURE_DEVOPS_PROJECT="your-project"

# Optional
export AZURE_DEVOPS_API_VERSION="7.0"
export MCP_SERVER_PORT="3000"
export MCP_LOG_LEVEL="info"
```

### Config File Structure

```json
{
  "azureDevOps": {
    "organization": "contoso",
    "project": "ProductCatalog",
    "personalAccessToken": "${AZURE_DEVOPS_PAT}",
    "apiVersion": "7.0",
    "defaultArea": "ProductCatalog\\Backend",
    "defaultIteration": "ProductCatalog\\Sprint 1"
  },
  "workItemDefaults": {
    "type": "User Story",
    "state": "New",
    "priority": 2,
    "assignedTo": ""
  },
  "server": {
    "port": 3000,
    "host": "localhost",
    "cors": {
      "enabled": true,
      "origins": ["https://claude.ai"]
    }
  },
  "logging": {
    "level": "info",
    "file": "~/.azure-devops-mcp/logs/server.log",
    "maxSize": "10m",
    "maxFiles": 5
  },
  "cache": {
    "enabled": true,
    "ttl": 300
  }
}
```

---

## Usage with Claude AI

### Basic Operations

#### List Work Items

```
Prompt: "List all active user stories in Azure DevOps"

Claude will:
1. Connect to Azure DevOps via MCP
2. Query work items with state=Active and type=User Story
3. Return formatted list
```

#### Create Work Item

```
Prompt: "Create a user story in Azure DevOps:
Title: Implement Product Search API
Description: As a customer, I want to search products by keyword
Acceptance Criteria:
- Search returns results in <500ms
- Support autocomplete
- Handle typos
Area: Backend
Iteration: Sprint 1
Priority: 1"

Claude will:
1. Parse your requirements
2. Create work item via MCP
3. Return work item ID and URL
```

#### Update Work Item

```
Prompt: "Update work item #12345:
- State: Active → In Progress
- Assigned To: john@contoso.com
- Add comment: Started implementation"

Claude will:
1. Fetch work item #12345
2. Update specified fields
3. Add comment
4. Return confirmation
```

#### Query Work Items

```
Prompt: "Show me all high-priority bugs assigned to me that are still active"

Claude will:
1. Build WIQL query
2. Execute via MCP
3. Return results
```

---

## Common Operations

### Operation 1: Generate Work Items from Requirements

**Scenario:** You have requirements document, need to create work items

```
Prompt to Claude:

"I have the following requirements for a Product Catalog feature:

[Paste requirements from docs/requirements/product-catalog-requirements.md]

Please:
1. Analyze these requirements
2. Break down into User Stories and Tasks
3. Create work items in Azure DevOps with:
   - Area: ProductCatalog\\Backend
   - Iteration: Sprint 1
   - Appropriate priorities
4. Return the created work item IDs"

Claude will:
1. Analyze requirements (using Agent #6 logic)
2. Create hierarchy:
   Epic → Features → User Stories → Tasks
3. Create all work items in Azure DevOps
4. Return summary with IDs
```

**Output Example:**
```
Created work items:

Epic #12340: Product Catalog API
├── Feature #12341: Product Management
│   ├── User Story #12342: Create Product
│   │   ├── Task #12343: Implement Product Entity
│   │   ├── Task #12344: Implement Product Repository
│   │   └── Task #12345: Implement Product Service
│   ├── User Story #12346: Update Product
│   └── User Story #12347: Delete Product
└── Feature #12348: Product Search
    ├── User Story #12349: Keyword Search
    └── User Story #12350: Advanced Filtering

Total: 1 Epic, 2 Features, 5 User Stories, 3 Tasks
```

### Operation 2: Sprint Planning

```
Prompt to Claude:

"Plan Sprint 2 for Backend team:
- Team capacity: 80 hours
- Team members: Alice (40h), Bob (40h)
- Pull unassigned user stories from backlog
- Prioritize by business value
- Create sprint tasks
- Update work items in Azure DevOps"

Claude will:
1. Query backlog
2. Analyze and prioritize
3. Allocate stories to sprint
4. Create tasks
5. Update Azure DevOps
```

### Operation 3: Progress Tracking

```
Prompt to Claude:

"Generate sprint burndown report:
- Sprint: Sprint 1
- Include: Remaining work, completed work
- Visualize as table
- Identify blockers"

Claude will:
1. Query all sprint work items
2. Calculate metrics
3. Generate burndown data
4. Identify items with no updates in 3+ days
```

### Operation 4: Automated Updates

```
Prompt to Claude:

"Based on this PR being merged:
- Update work item #12345 to 'Done'
- Add comment with PR link
- Log time: 4 hours
- Transition related tasks to 'Closed'"

Claude will:
1. Update work item state
2. Add PR reference
3. Log completed work
4. Update dependencies
```

---

## Automation Workflows

### Workflow 1: Requirements → Work Items

**File:** `.github/workflows/create-work-items.yml`

```yaml
name: Create Azure DevOps Work Items from Requirements

on:
  push:
    paths:
      - 'docs/requirements/**/*.md'
    branches: [main]

jobs:
  create-work-items:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Get changed requirements
        id: requirements
        run: |
          changed_files=$(git diff --name-only HEAD^ HEAD | grep 'docs/requirements/')
          echo "files=$changed_files" >> $GITHUB_OUTPUT

      - name: Call Claude via API to create work items
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
          AZURE_DEVOPS_PAT: ${{ secrets.AZURE_DEVOPS_PAT }}
        run: |
          # Read requirements file
          requirements=$(cat ${{ steps.requirements.outputs.files }})

          # Call Claude API with MCP
          python scripts/create_work_items.py "$requirements"

      - name: Comment on commit
        uses: actions/github-script@v7
        with:
          script: |
            github.rest.repos.createCommitComment({
              owner: context.repo.owner,
              repo: context.repo.repo,
              commit_sha: context.sha,
              body: 'Azure DevOps work items created from requirements'
            })
```

### Workflow 2: PR → Update Work Item

**File:** `.github/workflows/update-work-item-on-pr.yml`

```yaml
name: Update Azure DevOps Work Item on PR

on:
  pull_request:
    types: [opened, closed]

jobs:
  update-work-item:
    runs-on: ubuntu-latest

    steps:
      - name: Extract work item ID from PR
        id: work-item
        run: |
          # Extract ID from PR title or branch name
          # Format: "AB#12345: Feature description"
          pr_title="${{ github.event.pull_request.title }}"
          work_item_id=$(echo "$pr_title" | grep -oP 'AB#\K\d+')
          echo "id=$work_item_id" >> $GITHUB_OUTPUT

      - name: Update work item
        if: steps.work-item.outputs.id != ''
        env:
          AZURE_DEVOPS_PAT: ${{ secrets.AZURE_DEVOPS_PAT }}
          AZURE_DEVOPS_ORG: ${{ secrets.AZURE_DEVOPS_ORG }}
          AZURE_DEVOPS_PROJECT: ${{ secrets.AZURE_DEVOPS_PROJECT }}
        run: |
          work_item_id="${{ steps.work-item.outputs.id }}"
          pr_url="${{ github.event.pull_request.html_url }}"
          pr_state="${{ github.event.pull_request.state }}"

          # Update work item via REST API
          if [ "$pr_state" = "closed" ] && [ "${{ github.event.pull_request.merged }}" = "true" ]; then
            # PR merged → mark work item as Done
            curl -X PATCH \
              -H "Content-Type: application/json-patch+json" \
              -H "Authorization: Basic $(echo -n :${AZURE_DEVOPS_PAT} | base64)" \
              -d '[
                {"op":"add","path":"/fields/System.State","value":"Done"},
                {"op":"add","path":"/fields/System.History","value":"PR merged: '"$pr_url"'"}
              ]' \
              "https://dev.azure.com/${AZURE_DEVOPS_ORG}/${AZURE_DEVOPS_PROJECT}/_apis/wit/workitems/${work_item_id}?api-version=7.0"
          fi
```

---

## Troubleshooting

### Issue: MCP Server Won't Start

**Symptoms:**
```
Error: Cannot find module 'azure-devops-node-api'
```

**Solution:**
```bash
cd ~/tools/azure-devops-mcp-server
npm install azure-devops-node-api
npm run build
npm run start
```

### Issue: Authentication Failed

**Symptoms:**
```
Error: TF400813: The user 'X' is not authorized to access this resource
```

**Solution:**
```bash
# 1. Verify PAT is correct
echo $AZURE_DEVOPS_PAT

# 2. Check PAT scopes in Azure DevOps
# Settings → Personal Access Tokens → View token scopes

# 3. Regenerate PAT with correct scopes:
# ✅ Work Items (Read, Write, Manage)

# 4. Update config
nano ~/.azure-devops-mcp/config.json
```

### Issue: Claude Can't Connect to MCP

**Symptoms:**
```
Claude response: "I don't have access to Azure DevOps"
```

**Solution:**
```bash
# 1. Check Claude config
cat ~/Library/Application\ Support/Claude/config.json

# 2. Verify MCP server is running
ps aux | grep azure-devops-mcp

# 3. Restart Claude Desktop
killall Claude
open -a Claude

# 4. Test connection
# In Claude: "Test Azure DevOps connection"
```

### Issue: Work Items Not Creating

**Symptoms:**
```
Error: Required field 'System.Title' is missing
```

**Solution:**
```
# Ensure all required fields are provided
Prompt to Claude:

"Create work item with:
Title: [required]
Description: [required]
Work Item Type: User Story [required]
Area Path: [your area]
Iteration Path: [your iteration]"
```

---

## Best Practices

### Security

1. **Never commit PAT to git**
   ```bash
   # Add to .gitignore
   echo '*.pat' >> .gitignore
   echo 'config.json' >> .gitignore
   ```

2. **Use short-lived PATs**
   - Set expiration to 30-90 days
   - Rotate regularly

3. **Limit PAT scope**
   - Only grant necessary permissions
   - Separate PATs for different purposes

4. **Use environment variables**
   ```bash
   # Don't hardcode in config files
   "personalAccessToken": "${AZURE_DEVOPS_PAT}"
   ```

### Work Item Management

1. **Use consistent naming**
   ```
   User Story: "As a [role], I want [feature] so that [benefit]"
   Task: "[Action] [component]" (e.g., "Implement Product Repository")
   Bug: "[Component] - [Issue]" (e.g., "ProductService - Null reference exception")
   ```

2. **Link related items**
   ```
   Prompt: "Create task for user story #12345:
   Title: Implement Product Repository
   Link: Child of #12345"
   ```

3. **Maintain hierarchy**
   ```
   Epic
   ├── Feature
   │   ├── User Story
   │   │   ├── Task
   │   │   └── Task
   │   └── User Story
   ```

4. **Use consistent areas and iterations**
   ```
   Area: ProductCatalog\Backend\API
   Iteration: ProductCatalog\Sprint 1
   ```

### Automation

1. **Automate repetitive tasks**
   - Create work items from requirements
   - Update work items on PR events
   - Generate reports

2. **Use templates**
   - User story templates
   - Task templates
   - Bug templates

3. **Implement validation**
   - Validate work item data before creation
   - Check for duplicates
   - Enforce standards

---

## Additional Resources

- [Azure DevOps REST API Documentation](https://docs.microsoft.com/en-us/rest/api/azure/devops/)
- [Model Context Protocol Specification](https://modelcontextprotocol.io/)
- [Claude API Documentation](https://docs.anthropic.com/claude/reference/)
- [Azure DevOps Node API](https://github.com/microsoft/azure-devops-node-api)

---

## ✅ Setup Checklist

- [ ] Azure DevOps organization created
- [ ] Personal Access Token generated
- [ ] PAT stored securely in environment variables
- [ ] MCP server installed
- [ ] MCP server configured with organization/project
- [ ] Claude Desktop installed
- [ ] Claude configured with MCP server
- [ ] Connection tested successfully
- [ ] Created test work item via Claude
- [ ] Automation workflows set up (optional)

---

**Next Steps:**

1. Complete setup following this guide
2. Test basic operations (create, update, query work items)
3. Integrate with Agent #6 (Requirements Analysis)
4. Integrate with Agent #11 (Sprint Planning)
5. Set up automation workflows
6. Train team on using Claude with Azure DevOps

**Support:** If you encounter issues not covered here, check Azure DevOps logs and MCP server logs for detailed error messages.
