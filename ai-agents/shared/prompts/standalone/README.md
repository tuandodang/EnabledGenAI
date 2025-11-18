# Standalone Prompt Files

Quick-copy prompt files for immediate use with AI agents.

---

## Purpose

This directory contains ready-to-use prompt files that you can:
1. Copy directly into Claude AI or Cursor
2. Customize with your specific requirements
3. Save as templates for your workflows

---

## How to Use

### Method 1: Copy from Individual Prompt Files

Each agent has its prompts in dedicated directories:

```
ai-agents/
├── architecture/
│   ├── agent-05-technical-documentation/prompts/
│   │   ├── 01-architecture-document.md
│   │   └── 02-adr-template.md
│   ├── agent-06-requirement-analysis/prompts/
│   │   └── 01-requirement-analysis.md
│   └── agent-07-drawing-diagrams/prompts/
│       └── 01-c4-diagrams.md
└── development/
    ├── agent-11-planning/prompts/
    │   └── 01-sprint-planning.md
    ├── agent-12-api-design/prompts/
    │   └── 01-api-design.md
    ├── agent-13-implementation/prompts/
    │   ├── 01-implementation-spring-boot.md
    │   └── 02-dotnet-implementation.md
    ├── agent-14-code-review/prompts/
    │   └── 01-comprehensive-review.md
    └── agent-15-unit-testing/prompts/
        ├── 01-junit-tests.md
        └── 02-xunit-tests.md
```

### Method 2: Use from Documentation

Comprehensive prompt library with all prompts:
```
ai-agents/docs/prompt-templates-library.md
```

### Method 3: Quick Start Examples

Step-by-step guide with prompt usage:
```
ai-agents/docs/complete-implementation-guide.md
```

---

## Quick Links

### For C#/.NET Developers

**Most Used Prompts:**

1. **API Design** → `development/agent-12-api-design/prompts/01-api-design.md`
2. **Implementation** → `development/agent-13-implementation/prompts/02-dotnet-implementation.md`
3. **Unit Tests** → `development/agent-15-unit-testing/prompts/02-xunit-tests.md`
4. **Code Review** → `development/agent-14-code-review/prompts/01-comprehensive-review.md`

### For Java/Spring Boot Developers

**Most Used Prompts:**

1. **API Design** → `development/agent-12-api-design/prompts/01-api-design.md`
2. **Implementation** → `development/agent-13-implementation/prompts/01-implementation-spring-boot.md`
3. **Unit Tests** → `development/agent-15-unit-testing/prompts/01-junit-tests.md`
4. **Code Review** → `development/agent-14-code-review/prompts/01-comprehensive-review.md`

---

## Usage Examples

### Example 1: Generate API Design

```bash
# 1. Navigate to prompt directory
cd ai-agents/development/agent-12-api-design/prompts

# 2. Open prompt file
cat 01-api-design.md

# 3. Copy entire content

# 4. Open Claude AI (claude.ai)

# 5. Paste prompt

# 6. Customize placeholders:
#    - [Your Project Name]
#    - [Your Framework]
#    - [Paste requirements]

# 7. Submit to Claude

# 8. Save output to your project
```

### Example 2: Generate Implementation Code (C#)

```bash
# 1. Open Cursor in your project
cursor .

# 2. Open Composer Mode: Cmd+I (Mac) or Ctrl+I (Windows)

# 3. Add file references
@openapi.yaml @.cursorrules

# 4. Copy prompt from:
cat ai-agents/development/agent-13-implementation/prompts/02-dotnet-implementation.md

# 5. Paste into Composer

# 6. Customize placeholders with your entity/feature details

# 7. Generate code

# 8. Review and refine
```

### Example 3: Generate Unit Tests

```bash
# 1. In Cursor, open Composer (Cmd+I)

# 2. Reference the code to test
@ProductService.cs @ProductRepository.cs @ProductsController.cs

# 3. Copy test prompt from:
cat ai-agents/development/agent-15-unit-testing/prompts/02-xunit-tests.md

# 4. Paste into Composer

# 5. Generate tests

# 6. Run: dotnet test

# 7. Fix any issues
```

---

## Customization Tips

### Tip 1: Save Your Customized Prompts

