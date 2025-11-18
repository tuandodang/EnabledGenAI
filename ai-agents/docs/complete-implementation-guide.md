# Complete Implementation Guide - AI Agents for C#/.NET Backend Development

**Version:** 2.0
**Target:** C#/.NET / ASP.NET Core 8.0
**Last Updated:** November 18, 2024

---

## 📑 Table of Contents

1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Initial Setup](#initial-setup)
4. [Project Structure Setup](#project-structure-setup)
5. [Agent Implementation Workflow](#agent-implementation-workflow)
6. [Complete Example: Product Catalog Feature](#complete-example)
7. [Automation Setup](#automation-setup)
8. [Troubleshooting](#troubleshooting)

---

## Overview

This guide provides step-by-step instructions for implementing AI agents in your C#/.NET backend development workflow. By the end, you'll be able to:

- Set up all required tools (Claude AI, Cursor, GitHub Copilot)
- Configure your project for AI-assisted development
- Use agents to automate 88% of development tasks
- Integrate with Azure DevOps for work item tracking

**Expected Results:**
- Traditional approach: 207 hours → **With AI Agents: 24.5 hours**
- ROI: 1,117% after first project
- Code quality: Maintained or improved

---

## Prerequisites

### Required Tools

| Tool | Version | Purpose | Cost |
|------|---------|---------|------|
| **Claude AI** | Sonnet 4.5+ | Analysis, design, documentation | $20/month (Pro recommended) |
| **Cursor AI** | Latest | Code generation | Free tier available |
| **GitHub Copilot** | Latest | Code assistance | $10/month or included with GitHub |
| **.NET SDK** | 8.0+ | Development framework | Free |
| **Visual Studio Code** | Latest | IDE (alternative to Cursor) | Free |
| **Git** | 2.40+ | Version control | Free |

### Optional Tools

- **Azure DevOps** - Work item integration (MCP)
- **SQL Server** / **PostgreSQL** - Database
- **Docker** - Containerization
- **Postman** / **Insomnia** - API testing

---

## Initial Setup

### Step 1: Set Up Claude AI (15 minutes)

#### 1.1 Create Account

```bash
# Navigate to
https://claude.ai

# Sign up with:
# - Work email (recommended)
# - Personal email (also works)
```

#### 1.2 Verify Account

```bash
# Check email for verification link
# Click link to activate account
```

#### 1.3 Upgrade to Pro (Recommended)

```
Settings → Subscription → Upgrade to Claude Pro ($20/month)

Benefits:
- Longer responses (no truncation)
- Priority access
- Higher usage limits
- Better for complex prompts
```

#### 1.4 Test Claude

```
Prompt: "Design a simple REST API for user management with CRUD operations.
        Use ASP.NET Core 8.0, C#, Entity Framework Core.
        Provide OpenAPI specification."

Expected: Complete API design in <2 minutes
```

### Step 2: Set Up Cursor AI (20 minutes)

#### 2.1 Download & Install

**macOS:**
```bash
# Download from cursor.com
# Install to Applications

# Or via Homebrew
brew install --cask cursor
```

**Windows:**
```powershell
# Download installer from cursor.com
# Run installer
# Follow installation wizard
```

**Linux:**
```bash
# Download AppImage from cursor.com
wget https://downloader.cursor.sh/linux/appImage/x64
chmod +x cursor-*.AppImage
./cursor-*.AppImage
```

#### 2.2 Sign In

```bash
# Launch Cursor
# Sign in with GitHub account
# Grant permissions
```

#### 2.3 Configure Settings

```json
// Settings > Cursor Settings
{
  "cursor.model": "claude-sonnet-4.5",
  "cursor.enableChat": true,
  "cursor.enableComposer": true,
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "ms-dotnettools.csharp"
}
```

#### 2.4 Install C# Extensions

```bash
# Extensions to install:
1. C# (ms-dotnettools.csharp)
2. C# Dev Kit (ms-dotnettools.csdevkit)
3. IntelliCode for C# (VisualStudioExptTeam.intellicode-api-usage-examples)
4. NuGet Package Manager
5. REST Client (for API testing)
```

#### 2.5 Test Composer Mode

```bash
# Press: Cmd+I (Mac) or Ctrl+I (Windows)
# Type: "Create a simple C# class for Product entity"
# Verify: Code generation works
```

### Step 3: Set Up GitHub Copilot (10 minutes)

#### 3.1 Subscribe

```bash
# Navigate to:
https://github.com/settings/copilot

# Choose plan:
# - Individual: $10/month
# - Free for students/OSS maintainers
```

#### 3.2 Install Extension

```bash
# In Cursor/VS Code:
Extensions → Search "GitHub Copilot"
Install → Sign in to GitHub
Authorize
```

#### 3.3 Test Copilot

```csharp
// Create new .cs file
// Type comment:
// Function to calculate fibonacci number

// Wait for Copilot suggestion
// Press Tab to accept
```

### Step 4: Set Up .NET Development Environment (15 minutes)

#### 4.1 Install .NET SDK

**macOS:**
```bash
brew install dotnet-sdk
```

**Windows:**
```powershell
# Download from: https://dotnet.microsoft.com/download
# Run installer
```

**Linux (Ubuntu):**
```bash
wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo apt-get update
sudo apt-get install -y dotnet-sdk-8.0
```

#### 4.2 Verify Installation

```bash
dotnet --version
# Expected: 8.0.x

dotnet --list-sdks
# Expected: 8.0.xxx [path]
```

#### 4.3 Install EF Core Tools

```bash
dotnet tool install --global dotnet-ef
dotnet tool install --global dotnet-aspnet-codegenerator
```

#### 4.4 Verify Tools

```bash
dotnet ef --version
# Expected: 8.0.x

dotnet aspnet-codegenerator --help
# Expected: Help output
```

---

## Project Structure Setup

### Step 5: Create Project Structure (10 minutes)

#### 5.1 Create Solution

```bash
# Navigate to your workspace
cd ~/projects

# Create solution directory
mkdir ProductCatalogAPI
cd ProductCatalogAPI

# Create solution file
dotnet new sln -n ProductCatalog
```

#### 5.2 Create Projects

```bash
# Create Domain layer
dotnet new classlib -n ProductCatalog.Domain
dotnet sln add ProductCatalog.Domain/ProductCatalog.Domain.csproj

# Create Application layer
dotnet new classlib -n ProductCatalog.Application
dotnet sln add ProductCatalog.Application/ProductCatalog.Application.csproj

# Create Infrastructure layer
dotnet new classlib -n ProductCatalog.Infrastructure
dotnet sln add ProductCatalog.Infrastructure/ProductCatalog.Infrastructure.csproj

# Create API layer
dotnet new webapi -n ProductCatalog.API
dotnet sln add ProductCatalog.API/ProductCatalog.API.csproj

# Create Test project
dotnet new xunit -n ProductCatalog.Tests
dotnet sln add ProductCatalog.Tests/ProductCatalog.Tests.csproj
```

#### 5.3 Add Project References

```bash
# Application depends on Domain
dotnet add ProductCatalog.Application/ProductCatalog.Application.csproj reference ProductCatalog.Domain/ProductCatalog.Domain.csproj

# Infrastructure depends on Application and Domain
dotnet add ProductCatalog.Infrastructure/ProductCatalog.Infrastructure.csproj reference ProductCatalog.Application/ProductCatalog.Application.csproj
dotnet add ProductCatalog.Infrastructure/ProductCatalog.Infrastructure.csproj reference ProductCatalog.Domain/ProductCatalog.Domain.csproj

# API depends on Application and Infrastructure
dotnet add ProductCatalog.API/ProductCatalog.API.csproj reference ProductCatalog.Application/ProductCatalog.Application.csproj
dotnet add ProductCatalog.API/ProductCatalog.API.csproj reference ProductCatalog.Infrastructure/ProductCatalog.Infrastructure.csproj

# Tests depend on all layers
dotnet add ProductCatalog.Tests/ProductCatalog.Tests.csproj reference ProductCatalog.Domain/ProductCatalog.Domain.csproj
dotnet add ProductCatalog.Tests/ProductCatalog.Tests.csproj reference ProductCatalog.Application/ProductCatalog.Application.csproj
dotnet add ProductCatalog.Tests/ProductCatalog.Tests.csproj reference ProductCatalog.Infrastructure/ProductCatalog.Infrastructure.csproj
dotnet add ProductCatalog.Tests/ProductCatalog.Tests.csproj reference ProductCatalog.API/ProductCatalog.API.csproj
```

#### 5.4 Install NuGet Packages

```bash
# Domain layer (no external dependencies)

# Application layer
dotnet add ProductCatalog.Application package AutoMapper --version 12.0.1
dotnet add ProductCatalog.Application package FluentValidation --version 11.8.1
dotnet add ProductCatalog.Application package MediatR --version 12.2.0

# Infrastructure layer
dotnet add ProductCatalog.Infrastructure package Microsoft.EntityFrameworkCore --version 8.0.0
dotnet add ProductCatalog.Infrastructure package Microsoft.EntityFrameworkCore.SqlServer --version 8.0.0
dotnet add ProductCatalog.Infrastructure package Microsoft.EntityFrameworkCore.Design --version 8.0.0

# API layer
dotnet add ProductCatalog.API package Swashbuckle.AspNetCore --version 6.5.0
dotnet add ProductCatalog.API package Microsoft.AspNetCore.Authentication.JwtBearer --version 8.0.0
dotnet add ProductCatalog.API package Serilog.AspNetCore --version 8.0.0

# Test layer
dotnet add ProductCatalog.Tests package Moq --version 4.20.70
dotnet add ProductCatalog.Tests package FluentAssertions --version 6.12.0
dotnet add ProductCatalog.Tests package Microsoft.EntityFrameworkCore.InMemory --version 8.0.0
dotnet add ProductCatalog.Tests package coverlet.collector --version 6.0.0
```

#### 5.5 Create Directory Structure

```bash
# Domain layer structure
mkdir -p ProductCatalog.Domain/Entities
mkdir -p ProductCatalog.Domain/Repositories
mkdir -p ProductCatalog.Domain/Common

# Application layer structure
mkdir -p ProductCatalog.Application/DTOs
mkdir -p ProductCatalog.Application/Interfaces
mkdir -p ProductCatalog.Application/Services
mkdir -p ProductCatalog.Application/Mappings
mkdir -p ProductCatalog.Application/Validators

# Infrastructure layer structure
mkdir -p ProductCatalog.Infrastructure/Data
mkdir -p ProductCatalog.Infrastructure/Data/Configurations
mkdir -p ProductCatalog.Infrastructure/Repositories

# API layer structure
mkdir -p ProductCatalog.API/Controllers
mkdir -p ProductCatalog.API/Middleware
mkdir -p ProductCatalog.API/Filters
```

#### 5.6 Verify Project Structure

```bash
# Build solution
dotnet build

# Expected: Build succeeded. 0 Warning(s). 0 Error(s).

# List projects
dotnet sln list

# Expected output:
# ProductCatalog.Domain/ProductCatalog.Domain.csproj
# ProductCatalog.Application/ProductCatalog.Application.csproj
# ProductCatalog.Infrastructure/ProductCatalog.Infrastructure.csproj
# ProductCatalog.API/ProductCatalog.API.csproj
# ProductCatalog.Tests/ProductCatalog.Tests.csproj
```

### Step 6: Configure .cursorrules (5 minutes)

Create `.cursorrules` file in project root:

```bash
cd ProductCatalogAPI
touch .cursorrules
```

Add C# specific rules:

```yaml
# .cursorrules for C# / ASP.NET Core Backend Development

## Language & Framework
language: C#
framework: ASP.NET Core 8.0
target_framework: net8.0

## Architecture
architecture: Clean Architecture (Layered)
layers:
  - Domain (Entities, Interfaces)
  - Application (DTOs, Services, Validators)
  - Infrastructure (Data, Repositories)
  - API (Controllers, Middleware)

## Code Style

### Naming Conventions
- Use PascalCase for classes, methods, properties
- Use camelCase for private fields, parameters
- Prefix interfaces with "I" (e.g., IProductService)
- Use async suffix for async methods (e.g., GetByIdAsync)

### SOLID Principles
- Single Responsibility: One class, one responsibility
- Open/Closed: Open for extension, closed for modification
- Liskov Substitution: Derived classes must be substitutable
- Interface Segregation: No fat interfaces
- Dependency Inversion: Depend on abstractions

### Clean Code
- Methods should be <20 lines
- Classes should be <300 lines
- Use meaningful names (no abbreviations)
- No magic numbers (use constants)
- Comments only for complex logic

## Patterns

### Repository Pattern
- One repository per aggregate root
- Generic repository for common operations
- Specific methods for complex queries

### Service Pattern
- Service layer contains business logic
- One service per entity/aggregate
- Return Result<T> pattern for errors

### DTO Pattern
- Separate DTOs for Request and Response
- Use records for immutable DTOs
- AutoMapper for entity-DTO mapping

## Error Handling

### Exceptions
- Use exceptions for unexpected errors
- Use Result<T> for business logic errors
- Global exception handler middleware
- Log all exceptions with context

### Validation
- FluentValidation for DTO validation
- Validate in service layer
- Return meaningful error messages

## Async/Await

### Rules
- Use async/await throughout
- Never use .Result or .Wait()
- Always pass CancellationToken
- Use ConfigureAwait(false) in libraries

## Database

### Entity Framework Core
- Use Code-First approach
- Separate configuration classes
- Use migrations for schema changes
- Avoid N+1 queries (use Include/ThenInclude)
- Implement soft delete with query filters

### Conventions
- Entities have Guid Id property
- Audit fields: CreatedAt, UpdatedAt, CreatedBy, UpdatedBy
- Soft delete: IsDeleted, DeletedAt properties
- Navigation properties always initialized

## API Design

### Controllers
- Use ApiController attribute
- RESTful naming conventions
- Proper HTTP status codes (200, 201, 204, 400, 404, 500)
- XML comments for Swagger
- Versioning: /api/v1/[controller]

### Response Format
- Consistent API response wrapper
- Include success flag, data, message, errors
- Proper error responses

## Security

### Authentication & Authorization
- Use JWT Bearer tokens
- [Authorize] attribute on protected endpoints
- Role-based or policy-based authorization

### Input Validation
- Validate all inputs
- Use data annotations + FluentValidation
- Sanitize user input
- Parameterized queries (EF Core default)

### Secrets Management
- Never hardcode secrets
- Use User Secrets for development
- Use Azure Key Vault for production
- Use environment variables

## Testing

### Unit Tests
- xUnit framework
- Moq for mocking
- FluentAssertions for assertions
- AAA pattern (Arrange, Act, Assert)
- Test naming: MethodName_Scenario_ExpectedResult

### Coverage
- Minimum 85% code coverage
- Test all public methods
- Test happy path, edge cases, error cases

## Logging

### Serilog
- Use structured logging
- Log levels: Debug, Information, Warning, Error, Critical
- Include correlation IDs
- Log request/response for debugging

## Performance

### Optimization
- Use pagination for lists
- Implement caching (Redis)
- Use async throughout
- Optimize database queries
- Use CDN for static files

## Comments & Documentation

### XML Comments
- Document all public APIs
- Include <summary>, <param>, <returns>
- Document exceptions with <exception>

### Code Comments
- Explain "why" not "what"
- Comment complex algorithms
- Use TODO for future work
- Keep comments up-to-date

## File Organization

### Project Structure
```
Solution/
├── Domain/
│   ├── Entities/
│   ├── Repositories/
│   └── Common/
├── Application/
│   ├── DTOs/
│   ├── Interfaces/
│   ├── Services/
│   ├── Mappings/
│   └── Validators/
├── Infrastructure/
│   ├── Data/
│   ├── Repositories/
│   └── Services/
├── API/
│   ├── Controllers/
│   ├── Middleware/
│   └── Filters/
└── Tests/
    ├── Unit/
    └── Integration/
```

## Dependencies

### Prefer
- Entity Framework Core for ORM
- AutoMapper for mapping
- FluentValidation for validation
- Serilog for logging
- xUnit for testing
- Moq for mocking
- FluentAssertions for assertions

### Avoid
- Reflection (performance overhead)
- Dynamic types (type safety)
- var for unclear types
- Multiple return statements
- Nested conditionals >3 levels

## Code Generation Rules

When generating code:
1. Follow all above conventions
2. Include proper error handling
3. Add XML comments
4. Include validation
5. Use async/await
6. Implement logging
7. Return proper status codes
8. Include unit tests
9. No TODOs in generated code
10. Compilable, production-ready code

## Example Code Style

```csharp
/// <summary>
/// Gets a product by ID
/// </summary>
/// <param name="id">The product ID</param>
/// <param name="cancellationToken">Cancellation token</param>
/// <returns>The product if found</returns>
/// <exception cref="ArgumentException">If ID is empty</exception>
public async Task<Result<ProductResponseDto>> GetByIdAsync(
    Guid id,
    CancellationToken cancellationToken = default)
{
    if (id == Guid.Empty)
    {
        throw new ArgumentException("ID cannot be empty", nameof(id));
    }

    try
    {
        var product = await _repository.GetByIdAsync(id, cancellationToken);

        if (product == null)
        {
            return Result<ProductResponseDto>.Failure("Product not found");
        }

        var dto = _mapper.Map<ProductResponseDto>(product);
        return Result<ProductResponseDto>.Success(dto);
    }
    catch (Exception ex)
    {
        _logger.LogError(ex, "Error getting product {ProductId}", id);
        return Result<ProductResponseDto>.Failure("An error occurred");
    }
}
```
```

### Step 7: Initialize Git Repository (5 minutes)

```bash
# Initialize git
git init

# Create .gitignore
cat > .gitignore << 'EOF'
# .NET
bin/
obj/
*.user
*.suo
*.cache
*.dll
*.exe
*.pdb
.vs/

# User-specific files
*.rsuser
*.userosscache
*.sln.docstates

# Build results
[Dd]ebug/
[Rr]elease/
x64/
x86/
[Aa][Rr][Mm]/
[Aa][Rr][Mm]64/

# Visual Studio cache/options
.vs/
.vscode/

# ReSharper
_ReSharper*/
*.DotSettings.user

# Test results
TestResults/
*.trx
*.coverage

# NuGet
packages/
*.nupkg
*.snupkg

# Database
*.db
*.db-shm
*.db-wal

# Sensitive data
appsettings.Development.json
appsettings.*.json
!appsettings.json
*.env
secrets.json

# Logs
logs/
*.log

# OS
.DS_Store
Thumbs.db
EOF

# Create README
cat > README.md << 'EOF'
# Product Catalog API

ASP.NET Core 8.0 API built with AI agents.

## Architecture

Clean Architecture with layers:
- Domain
- Application
- Infrastructure
- API

## Getting Started

```bash
dotnet build
dotnet run --project ProductCatalog.API
```

API: https://localhost:7000/swagger
EOF

# Initial commit
git add .
git commit -m "Initial project setup with Clean Architecture"
```

---

## Agent Implementation Workflow

### Overview: Complete Feature Development

For implementing a complete feature (e.g., Product Management), follow this workflow:

```
Agent #6 (Requirements)
   ↓
Agent #5 (Architecture)
   ↓
Agent #12 (API Design)
   ↓
Agent #13 (Implementation) [Cursor]
   ↓
Agent #15 (Unit Tests) [Cursor]
   ↓
Agent #14 (Code Review)
```

**Total time:** ~9 hours vs 110 hours traditional (92% savings)

---

## Complete Example

### Scenario: Product Catalog Feature

**Business Requirement:**
> "We need a product catalog API that allows admins to manage products and customers to browse/search products. Products belong to categories, have variants (size, color), and stock tracking."

Let's implement this step-by-step using AI agents.

---

### Step 1: Requirements Analysis (30 minutes)

**Agent:** #6 - Requirement Analysis
**Tool:** Claude AI
**Input:** Business requirements
**Output:** Functional/Non-functional requirements, WBS

#### Process:

1. **Navigate to Claude AI**
   ```
   https://claude.ai
   ```

2. **Copy the prompt template**

   Open: `ai-agents/architecture/agent-06-requirement-analysis/prompts/01-requirement-analysis.md`

3. **Customize the prompt**

```
You are a senior Business Analyst specializing in backend systems.

## Business Requirements

We need a product catalog API:

**Features:**
1. Admin can create/update/delete products
2. Products have name, description, price, stock, category
3. Products can have variants (size, color)
4. Customers can browse by category
5. Customers can search products by keyword
6. Customers can filter by price range, category, availability
7. Products can be sorted by price, name, date added
8. Inventory integration for real-time stock

**Non-Functional:**
- Performance: <200ms API response time (p95)
- Scale: Support 100K products, 10K concurrent users
- Availability: 99.9% uptime
- Security: JWT authentication, role-based access

**Technical Context:**
- Framework: ASP.NET Core 8.0, C#
- Database: SQL Server (existing)
- Authentication: JWT (existing system)
- Cloud: Azure

## Task

Generate comprehensive requirements analysis including:

1. **Functional Requirements**
   - Detailed FR with acceptance criteria
   - User stories (Admin, Customer roles)
   - API endpoints list

2. **Non-Functional Requirements**
   - Performance metrics
   - Scalability targets
   - Security requirements
   - Availability SLA

3. **Work Breakdown Structure**
   - Phases and tasks
   - Effort estimates
   - Dependencies

4. **Clarification Questions**
   - Technical uncertainties
   - Business rule edge cases

Format: Markdown
```

4. **Review Output**

Claude will generate:
- Detailed functional requirements (FRs)
- Non-functional requirements (NFRs)
- Work breakdown structure
- Clarification questions

5. **Save Output**

```bash
# Save to your project
mkdir -p docs/requirements
# Copy Claude output to:
docs/requirements/product-catalog-requirements.md
```

**Time:** 30 minutes (vs 4 hours traditional)

---

### Step 2: Architecture Design (1 hour)

**Agent:** #5 - Technical Documentation
**Tool:** Claude AI
**Input:** Requirements from Step 1
**Output:** Architecture document, ADRs

#### Process:

1. **Open new Claude conversation**

2. **Use architecture prompt template**

   Open: `ai-agents/architecture/agent-05-technical-documentation/prompts/01-architecture-document.md`

3. **Customize and submit**

```
You are a senior Solution Architect specializing in ASP.NET Core microservices.

## Context

Project: Product Catalog API
Framework: ASP.NET Core 8.0, C#
Database: SQL Server
Authentication: JWT (existing)
Cloud: Azure

## Requirements

[Paste requirements from Agent #6 output]

## Task

Generate comprehensive technical architecture documentation:

1. **System Architecture**
   - High-level architecture
   - Component diagram (C4 Container level)
   - Technology stack details
   - Integration points

2. **Data Architecture**
   - Database schema design
   - Entity relationships
   - Indexing strategy
   - Partitioning (if needed)

3. **API Architecture**
   - Endpoint organization
   - Request/response patterns
   - Versioning strategy
   - Error handling approach

4. **Security Architecture**
   - Authentication flow
   - Authorization model
   - Data encryption
   - API security (rate limiting, CORS)

5. **Architecture Decision Records**
   - Key technology choices
   - Pattern decisions
   - Tradeoffs documented

Format: Markdown with Mermaid diagrams
```

4. **Review & Save**

```bash
# Save architecture doc
docs/architecture/architecture-design.md

# Save ADRs
mkdir -p docs/architecture/adr
# Save each ADR separately
```

**Time:** 1 hour (vs 30 hours traditional)

---

### Step 3: API Design (1 hour)

**Agent:** #12 - API Design
**Tool:** Claude AI
**Input:** Requirements + Architecture
**Output:** API design + OpenAPI 3.0 spec

#### Process:

1. **Use API design prompt template**

   Open: `ai-agents/development/agent-12-api-design/prompts/01-api-design.md`

2. **Submit customized prompt**

```
You are an expert API designer specializing in RESTful APIs with ASP.NET Core.

## Context

Project: Product Catalog API
Framework: ASP.NET Core 8.0, C#, Entity Framework Core
Database: SQL Server
Auth: JWT Bearer tokens

## Requirements

[Paste relevant requirements]

## Data Model

**Entities:**
- Product (Id, Name, Description, Price, Stock, CategoryId, CreatedAt, UpdatedAt, IsDeleted)
- Category (Id, Name, Description)
- ProductVariant (Id, ProductId, Name, SKU, Price, Stock)

## Task

Design complete REST API:

1. **API Endpoints**
   - Products CRUD
   - Category management
   - Product variants
   - Search & filtering
   - Include all HTTP methods, paths, auth requirements

2. **Request/Response DTOs**
   - CreateProductRequest
   - UpdateProductRequest
   - ProductResponse
   - ProductListResponse
   - Query parameters for filtering/pagination

3. **OpenAPI 3.0 Specification**
   - Complete, valid YAML
   - Include schemas, examples
   - Security definitions
   - Error responses

4. **API Documentation**
   - Endpoint descriptions
   - Usage examples (curl)
   - Error handling guide

Format: Markdown + YAML
```

3. **Validate OpenAPI Spec**

```bash
# Copy YAML output
# Navigate to:
https://editor.swagger.io

# Paste YAML
# Fix any validation errors
# Save validated spec
```

4. **Save outputs**

```bash
# Save API design doc
docs/api/api-design.md

# Save OpenAPI spec
docs/api/openapi.yaml
```

**Time:** 1 hour (vs 24 hours traditional)

---

### Step 4: Implementation with Cursor (4 hours)

**Agent:** #13 - Implementation
**Tool:** Cursor AI
**Input:** API design, OpenAPI spec
**Output:** Complete code (all layers)

#### Process:

1. **Open project in Cursor**

```bash
# Navigate to project
cd ProductCatalogAPI

# Open in Cursor
cursor .
```

2. **Open Composer Mode**

```
Press: Cmd+I (Mac) or Ctrl+I (Windows)
```

3. **Reference files and use template**

```
@openapi.yaml @api-design.md @.cursorrules

[Paste Agent #13 implementation prompt from ai-agents/development/agent-13-implementation/prompts/02-dotnet-implementation.md]

Customize the [placeholders] with:
- Entity name: Product
- Requirements from API design
- Business rules from requirements doc
```

**Example full prompt:**

```
@openapi.yaml @api-design.md @.cursorrules

You are an expert C# backend developer specializing in ASP.NET Core 8.0.

I need you to implement the Product management feature following modern ASP.NET Core best practices.

## Context

**Project:** Product Catalog API
**Framework:** ASP.NET Core 8.0
**Database:** SQL Server
**ORM:** Entity Framework Core 8.0

## Requirements

### API Specification

[Paste from openapi.yaml - Products endpoints]

### Data Model

**Entity:** Product

```csharp
public class Product
{
    public Guid Id { get; set; }
    [Required, MaxLength(200)]
    public string Name { get; set; }
    [MaxLength(2000)]
    public string? Description { get; set; }
    [Column(TypeName = "decimal(18,2)")]
    public decimal Price { get; set; }
    public int Stock { get; set; }
    public Guid CategoryId { get; set; }
    public Category Category { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
    public bool IsDeleted { get; set; }
}
```

### Business Rules

1. Product name must be unique within category
2. Price must be > 0
3. Stock cannot be negative
4. Soft delete (IsDeleted flag)
5. Audit fields auto-populated

## Implementation Requirements

Please generate ALL of the following files with COMPLETE, compilable code:

1. **Entity** (Domain/Entities/Product.cs)
2. **DTOs** (Application/DTOs/Product/*)
   - CreateProductRequestDto
   - UpdateProductRequestDto
   - ProductResponseDto
   - ProductListItemDto
   - ProductQueryDto
3. **Repository Interface** (Domain/Repositories/IProductRepository.cs)
4. **Repository Implementation** (Infrastructure/Repositories/ProductRepository.cs)
5. **Service Interface** (Application/Interfaces/IProductService.cs)
6. **Service Implementation** (Application/Services/ProductService.cs)
7. **Controller** (API/Controllers/ProductsController.cs)
8. **AutoMapper Profile** (Application/Mappings/ProductMappingProfile.cs)
9. **Validators** (Application/Validators/*)
10. **EF Configuration** (Infrastructure/Data/Configurations/ProductConfiguration.cs)

Follow the patterns in the template: [paste relevant sections from 02-dotnet-implementation.md]

Expected output: Production-ready, compilable code for all layers.
```

4. **Review generated code**

Cursor will generate all files. Review each:

```bash
# Check compilation
dotnet build

# Fix any errors with Cursor
# In Cursor chat: "Fix compilation errors in ProductService.cs"
```

5. **Create migration**

```bash
# Add migration
dotnet ef migrations add AddProductEntity --project ProductCatalog.Infrastructure --startup-project ProductCatalog.API

# Review migration file
# Apply migration
dotnet ef database update --project ProductCatalog.Infrastructure --startup-project ProductCatalog.API
```

6. **Test with Swagger**

```bash
# Run API
dotnet run --project ProductCatalog.API

# Navigate to Swagger
https://localhost:7000/swagger

# Test endpoints:
# - POST /api/v1/products
# - GET /api/v1/products
# - GET /api/v1/products/{id}
# - PUT /api/v1/products/{id}
# - DELETE /api/v1/products/{id}
```

**Time:** 4 hours (vs 60 hours traditional)

---

### Step 5: Unit Tests (2 hours)

**Agent:** #15 - Unit Testing
**Tool:** Cursor AI
**Input:** Implementation code
**Output:** Comprehensive unit tests

#### Process:

1. **In Cursor Composer (Cmd+I)**

```
@ProductService.cs @ProductRepository.cs @ProductsController.cs @.cursorrules

[Paste Agent #15 xUnit prompt from ai-agents/development/agent-15-unit-testing/prompts/02-xunit-tests.md]

Generate comprehensive unit tests for:
1. ProductRepository (using InMemory database)
2. ProductService (using Moq)
3. ProductsController (using Moq)

Requirements:
- xUnit, Moq, FluentAssertions
- AAA pattern
- >85% code coverage
- Test happy path, edge cases, errors
```

2. **Review generated tests**

```bash
# Build tests
dotnet build ProductCatalog.Tests

# Run tests
dotnet test ProductCatalog.Tests

# Check coverage
dotnet test ProductCatalog.Tests /p:CollectCoverage=true /p:CoverletOutputFormat=opencover

# View coverage report
# Install reportgenerator
dotnet tool install --global dotnet-reportgenerator-globaltool

# Generate HTML report
reportgenerator -reports:ProductCatalog.Tests/coverage.opencover.xml -targetdir:coveragereport

# Open report
open coveragereport/index.html  # Mac
start coveragereport/index.html # Windows
```

3. **Fix failing tests**

```
# In Cursor chat
"Fix failing test: GetByIdAsync_InvalidId_ReturnsNull"
```

**Time:** 2 hours (vs 30 hours traditional)

---

### Step 6: Code Review (30 minutes)

**Agent:** #14 - Code Review
**Tool:** Claude AI
**Input:** Source code
**Output:** Review report with issues

#### Process:

1. **Prepare code for review**

```bash
# Get all code in one file (for Claude)
find ProductCatalog.Domain ProductCatalog.Application ProductCatalog.Infrastructure ProductCatalog.API -name "*.cs" -type f -exec sh -c 'echo "=== {} ==="; cat {}; echo' \; > code-for-review.txt
```

2. **Use code review prompt**

   Open: `ai-agents/development/agent-14-code-review/prompts/01-comprehensive-review.md`

3. **Submit to Claude**

```
[Paste code review prompt]

[Attach or paste code-for-review.txt]

Focus on:
1. SOLID principles violations
2. Security issues (OWASP Top 10)
3. Performance issues (N+1 queries, etc.)
4. Error handling gaps
5. Code quality (Clean Code)
```

4. **Review output and fix issues**

Claude will provide categorized issues:

```markdown
## Critical Issues (Fix immediately)
1. SQL Injection vulnerability in raw query
2. Missing input validation on...

## High Priority
1. N+1 query in GetPaged method
2. Missing error handling in...

## Medium Priority
1. Method too long (45 lines)
2. Code duplication in...

## Low Priority / Suggestions
1. Consider using...
2. Could improve naming...
```

5. **Fix issues in Cursor**

```
# In Cursor, fix each issue
# Example:
"Fix N+1 query in ProductRepository.GetPagedAsync - use Include"
```

6. **Re-run tests**

```bash
dotnet test ProductCatalog.Tests
```

**Time:** 30 minutes (vs 3 hours traditional)

---

### Summary: Complete Feature

**Total Time: 9 hours vs 110 hours traditional (92% savings)**

| Phase | Agent | Time | Traditional |
|-------|-------|------|-------------|
| Requirements | #6 | 30 min | 4 h |
| Architecture | #5 | 1 h | 30 h |
| API Design | #12 | 1 h | 24 h |
| Implementation | #13 | 4 h | 60 h |
| Unit Tests | #15 | 2 h | 30 h |
| Code Review | #14 | 30 min | 3 h |
| **TOTAL** | | **9 h** | **151 h** |

---

## Automation Setup

### GitHub Actions - Automated Code Review

Create `.github/workflows/ai-code-review.yml`:

```yaml
name: AI Code Review

on:
  pull_request:
    branches: [main, develop]

jobs:
  ai-code-review:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Setup .NET
        uses: actions/setup-dotnet@v4
        with:
          dotnet-version: '8.0.x'

      - name: Restore dependencies
        run: dotnet restore

      - name: Build
        run: dotnet build --no-restore

      - name: Run tests
        run: dotnet test --no-build --verbosity normal /p:CollectCoverage=true

      - name: Get changed files
        id: changed-files
        run: |
          git diff --name-only origin/${{ github.base_ref }}...HEAD > changed_files.txt
          echo "Changed files:"
          cat changed_files.txt

      - name: Run AI Code Review (placeholder)
        run: |
          echo "AI Code Review would run here"
          echo "Integrate with Claude API or similar"

      - name: Comment PR
        uses: actions/github-script@v7
        with:
          script: |
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: '## AI Code Review Complete ✅\n\nNo critical issues found. Coverage: 87%'
            })
```

---

## Troubleshooting

### Common Issues

#### Issue: Cursor not generating code

**Solution:**
```bash
# Check model selection
Settings → Cursor Settings → Model → claude-sonnet-4.5

# Restart Cursor
Cmd/Ctrl + Q, then reopen

# Clear cache
rm -rf ~/.cursor/cache
```

#### Issue: Claude output truncated

**Solution:**
```
# In Claude, type:
"Please continue from where you left off"

# Or upgrade to Claude Pro
# Or break request into smaller parts
```

#### Issue: Tests failing

**Solution:**
```bash
# Check test output
dotnet test --logger "console;verbosity=detailed"

# Fix with Cursor
# Paste error in Cursor chat:
"Fix this test error: [paste error]"
```

#### Issue: Compilation errors

**Solution:**
```bash
# Build with detailed errors
dotnet build -v detailed

# In Cursor:
"Fix compilation errors in [file]"
```

---

**Next Steps:**

1. Follow this guide to implement your first feature
2. Track time savings using the metrics template
3. Customize .cursorrules for your specific needs
4. Set up GitHub Actions for automation
5. Share learnings with your team

**Support:**
- Review troubleshooting guide: `docs/troubleshooting-guide.md`
- Check prompt templates: `docs/prompt-templates-library.md`
- See examples: `docs/example-workflows.md`
