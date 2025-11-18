#!/bin/bash

################################################################################
# .NET Clean Architecture Project Setup Script
#
# This script automates the creation of a .NET solution using Clean Architecture
# with all necessary layers, projects, and dependencies.
#
# Usage: ./setup-dotnet-project.sh <ProjectName>
# Example: ./setup-dotnet-project.sh ProductCatalog
################################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_header() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
    echo ""
}

# Check if project name is provided
if [ -z "$1" ]; then
    print_error "Project name is required"
    echo "Usage: ./setup-dotnet-project.sh <ProjectName>"
    echo "Example: ./setup-dotnet-project.sh ProductCatalog"
    exit 1
fi

PROJECT_NAME=$1
API_PROJECT="${PROJECT_NAME}.API"
DOMAIN_PROJECT="${PROJECT_NAME}.Domain"
APPLICATION_PROJECT="${PROJECT_NAME}.Application"
INFRASTRUCTURE_PROJECT="${PROJECT_NAME}.Infrastructure"
TESTS_PROJECT="${PROJECT_NAME}.Tests"

print_header "Setting up .NET Clean Architecture Project: $PROJECT_NAME"

# Check prerequisites
print_info "Checking prerequisites..."

if ! command -v dotnet &> /dev/null; then
    print_error ".NET SDK not found. Please install .NET 8.0 or later"
    exit 1
fi

DOTNET_VERSION=$(dotnet --version)
print_success ".NET SDK $DOTNET_VERSION found"

# Create solution directory
print_info "Creating solution directory..."
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"
print_success "Directory created: $PROJECT_NAME"

# Create solution
print_header "Creating Solution"
dotnet new sln -n "$PROJECT_NAME"
print_success "Solution created: $PROJECT_NAME.sln"

# Create projects
print_header "Creating Projects"

print_info "Creating Domain layer..."
dotnet new classlib -n "$DOMAIN_PROJECT"
dotnet sln add "$DOMAIN_PROJECT/$DOMAIN_PROJECT.csproj"
print_success "Domain project created"

print_info "Creating Application layer..."
dotnet new classlib -n "$APPLICATION_PROJECT"
dotnet sln add "$APPLICATION_PROJECT/$APPLICATION_PROJECT.csproj"
print_success "Application project created"

print_info "Creating Infrastructure layer..."
dotnet new classlib -n "$INFRASTRUCTURE_PROJECT"
dotnet sln add "$INFRASTRUCTURE_PROJECT/$INFRASTRUCTURE_PROJECT.csproj"
print_success "Infrastructure project created"

print_info "Creating API layer..."
dotnet new webapi -n "$API_PROJECT"
dotnet sln add "$API_PROJECT/$API_PROJECT.csproj"
print_success "API project created"

print_info "Creating Test project..."
dotnet new xunit -n "$TESTS_PROJECT"
dotnet sln add "$TESTS_PROJECT/$TESTS_PROJECT.csproj"
print_success "Test project created"

# Add project references
print_header "Configuring Project References"

print_info "Application → Domain"
dotnet add "$APPLICATION_PROJECT/$APPLICATION_PROJECT.csproj" reference "$DOMAIN_PROJECT/$DOMAIN_PROJECT.csproj"
print_success "Reference added"

print_info "Infrastructure → Application, Domain"
dotnet add "$INFRASTRUCTURE_PROJECT/$INFRASTRUCTURE_PROJECT.csproj" reference "$APPLICATION_PROJECT/$APPLICATION_PROJECT.csproj"
dotnet add "$INFRASTRUCTURE_PROJECT/$INFRASTRUCTURE_PROJECT.csproj" reference "$DOMAIN_PROJECT/$DOMAIN_PROJECT.csproj"
print_success "References added"

print_info "API → Application, Infrastructure"
dotnet add "$API_PROJECT/$API_PROJECT.csproj" reference "$APPLICATION_PROJECT/$APPLICATION_PROJECT.csproj"
dotnet add "$API_PROJECT/$API_PROJECT.csproj" reference "$INFRASTRUCTURE_PROJECT/$INFRASTRUCTURE_PROJECT.csproj"
print_success "References added"