```bash
# Create your own prompts directory
mkdir -p ~/my-prompts

# Copy and customize
cp ai-agents/development/agent-13-implementation/prompts/02-dotnet-implementation.md \
   ~/my-prompts/my-implementation-prompt.md

# Edit with your preferences
nano ~/my-prompts/my-implementation-prompt.md
```

### Tip 2: Create Project-Specific Prompts

```bash
# In your project root
mkdir -p .ai-prompts

# Copy relevant prompts
cp ai-agents/development/agent-12-api-design/prompts/01-api-design.md \
   .ai-prompts/api-design.md

# Customize with project defaults
# Edit .ai-prompts/api-design.md:
# - Pre-fill framework: ASP.NET Core 8.0
# - Pre-fill database: SQL Server
# - Pre-fill authentication: JWT
```

### Tip 3: Use with Templates

```bash
# Combine .cursorrules with prompts
cp ai-agents/shared/templates/cursorrules-dotnet .cursorrules

# Now when you use Cursor:
# 1. Cursor reads .cursorrules automatically
# 2. Use prompts with @.cursorrules reference
# 3. Consistent code generation aligned with your standards
```

---

## Prompt Categories

### 🏗️ Architecture & Design

- **Technical Documentation** - Create architecture docs, ADRs
- **Requirements Analysis** - Transform business requirements to technical specs
- **Diagram Generation** - C4 models, UML, ERD in Mermaid

### 📋 Planning

- **Sprint Planning** - Break down features, estimate effort, allocate tasks

### 🚀 Development

- **API Design** - REST API design, OpenAPI specifications
- **Implementation** - Complete feature implementation (all layers)
- **Code Review** - Automated code quality and security review
- **Unit Testing** - Comprehensive test generation

---

## Multi-Agent Workflows

### Workflow 1: Complete Feature Implementation

```bash
# Step 1: Requirements → Technical Specs (30 min)
Agent #6 + requirement-analysis.md

# Step 2: Technical Specs → Architecture (1 hr)
Agent #5 + architecture-document.md

# Step 3: Architecture → API Design (1 hr)
Agent #12 + api-design.md

# Step 4: API Design → Implementation (4 hrs)
Agent #13 + dotnet-implementation.md (Cursor)

# Step 5: Code → Unit Tests (2 hrs)
Agent #15 + xunit-tests.md (Cursor)

# Step 6: Code Review (30 min)
Agent #14 + comprehensive-review.md

Total: 9 hours vs 110 hours traditional (92% savings!)
```

### Workflow 2: API-First Development

```bash
# Step 1: Requirements → API Design (1 hr)
Agent #6 + Agent #12

# Step 2: API → Implementation (3 hrs)
Agent #13 (Cursor)

# Step 3: Implementation → Tests (1.5 hrs)
Agent #15 (Cursor)

# Step 4: Review (30 min)
Agent #14

Total: 6 hours vs 50 hours traditional (88% savings!)
```

---

## Best Practices

### ✅ Do:

- Read the full prompt before using
- Customize placeholders with your specific details
- Provide complete context (requirements, constraints)
- Review and validate AI output
- Iterate if output is not perfect
- Save successful prompts for reuse

### ❌ Don't:

- Use prompts blindly without customization
- Skip reviewing generated output
- Commit generated code without testing
- Expect perfect output on first try
- Forget to provide necessary context

---

## Troubleshooting

### Issue: Prompt output is too generic

**Solution:**
- Add more specific context
- Include example inputs/outputs
- Specify exact framework versions
- Provide existing code patterns to follow

### Issue: Output is truncated in Claude

**Solution:**
- Type "Please continue from where you left off"
- Or upgrade to Claude Pro
- Or break request into smaller parts

### Issue: Cursor generated code won't compile

**Solution:**
- Be more specific about framework versions
- Reference existing working code with @mentions
- Include build configuration (.cursorrules)
- Ask Cursor to fix: "Fix compilation errors in [file]"

---

## Contributing

To add new prompts:

1. Create prompt in appropriate agent directory
2. Follow existing format
3. Test thoroughly
4. Add to this README
5. Commit changes

---

## Support

- **Full Documentation:** `ai-agents/INDEX.md`
- **Quick Start:** `ai-agents/docs/quick-start-guide.md`
- **Troubleshooting:** `ai-agents/docs/troubleshooting-guide.md`
- **Examples:** `ai-agents/docs/example-workflows.md`

---

**Pro Tip:** Bookmark the prompts you use most frequently for quick access!
