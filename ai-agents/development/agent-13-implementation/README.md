# Agent #13: Implementation Agent

## Overview

**Purpose:** Generate production-ready backend code from API designs and technical specifications

**Primary Tool:** Cursor AI (with Claude integration)

**Time Savings:** 85-90% (60 hours → 8 hours)

**Role:** Senior Backend Developer

---

## Capabilities

### Input Processing
- API design documents
- OpenAPI specifications
- Technical requirements
- Database schemas
- Architecture guidelines

### Output Generation
1. **Controllers/Handlers**
   - Request handling
   - Input validation
   - Response formatting
   - Error handling

2. **Service Layer**
   - Business logic implementation
   - Transaction management
   - Service orchestration
   - Domain logic

3. **Repository/Data Access Layer**
   - Database operations (CRUD)
   - Query optimization
   - ORM/Query builder usage
   - Connection management

4. **DTOs (Data Transfer Objects)**
   - Request DTOs
   - Response DTOs
   - Validation annotations
   - Serialization logic

5. **Entity Models**
   - Database entity classes
   - Relationships (OneToMany, ManyToOne, etc.)
   - Constraints and indexes
   - Audit fields

6. **Middleware**
   - Authentication middleware
   - Logging middleware
   - Error handling middleware
   - Request/response interceptors

---

## Configuration

**Tool:** Cursor AI with Claude Sonnet 4.5

**Temperature:** 0.2

**Mode:** Composer Mode (for multi-file generation)

---

## Triggers

Use this agent when:
- ✅ API design is approved
- ✅ Need to implement new features
- ✅ Scaffolding new microservice
- ✅ Implementing CRUD operations
- ✅ Adding new endpoints
- ✅ Refactoring existing code
- ✅ Migrating code to new framework

---

## Success Criteria

### Quality Metrics
- [ ] Code compiles without errors
- [ ] Follows framework conventions
- [ ] Implements all API endpoints
- [ ] Includes proper error handling
- [ ] Follows clean code principles
- [ ] Ready for code review

### Time Metrics
- [ ] Implementation time: <8 hours
- [ ] Review cycles: <2
- [ ] vs Manual: 60 hours (86.7% savings)

### Business Metrics
- [ ] Code quality score: >80%
- [ ] Test coverage: >80% (with Agent #15)
- [ ] No critical bugs in review

---

## Integration Points

**Inputs From:**
- Agent #12: API Design (OpenAPI spec, design docs)
- Agent #6: Technical Requirements
- Database team (schemas)
- DevOps (environment config)

**Outputs To:**
- Agent #14: Code Review Agent
- Agent #15: Unit Test Agent
- Version control (Git)
- CI/CD pipeline

---

## Supported Frameworks

### Java/Spring Boot
- Controllers, Services, Repositories
- JPA entities
- Spring Security
- Validation annotations

### Node.js/Express
- Route handlers
- Service classes
- Prisma/TypeORM models
- Middleware

### Python/FastAPI
- Path operations
- Pydantic models
- Database sessions
- Dependency injection

### Python/Django
- Views/ViewSets
- Serializers
- Models
- URL routing

### Go
- Handlers
- Services
- Repositories
- Structs

---

## Templates

See `prompts/` directory for:
- `01-implementation-spring-boot.md` - Spring Boot implementation
- `02-implementation-express.md` - Node.js/Express implementation
- `03-implementation-fastapi.md` - Python/FastAPI implementation
- `04-implementation-django.md` - Python/Django implementation

---

## Usage with Cursor AI

### Composer Mode
1. Open Cursor Composer (Cmd/Ctrl+I)
2. @mention API design file
3. @mention database schema file
4. Paste implementation prompt
5. Review and accept generated code

### .cursorrules Integration
Use `.cursorrules` file to set project standards

---

## Metrics to Track

| Metric | Target | Actual |
|--------|--------|--------|
| Implementation Time | <8h | ___ |
| Compilation Success | 100% | ___ |
| Code Quality Score | >80% | ___ |
| API Completeness | 100% | ___ |

---

## Version History

- **v1.0** (2024-11-18): Initial agent specification