print_info "Tests → All projects"
dotnet add "$TESTS_PROJECT/$TESTS_PROJECT.csproj" reference "$DOMAIN_PROJECT/$DOMAIN_PROJECT.csproj"
dotnet add "$TESTS_PROJECT/$TESTS_PROJECT.csproj" reference "$APPLICATION_PROJECT/$APPLICATION_PROJECT.csproj"
dotnet add "$TESTS_PROJECT/$TESTS_PROJECT.csproj" reference "$INFRASTRUCTURE_PROJECT/$INFRASTRUCTURE_PROJECT.csproj"
dotnet add "$TESTS_PROJECT/$TESTS_PROJECT.csproj" reference "$API_PROJECT/$API_PROJECT.csproj"
print_success "References added"

# Install NuGet packages
print_header "Installing NuGet Packages"

print_info "Installing Application layer packages..."
dotnet add "$APPLICATION_PROJECT" package AutoMapper --version 12.0.1
dotnet add "$APPLICATION_PROJECT" package FluentValidation --version 11.8.1
dotnet add "$APPLICATION_PROJECT" package MediatR --version 12.2.0
print_success "Application packages installed"

print_info "Installing Infrastructure layer packages..."
dotnet add "$INFRASTRUCTURE_PROJECT" package Microsoft.EntityFrameworkCore --version 8.0.0
dotnet add "$INFRASTRUCTURE_PROJECT" package Microsoft.EntityFrameworkCore.SqlServer --version 8.0.0
dotnet add "$INFRASTRUCTURE_PROJECT" package Microsoft.EntityFrameworkCore.Design --version 8.0.0
print_success "Infrastructure packages installed"

print_info "Installing API layer packages..."
dotnet add "$API_PROJECT" package Swashbuckle.AspNetCore --version 6.5.0
dotnet add "$API_PROJECT" package Microsoft.AspNetCore.Authentication.JwtBearer --version 8.0.0
dotnet add "$API_PROJECT" package Serilog.AspNetCore --version 8.0.0
print_success "API packages installed"

print_info "Installing Test layer packages..."
dotnet add "$TESTS_PROJECT" package Moq --version 4.20.70
dotnet add "$TESTS_PROJECT" package FluentAssertions --version 6.12.0
dotnet add "$TESTS_PROJECT" package Microsoft.EntityFrameworkCore.InMemory --version 8.0.0
dotnet add "$TESTS_PROJECT" package coverlet.collector --version 6.0.0
print_success "Test packages installed"

# Create directory structure
print_header "Creating Directory Structure"

print_info "Creating Domain directories..."
mkdir -p "$DOMAIN_PROJECT/Entities"
mkdir -p "$DOMAIN_PROJECT/Repositories"
mkdir -p "$DOMAIN_PROJECT/Common"
rm -f "$DOMAIN_PROJECT/Class1.cs"
print_success "Domain directories created"

print_info "Creating Application directories..."
mkdir -p "$APPLICATION_PROJECT/DTOs"
mkdir -p "$APPLICATION_PROJECT/Interfaces"
mkdir -p "$APPLICATION_PROJECT/Services"
mkdir -p "$APPLICATION_PROJECT/Mappings"
mkdir -p "$APPLICATION_PROJECT/Validators"
rm -f "$APPLICATION_PROJECT/Class1.cs"
print_success "Application directories created"

print_info "Creating Infrastructure directories..."
mkdir -p "$INFRASTRUCTURE_PROJECT/Data"
mkdir -p "$INFRASTRUCTURE_PROJECT/Data/Configurations"
mkdir -p "$INFRASTRUCTURE_PROJECT/Repositories"
rm -f "$INFRASTRUCTURE_PROJECT/Class1.cs"
print_success "Infrastructure directories created"

print_info "Creating API directories..."
mkdir -p "$API_PROJECT/Middleware"
mkdir -p "$API_PROJECT/Filters"
print_success "API directories created"

print_info "Creating Test directories..."
mkdir -p "$TESTS_PROJECT/Unit"
mkdir -p "$TESTS_PROJECT/Integration"
rm -f "$TESTS_PROJECT/UnitTest1.cs"
print_success "Test directories created"

# Create common files
print_header "Creating Common Files"

# Create .gitignore
print_info "Creating .gitignore..."
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
print_success ".gitignore created"

# Create .cursorrules
print_info "Creating .cursorrules..."
cat > .cursorrules << 'EOF'
# .cursorrules for C# / ASP.NET Core Backend Development

language: C#
framework: ASP.NET Core 8.0
target_framework: net8.0

architecture: Clean Architecture (Layered)
layers:
  - Domain (Entities, Interfaces)
  - Application (DTOs, Services, Validators)
  - Infrastructure (Data, Repositories)
  - API (Controllers, Middleware)

