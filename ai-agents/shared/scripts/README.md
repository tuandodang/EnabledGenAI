# Project Setup Scripts

Automation scripts for quickly setting up .NET projects with Clean Architecture.

---

## Scripts

### `setup-dotnet-project.sh`

Automated setup script for creating a complete .NET solution using Clean Architecture.

**What it does:**
1. Creates solution with 5 projects (Domain, Application, Infrastructure, API, Tests)
2. Configures project references
3. Installs all required NuGet packages
4. Creates directory structure
5. Generates configuration files (.gitignore, .cursorrules, README.md)
6. Builds the solution
7. Initializes git repository

**Usage:**

```bash
./setup-dotnet-project.sh <ProjectName>
```

**Example:**

```bash
# Navigate to your workspace
cd ~/projects

# Run script
./setup-dotnet-project.sh ProductCatalog

# Expected output:
# ═══════════════════════════════════════════════════════════
#   Setting up .NET Clean Architecture Project: ProductCatalog
# ═══════════════════════════════════════════════════════════
#
# ✓ .NET SDK 8.0.100 found
# ✓ Directory created: ProductCatalog
# ✓ Solution created: ProductCatalog.sln
# ... (detailed progress)
# ✓ Build succeeded
# ✓ Git repository initialized
#
# Next steps:
#   1. cd ProductCatalog
#   2. Open in Cursor: cursor .
#   3. Start implementing features
```

**Output Structure:**

```
ProductCatalog/
├── ProductCatalog.sln
├── ProductCatalog.Domain/
│   ├── Entities/
│   ├── Repositories/
│   ├── Common/
│   └── ProductCatalog.Domain.csproj
├── ProductCatalog.Application/
│   ├── DTOs/
│   ├── Interfaces/
│   ├── Services/
│   ├── Mappings/
│   ├── Validators/
│   └── ProductCatalog.Application.csproj
├── ProductCatalog.Infrastructure/
│   ├── Data/
│   │   └── Configurations/
│   ├── Repositories/
│   └── ProductCatalog.Infrastructure.csproj
├── ProductCatalog.API/
│   ├── Controllers/
│   ├── Middleware/
│   ├── Filters/
│   └── ProductCatalog.API.csproj
├── ProductCatalog.Tests/
│   ├── Unit/
│   ├── Integration/
│   └── ProductCatalog.Tests.csproj
├── .gitignore
├── .cursorrules
└── README.md
```

**Prerequisites:**
- .NET SDK 8.0 or later
- Git (optional, for repository initialization)

**Installed Packages:**

Application Layer:
- AutoMapper 12.0.1
- FluentValidation 11.8.1
- MediatR 12.2.0

Infrastructure Layer:
- Microsoft.EntityFrameworkCore 8.0.0
- Microsoft.EntityFrameworkCore.SqlServer 8.0.0
- Microsoft.EntityFrameworkCore.Design 8.0.0

API Layer:
- Swashbuckle.AspNetCore 6.5.0
- Microsoft.AspNetCore.Authentication.JwtBearer 8.0.0
- Serilog.AspNetCore 8.0.0

Test Layer:
- xUnit
- Moq 4.20.70
- FluentAssertions 6.12.0
- Microsoft.EntityFrameworkCore.InMemory 8.0.0
- coverlet.collector 6.0.0

**Time Saved:** ~30 minutes of manual setup

---

## Customization

### Modify Package Versions

Edit the script at line ~150:

```bash
# Change version numbers
dotnet add "$APPLICATION_PROJECT" package AutoMapper --version 13.0.0
```

### Add Additional Packages

Add new package installations:

```bash
# After existing packages
print_info "Installing Redis cache..."
dotnet add "$INFRASTRUCTURE_PROJECT" package StackExchange.Redis --version 2.7.0
print_success "Redis package installed"
```

### Customize Directory Structure

Modify directory creation section (line ~200):

```bash
# Add new directories
mkdir -p "$APPLICATION_PROJECT/Commands"
mkdir -p "$APPLICATION_PROJECT/Queries"
mkdir -p "$APPLICATION_PROJECT/Events"
```

### Change Architecture

For microservices instead of Clean Architecture:

```bash
# Create service-specific projects instead
dotnet new webapi -n "$PROJECT_NAME.OrderService"
dotnet new webapi -n "$PROJECT_NAME.ProductService"
dotnet new classlib -n "$PROJECT_NAME.Shared"
```

---

## Troubleshooting

### Script won't execute

```bash
# Make executable
chmod +x setup-dotnet-project.sh

# Verify
ls -l setup-dotnet-project.sh
# Should show: -rwxr-xr-x
```

### .NET SDK not found

```bash
# Check if .NET is installed
dotnet --version

# If not installed, install .NET SDK 8.0
# macOS: brew install dotnet-sdk
# Windows: Download from https://dotnet.microsoft.com/download
# Linux: Follow distro-specific instructions
```

### Package installation fails

```bash
# Clear NuGet cache
dotnet nuget locals all --clear

# Re-run script
./setup-dotnet-project.sh MyProject
```

### Build fails

```bash
# Navigate to project
cd MyProject

# Build with verbose output
dotnet build -v detailed

# Fix errors, then rebuild
dotnet build
```

---

## Integration with AI Agents

After running the setup script, use AI agents to implement features:

### Step 1: Design API

```bash
# Use Agent #12 (API Design) in Claude AI
# Copy prompt from: ai-agents/development/agent-12-api-design/prompts/01-api-design.md
# Get OpenAPI specification
```

### Step 2: Implement Feature

```bash
# Open in Cursor
cd MyProject
cursor .

# In Cursor Composer (Cmd+I)
# Use Agent #13 implementation prompt with:
@openapi.yaml @.cursorrules

# Paste prompt from: ai-agents/development/agent-13-implementation/prompts/02-dotnet-implementation.md
```

### Step 3: Generate Tests

```bash
# In Cursor
# Use Agent #15 test generation prompt with:
@ProductService.cs @ProductRepository.cs

# Paste prompt from: ai-agents/development/agent-15-unit-testing/prompts/02-xunit-tests.md
```

### Step 4: Code Review

```bash
# In Claude AI
# Use Agent #14 code review prompt
# Upload generated code
# Get review report
```

---

## Examples

### Create E-Commerce API

```bash
./setup-dotnet-project.sh ECommerceAPI
cd ECommerceAPI
cursor .

# Then in Cursor:
# - Implement Product management
# - Implement Order management
# - Implement Cart functionality
```

### Create Blog API

```bash
./setup-dotnet-project.sh BlogAPI
cd BlogAPI
cursor .

# Then in Cursor:
# - Implement Post management
# - Implement Comment system
# - Implement User authentication
```

---

## Contributing

To add new scripts:

1. Create script in this directory
2. Make executable: `chmod +x script-name.sh`
3. Add documentation to this README
4. Test thoroughly
5. Commit changes

---

## License

Part of the AI Agents Implementation Package
