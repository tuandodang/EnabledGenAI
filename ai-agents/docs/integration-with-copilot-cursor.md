# GitHub Copilot & Cursor Integration Guide

**Version:** 1.0
**Last Updated:** November 18, 2024

---

## 📑 Table of Contents

1. [Integration Overview](#integration-overview)
2. [Tool Roles & Responsibilities](#tool-roles--responsibilities)
3. [Workflow Integration Patterns](#workflow-integration-patterns)
4. [Detailed Integration Examples](#detailed-integration-examples)
5. [Best Practices](#best-practices)
6. [Troubleshooting](#troubleshooting)

---

## Integration Overview

### How the Tools Work Together

The AI agent system is designed to work **in collaboration** with GitHub Copilot and Cursor, not as a replacement. Each tool serves a specific purpose in the development workflow:

```
┌─────────────────────────────────────────────────────────────────┐
│                    AI Agent Ecosystem                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │  Claude AI   │  │  Cursor AI   │  │   Copilot    │          │
│  │              │  │              │  │              │          │
│  │ Architecture │  │    Code      │  │   Inline     │          │
│  │   & Design   │  │  Generation  │  │ Assistance   │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
│         │                  │                  │                  │
│         └──────────────────┴──────────────────┘                  │
│                            │                                     │
│                    ┌───────▼────────┐                           │
│                    │   Your Code    │                           │
│                    └────────────────┘                           │
└─────────────────────────────────────────────────────────────────┘
```

### Integration Model

**Complementary, Not Competing:**
- **Claude AI** → Strategic thinking (architecture, design, requirements)
- **Cursor AI** → Tactical implementation (generating complete features)
- **GitHub Copilot** → Tactical assistance (completing lines, suggesting patterns)

---

## Tool Roles & Responsibilities

### 1. Claude AI (Agents #5, #6, #7, #11, #12, #14)

**Primary Use:** Strategic planning and analysis

**Agents:**
- **Agent #5** - Technical Documentation
- **Agent #6** - Requirements Analysis
- **Agent #7** - Diagram Generation
- **Agent #11** - Sprint Planning
- **Agent #12** - API Design
- **Agent #14** - Code Review

**When to Use:**
- ✅ Analyzing business requirements
- ✅ Designing system architecture
- ✅ Creating API specifications
- ✅ Generating documentation
- ✅ Planning sprints
- ✅ Reviewing code quality/security

**Tool:** Claude.ai web interface or API

**Output:** Documents, specifications, diagrams, reviews

---

### 2. Cursor AI (Agents #13, #15)

**Primary Use:** Multi-file code generation

**Agents:**
- **Agent #13** - Implementation
- **Agent #15** - Unit Testing

**When to Use:**
- ✅ Generating complete features (multiple files)
- ✅ Creating entire layers (controllers, services, repositories)
- ✅ Generating comprehensive unit tests
- ✅ Refactoring across multiple files
- ✅ Implementing based on specs from Claude

**Tool:** Cursor IDE with Composer mode (Cmd/Ctrl+I)

**Output:** Production code across multiple files

**Key Feature:** **Composer Mode**
- Can edit multiple files at once
- References context from multiple files
- Generates complete features end-to-end

---

### 3. GitHub Copilot (Real-time assistance)

**Primary Use:** Inline code suggestions

**When to Use:**
- ✅ Auto-completing single lines/methods
- ✅ Suggesting code patterns
- ✅ Writing similar code repeatedly
- ✅ Converting comments to code
- ✅ Quick fixes and small changes

**Tool:** IDE extension (VS Code, Visual Studio, JetBrains)

**Output:** Line-by-line suggestions

**Key Feature:** **Real-time suggestions**
- Works as you type
- Context-aware
- Language model predictions

---

## Workflow Integration Patterns

### Pattern 1: Complete Feature Development

**Workflow:** Claude → Cursor → Copilot

```
┌─────────────────────────────────────────────────────────┐
│ PHASE 1: Design (Claude AI)                             │
├─────────────────────────────────────────────────────────┤
│ Agent #6: Analyze requirements                          │
│ Agent #12: Design API (OpenAPI spec)                    │
│ Output: requirements.md, openapi.yaml                   │
└─────────────────────────────────────────────────────────┘
                         ▼
┌─────────────────────────────────────────────────────────┐
│ PHASE 2: Implementation (Cursor AI)                     │
├─────────────────────────────────────────────────────────┤
│ Agent #13: Generate complete feature                    │
│ Input: openapi.yaml, requirements.md, .cursorrules      │
│ Output: Controllers, Services, Repositories, DTOs       │
│ Tool: Cursor Composer Mode (Cmd+I)                      │
└─────────────────────────────────────────────────────────┘
                         ▼
┌─────────────────────────────────────────────────────────┐
│ PHASE 3: Refinement (GitHub Copilot)                    │
├─────────────────────────────────────────────────────────┤
│ • Add missing edge cases                                │
│ • Complete TODO comments                                │
│ • Add validation logic                                  │
│ • Inline suggestions as you type                        │
└─────────────────────────────────────────────────────────┘
                         ▼
┌─────────────────────────────────────────────────────────┐
│ PHASE 4: Testing (Cursor AI)                            │
├─────────────────────────────────────────────────────────┤
│ Agent #15: Generate unit tests                          │
│ Input: Generated code                                   │
│ Output: Comprehensive test suite                        │
│ Tool: Cursor Composer Mode                              │
└─────────────────────────────────────────────────────────┘
                         ▼
┌─────────────────────────────────────────────────────────┐
│ PHASE 5: Review (Claude AI)                             │
├─────────────────────────────────────────────────────────┤
│ Agent #14: Code review                                  │
│ Input: All generated code                               │
│ Output: Review report with issues                       │
└─────────────────────────────────────────────────────────┘
```

---

### Pattern 2: API-First Development

**Workflow:** Claude (API Design) → Cursor (Implementation) → Copilot (Refinement)

**Step 1: Claude AI - API Design (30 min)**

```bash
# Open Claude.ai
# Use Agent #12 prompt template

Prompt: "Design REST API for Product Management
- Framework: ASP.NET Core 8.0
- Database: SQL Server
- Auth: JWT
- Generate complete OpenAPI 3.0 spec"

Output: openapi.yaml
```

**Step 2: Cursor AI - Implementation (2 hours)**

```bash
# Open Cursor IDE
cd ProductCatalogAPI
cursor .

# Press Cmd+I (Composer Mode)
# Reference the API spec

@openapi.yaml @.cursorrules

[Paste Agent #13 implementation prompt]

Implement complete Product API based on the OpenAPI spec:
- Entity model
- DTOs (Request/Response)
- Repository pattern
- Service layer
- Controller with all endpoints
- Validation
- Error handling

Output: Complete feature (8-10 files)
```

**Step 3: GitHub Copilot - Refinement (30 min)**

```csharp
// Open ProductService.cs
// Add business logic with Copilot suggestions

public async Task<Result<ProductDto>> CreateAsync(CreateProductRequest request)
{
    // Type comment, Copilot suggests code:
    // Validate product name is unique

    // Copilot suggests:
    var exists = await _repository.ExistsByNameAsync(request.Name);
    if (exists)
    {
        return Result<ProductDto>.Failure("Product name already exists");
    }

    // Continue typing, Copilot assists...
}
```

**Step 4: Cursor AI - Testing (1 hour)**

```bash
# In Cursor Composer (Cmd+I)

@ProductService.cs @ProductRepository.cs @ProductController.cs

[Paste Agent #15 unit test prompt]

Generate comprehensive xUnit tests with:
- Moq for mocking
- FluentAssertions
- >85% coverage
- All scenarios (happy path, edge cases, errors)

Output: ProductServiceTests.cs (500+ lines)
```

---

### Pattern 3: Incremental Development

**Workflow:** Mix of all three tools

**Scenario:** Adding authentication to existing API

**Step 1: Design (Claude AI)**
```
Prompt to Claude:
"Design JWT authentication for existing Product API
- ASP.NET Core 8.0
- Refresh tokens
- Role-based authorization
- Provide implementation plan"

Output: Authentication design document
```

**Step 2: Scaffold (Cursor AI)**
```bash
# Cursor Composer
@ProductsController.cs @.cursorrules

Based on the authentication design, add JWT auth:
- Create JwtService
- Create AuthController (login, refresh)
- Add [Authorize] attributes to ProductsController
- Configure JWT in Program.cs

Output: 4 new files, 2 modified files
```

**Step 3: Complete Details (Copilot)**
```csharp
// In JwtService.cs
// Type method signature, let Copilot complete

public string GenerateToken(User user)
{
    // Copilot suggests entire method based on context
    var claims = new[]
    {
        new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
        new Claim(ClaimTypes.Email, user.Email),
        new Claim(ClaimTypes.Role, user.Role)
    };

    // Copilot continues suggesting...
}
```

**Step 4: Add Tests (Cursor AI)**
```bash
# Cursor Composer
@JwtService.cs @AuthController.cs

Generate unit tests for authentication:
- JwtService token generation/validation
- AuthController login/refresh endpoints
- Authorization attribute tests

Output: AuthServiceTests.cs, AuthControllerTests.cs
```

---

## Detailed Integration Examples

### Example 1: Using All Three Tools for Product CRUD

#### Step 1: Requirements & Design (Claude AI - 1 hour)

**Open:** https://claude.ai

**Prompt to Agent #6:**
```
Analyze this business requirement and create technical specs:

"We need a product management system where admins can create,
update, delete products. Products have name, description, price,
stock, and category. Support search and filtering by category
and price range. Pagination required for product lists."

Generate:
1. Functional requirements (FR-XXX format)
2. Non-functional requirements
3. Data model
4. API endpoints list
```

**Output:**
- `docs/requirements/product-management-requirements.md`
- Save this for next step

**Prompt to Agent #12:**
```
@product-management-requirements.md

Design REST API for product management:
- Framework: ASP.NET Core 8.0
- Generate OpenAPI 3.0 specification
- Include all CRUD operations
- Add search/filter endpoints
- Pagination support
```

**Output:**
- `docs/api/product-api-openapi.yaml`
- Validate at https://editor.swagger.io

---

#### Step 2: Implementation (Cursor AI - 3 hours)

**Open Cursor:**
```bash
cd ProductCatalogAPI
cursor .
```

**In Cursor, press Cmd+I (Composer Mode):**

```
@product-api-openapi.yaml @.cursorrules

[Copy entire Agent #13 implementation prompt from:
 ai-agents/development/agent-13-implementation/prompts/02-dotnet-implementation.md]

Implement Product management feature with:

Entity: Product (Id, Name, Description, Price, Stock, CategoryId)

Generate:
1. Domain/Entities/Product.cs
2. Application/DTOs/Product/CreateProductRequestDto.cs
3. Application/DTOs/Product/UpdateProductRequestDto.cs
4. Application/DTOs/Product/ProductResponseDto.cs
5. Application/DTOs/Product/ProductQueryDto.cs
6. Application/Interfaces/IProductService.cs
7. Application/Services/ProductService.cs
8. Domain/Repositories/IProductRepository.cs
9. Infrastructure/Repositories/ProductRepository.cs
10. API/Controllers/ProductsController.cs
11. Application/Mappings/ProductMappingProfile.cs
12. Application/Validators/CreateProductRequestValidator.cs
```

**Cursor generates all files!**

**Review generated code:**
```bash
# Build to check compilation
dotnet build

# Fix any issues with Cursor Chat
# Example: "Fix compilation error in ProductService.cs"
```

---

#### Step 3: Refinement (GitHub Copilot - 30 min)

Now open the generated files and add business logic details:

**In ProductService.cs:**

```csharp
public async Task<Result<ProductDto>> CreateAsync(
    CreateProductRequest request,
    CancellationToken ct)
{
    // Type comment:
    // Check if product name already exists in the same category

    // Copilot suggests:
    var existingProduct = await _repository
        .FindByNameAndCategoryAsync(request.Name, request.CategoryId, ct);

    if (existingProduct != null)
    {
        return Result<ProductDto>.Failure(
            $"Product '{request.Name}' already exists in this category");
    }

    // Type comment:
    // Validate category exists

    // Copilot suggests:
    var categoryExists = await _categoryRepository.ExistsAsync(
        request.CategoryId, ct);

    if (!categoryExists)
    {
        return Result<ProductDto>.Failure("Category not found");
    }

    // Continue... Copilot keeps suggesting!
}
```

**In ProductRepository.cs:**

```csharp
// Type method signature:
public async Task<Product?> FindByNameAndCategoryAsync(
    string name,
    Guid categoryId,
    CancellationToken ct)
{
    // Copilot completes entire method:
    return await _context.Products
        .FirstOrDefaultAsync(p =>
            p.Name == name &&
            p.CategoryId == categoryId &&
            !p.IsDeleted,
            ct);
}
```

**Benefits of Copilot here:**
- Auto-completes repetitive patterns
- Suggests LINQ queries
- Fills in parameter validation
- Completes similar methods quickly

---

#### Step 4: Testing (Cursor AI - 2 hours)

**Back to Cursor Composer (Cmd+I):**

```
@ProductService.cs @ProductRepository.cs @ProductsController.cs

[Copy Agent #15 xUnit test prompt from:
 ai-agents/development/agent-15-unit-testing/prompts/02-xunit-tests.md]

Generate comprehensive unit tests for Product feature:

1. ProductRepositoryTests.cs
   - Test all repository methods
   - Use InMemory database
   - Test pagination, filtering, search

2. ProductServiceTests.cs
   - Test all service methods
   - Mock repository with Moq
   - Test validation, error cases
   - Use FluentAssertions

3. ProductsControllerTests.cs
   - Test all controller actions
   - Mock service
   - Verify HTTP status codes
   - Test authorization

Target: >85% code coverage
```

**Cursor generates complete test suite!**

**Run tests:**
```bash
dotnet test

# Check coverage
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover

# Generate HTML report
reportgenerator -reports:coverage.opencover.xml -targetdir:coveragereport
open coveragereport/index.html
```

---

#### Step 5: Code Review (Claude AI - 15 min)

**Prepare code for review:**
```bash
# Collect all code
find . -name "*.cs" -type f | grep -E "(Product|product)" > product-files.txt

# Create single file with all code
while read file; do
    echo "=== $file ===" >> code-review.txt
    cat "$file" >> code-review.txt
    echo "" >> code-review.txt
done < product-files.txt
```

**In Claude.ai:**

```
[Copy Agent #14 code review prompt from:
 ai-agents/development/agent-14-code-review/prompts/01-comprehensive-review.md]

[Paste code-review.txt content]

Review this C# code for:
1. Security issues (OWASP Top 10)
2. Performance problems (N+1 queries, etc.)
3. SOLID violations
4. Error handling gaps
5. Code quality issues

Provide:
- Critical issues (fix immediately)
- High priority issues
- Suggestions for improvement
```

**Claude provides detailed review:**
```markdown
## Critical Issues

1. **ProductRepository.cs:45** - N+1 query problem
   Fix: Use .Include(p => p.Category) to eager load

2. **ProductService.cs:78** - Missing transaction
   Fix: Wrap create operation in transaction

## High Priority

1. **ProductController.cs:123** - Input validation
   Fix: Add [ValidateAntiForgeryToken]
...
```

**Fix issues with Copilot/Cursor assistance:**
```csharp
// Open ProductRepository.cs
// Fix N+1 issue - Copilot suggests:

public async Task<PagedResult<Product>> GetPagedAsync(
    ProductQueryDto query,
    CancellationToken ct)
{
    var queryable = _context.Products
        .Include(p => p.Category)  // ✅ Added - prevents N+1
        .Where(p => !p.IsDeleted)
        .AsQueryable();

    // ... rest of method
}
```

---

### Example 2: Quick Bug Fix Flow

**Scenario:** Fix null reference bug in ProductService

**Step 1: Identify (GitHub Copilot)**

```csharp
// Copilot highlights the issue as you type
public async Task<ProductDto> GetByIdAsync(Guid id)
{
    var product = await _repository.GetByIdAsync(id);

    // Copilot suggests null check:
    // var dto = _mapper.Map<ProductDto>(product);

    // Type "if" - Copilot suggests:
    if (product == null)
    {
        throw new NotFoundException($"Product {id} not found");
    }

    var dto = _mapper.Map<ProductDto>(product);
    return dto;
}
```

**Step 2: Add Tests (Cursor AI)**

```bash
# Cursor Composer
@ProductService.cs

Add test for null scenario:
- Test GetByIdAsync with non-existent ID
- Verify NotFoundException is thrown
- Use xUnit, Moq, FluentAssertions
```

**Step 3: Review (Claude AI - Optional)**

For critical bugs, run through Agent #14 to check for similar issues.

---

## Best Practices

### 1. When to Use Each Tool

| Scenario | Use | Why |
|----------|-----|-----|
| **Design new API** | Claude AI (Agent #12) | Strategic thinking, complete spec generation |
| **Implement API** | Cursor AI (Agent #13) | Multi-file generation, complete layers |
| **Complete method** | GitHub Copilot | Real-time, single method/line |
| **Generate tests** | Cursor AI (Agent #15) | Comprehensive test suites |
| **Review code** | Claude AI (Agent #14) | Deep analysis, security review |
| **Add validation** | GitHub Copilot | Pattern completion |
| **Refactor class** | Cursor AI | Multi-file awareness |
| **Fix typo** | GitHub Copilot | Inline suggestion |

### 2. Cursor Best Practices

**Use Composer Mode (Cmd+I) for:**
- ✅ Generating complete features
- ✅ Creating multiple related files
- ✅ Implementing from specifications
- ✅ Large refactorings

**Use Chat (Cmd+L) for:**
- ✅ Asking questions about code
- ✅ Explaining complex logic
- ✅ Getting quick fixes
- ✅ Code suggestions

**Reference files with @:**
```bash
# Good: Provide context
@openapi.yaml @.cursorrules @ProductService.cs

Generate ProductRepository based on service interface

# Bad: No context
Generate ProductRepository
```

### 3. Copilot Best Practices

**Write descriptive comments:**
```csharp
// Good - Copilot generates accurate code
// Calculate discount based on quantity: 10% for 10+, 20% for 50+, 30% for 100+

// Bad - Vague, poor suggestions
// Calculate discount
```

**Accept/reject strategically:**
- ✅ Accept for boilerplate (getters, setters, common patterns)
- ✅ Accept for repetitive code
- ⚠️ Review carefully for business logic
- ❌ Reject if doesn't match standards

**Use Tab to accept, Esc to reject:**
```csharp
public decimal CalculateDiscount(int quantity, decimal price)
{
    // Start typing "if", Copilot suggests:
    if (quantity >= 100)        // Press Tab if correct
        return price * 0.30m;

    // Continue, Copilot suggests next condition
    if (quantity >= 50)         // Press Tab
        return price * 0.20m;

    // Pattern recognition!
}
```

### 4. Integration Tips

**Tip 1: Start Big, Refine Small**
```
Claude (Design) → Cursor (Generate) → Copilot (Refine)
     ↓                ↓                    ↓
  Strategy        Bulk Creation      Detail Work
```

**Tip 2: Use .cursorrules**
```yaml
# Share standards across all tools
# Both Cursor and Copilot read this

# In .cursorrules:
- Use PascalCase for public members
- Use _camelCase for private fields
- Always use async/await
- Return Result<T> not exceptions
```

**Tip 3: Leverage Context**
```bash
# Cursor: References multiple files
@openapi.yaml @Product.cs @IProductService.cs

# Copilot: Uses open files in IDE
# Keep relevant files open in tabs
```

**Tip 4: Iterate**
```
1. Cursor generates 80% correct code
2. Build/test to find issues
3. Use Copilot to fix small issues
4. Use Cursor chat for larger fixes
5. Claude for design changes
```

---

## Troubleshooting

### Issue: Cursor generates code that doesn't compile

**Solution:**
```bash
# 1. Check .cursorrules is correct
cat .cursorrules

# 2. Provide more context
@.cursorrules @existing-working-file.cs

Implement new feature following patterns in existing-working-file.cs

# 3. Use Cursor Chat to fix
# Cmd+L: "Fix compilation errors in ProductService.cs"

# 4. Break into smaller prompts
# Instead of "implement entire feature"
# Do: "implement entity", then "implement repository", etc.
```

### Issue: Copilot suggestions don't match coding standards

**Solution:**
```yaml
# Update .cursorrules and restart IDE

# Add specific examples:
# Example of service method:
public async Task<Result<ProductDto>> GetByIdAsync(
    Guid id,
    CancellationToken ct = default)
{
    // Implementation
}
```

### Issue: Claude output too long/truncated

**Solution:**
```
# 1. Break into smaller prompts
# Instead of: "Design entire system"
# Do: "Design API endpoints for Product CRUD only"

# 2. Ask to continue
"Please continue from where you left off"

# 3. Upgrade to Claude Pro
# Longer responses, no truncation
```

### Issue: Tools giving conflicting suggestions

**Solution:**
```
Priority order:
1. .cursorrules (your standards)
2. Claude (strategic decisions)
3. Cursor (tactical generation)
4. Copilot (inline suggestions)

Your .cursorrules should be the source of truth!
```

---

## Quick Reference

### Tool Selection Decision Tree

```
Need to design/analyze?
  ├─ Yes → Claude AI
  │
  └─ No → Need to generate code?
      ├─ Multiple files? → Cursor AI (Composer)
      │
      └─ Single file/method? → Copilot or Cursor Chat
```

### Keyboard Shortcuts

**Cursor:**
- `Cmd+I` / `Ctrl+I` - Composer (multi-file)
- `Cmd+L` / `Ctrl+L` - Chat
- `Cmd+K` / `Ctrl+K` - Inline edit

**Copilot:**
- `Tab` - Accept suggestion
- `Esc` - Reject suggestion
- `Alt+]` - Next suggestion
- `Alt+[` - Previous suggestion

---

## Summary

### The Power of Integration

**Together, these tools:**
- ✅ **Claude** provides the "what" and "why" (design, architecture)
- ✅ **Cursor** provides the "how" (implementation)
- ✅ **Copilot** provides the "details" (refinement)

**Result:**
- 88% time savings on full development cycle
- Higher quality code (consistent patterns)
- Faster iterations
- Better documentation

**Remember:**
- Use the right tool for the right job
- Start strategic (Claude), go tactical (Cursor), finish detailed (Copilot)
- Let .cursorrules unify standards across all tools
- Iterate and refine

---

**Questions?**
- Check troubleshooting guide: `ai-agents/docs/troubleshooting-guide.md`
- Review complete workflow: `ai-agents/docs/complete-implementation-guide.md`
- See examples: `ai-agents/docs/example-workflows.md`