## Code Style
- Use PascalCase for classes, methods, properties
- Use camelCase for private fields, parameters
- Prefix interfaces with "I"
- Use async suffix for async methods

## Patterns
- Repository pattern for data access
- Service pattern for business logic
- DTO pattern for API models
- Result<T> pattern for error handling

## SOLID Principles
- Single Responsibility
- Open/Closed
- Liskov Substitution
- Interface Segregation
- Dependency Inversion

## Async/Await
- Use async/await throughout
- Always pass CancellationToken
- Never use .Result or .Wait()

## Testing
- xUnit framework
- Moq for mocking
- FluentAssertions for assertions
- AAA pattern (Arrange, Act, Assert)
- Minimum 85% code coverage
EOF
print_success ".cursorrules created"

# Create README
print_info "Creating README.md..."
cat > README.md << EOF
# $PROJECT_NAME

ASP.NET Core 8.0 application built with Clean Architecture.

## Architecture

This project follows Clean Architecture principles with four layers:

### 1. Domain Layer
- Contains enterprise business rules
- Entities and domain interfaces
- No dependencies on other layers

### 2. Application Layer
- Contains application business rules
- DTOs, Services, Validators
- Depends on: Domain

### 3. Infrastructure Layer
- Contains data access implementation
- EF Core, Repositories
- Depends on: Domain, Application

### 4. API Layer
- Contains controllers and middleware
- ASP.NET Core Web API
- Depends on: Application, Infrastructure

## Getting Started

### Prerequisites

- .NET SDK 8.0 or later
- SQL Server (or PostgreSQL)

### Build

\`\`\`bash
dotnet build
\`\`\`

### Run

\`\`\`bash
dotnet run --project $API_PROJECT
\`\`\`

API will be available at: https://localhost:7000/swagger

### Test

\`\`\`bash
dotnet test
\`\`\`

### Test with Coverage

\`\`\`bash
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover
\`\`\`

## Project Structure

\`\`\`
$PROJECT_NAME/
├── $DOMAIN_PROJECT/
│   ├── Entities/
│   ├── Repositories/
│   └── Common/
├── $APPLICATION_PROJECT/
│   ├── DTOs/
│   ├── Interfaces/
│   ├── Services/
│   ├── Mappings/
│   └── Validators/
├── $INFRASTRUCTURE_PROJECT/
│   ├── Data/
│   ├── Repositories/
│   └── Services/
├── $API_PROJECT/
│   ├── Controllers/
│   ├── Middleware/
│   └── Filters/
└── $TESTS_PROJECT/
    ├── Unit/
    └── Integration/
\`\`\`

## Technologies

- ASP.NET Core 8.0
- Entity Framework Core 8.0
- AutoMapper
- FluentValidation
- MediatR
- xUnit, Moq, FluentAssertions

## Documentation

- [Architecture Documentation](docs/architecture/)
- [API Documentation](docs/api/)
- [Development Guide](docs/development/)

## License

[Your License]
EOF
print_success "README.md created"

# Build solution
print_header "Building Solution"
print_info "Running dotnet build..."
if dotnet build; then
    print_success "Build succeeded"
else
    print_error "Build failed"
    exit 1
fi

# Initialize git
print_header "Initializing Git Repository"
if command -v git &> /dev/null; then
    git init
    git add .
    git commit -m "Initial project setup with Clean Architecture"
    print_success "Git repository initialized"
else
    print_warning "Git not found - skipping repository initialization"
fi

# Final summary
print_header "Setup Complete!"

echo ""
echo -e "${GREEN}✓ Solution created:${NC} $PROJECT_NAME.sln"
echo -e "${GREEN}✓ Projects created:${NC}"
echo "  - $DOMAIN_PROJECT"
echo "  - $APPLICATION_PROJECT"
echo "  - $INFRASTRUCTURE_PROJECT"
echo "  - $API_PROJECT"
echo "  - $TESTS_PROJECT"
echo ""
echo -e "${GREEN}✓ NuGet packages installed${NC}"
echo -e "${GREEN}✓ Directory structure created${NC}"
echo -e "${GREEN}✓ Build successful${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "  1. cd $PROJECT_NAME"
echo "  2. Open in Cursor/VS Code: cursor ."
echo "  3. Start implementing features using AI agents"
echo "  4. Run API: dotnet run --project $API_PROJECT"
echo "  5. View Swagger: https://localhost:7000/swagger"
echo ""
echo -e "${YELLOW}Happy coding! 🚀${NC}"
echo ""
