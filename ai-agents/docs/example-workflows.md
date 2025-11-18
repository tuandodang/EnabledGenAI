# Example Workflows & Use Cases

**Version:** 1.0
**Date:** November 18, 2024
**Purpose:** Real-world examples of using AI agents for backend development

---

## 📚 Table of Contents

1. [Complete Feature Development](#workflow-1-complete-feature-development)
2. [New Microservice Creation](#workflow-2-new-microservice-creation)
3. [API Design & Implementation](#workflow-3-api-design--implementation)
4. [Legacy System Documentation](#workflow-4-legacy-system-documentation)
5. [Sprint Planning & Execution](#workflow-5-sprint-planning--execution)
6. [Code Quality Improvement](#workflow-6-code-quality-improvement)

---

## Workflow #1: Complete Feature Development

**Scenario:** Building a new "User Profile Management" feature for an existing e-commerce platform

**Team:** 1 backend developer
**Timeline:** Traditional 2 weeks → With agents: 2 days
**Tools:** Claude AI, Cursor AI

### Step-by-Step Process

#### Day 1 Morning: Requirements & Architecture (4 hours → 30 minutes)

**1. Requirements Analysis (Agent #6)**

```
Open Claude AI, paste:

Analyze these business requirements and create technical specifications:

**Feature:** User Profile Management

**Business Requirements:**
- Users can view their profile information
- Users can update their name, email, phone, address
- Users can upload profile picture (max 5MB)
- Users can change password
- Users can view order history
- Users can manage saved addresses (multiple addresses)
- Admin can view and edit any user profile
- Email verification required on email change

**Constraints:**
- Must integrate with existing authentication system (JWT)
- Database: PostgreSQL (existing)
- Framework: Spring Boot 3.2
- Must maintain backward compatibility with existing APIs
- Response time < 200ms

Please provide:
1. Functional Requirements with acceptance criteria
2. Non-Functional Requirements with metrics
3. API endpoint specifications
4. Data model changes needed
5. Security requirements
6. Clarification questions

Format: Comprehensive markdown
```

**Output received (5 minutes):**
- 15 functional requirements
- 10 non-functional requirements
- 8 API endpoints specified
- Database schema changes
- Security requirements
- 12 clarification questions

**Time saved:** 4 hours → 30 minutes (87.5% savings)

---

**2. Architecture Documentation (Agent #5)**

```
Using the requirements from Agent #6:

Create architecture document for User Profile Management feature:

[Paste Agent #6 output]

**Existing System Context:**
- Spring Boot 3.2 microservices architecture
- PostgreSQL database
- Redis for caching
- S3 for file storage
- JWT authentication
- API Gateway (Kong)

Please provide:
1. Component design for this feature
2. ADR for profile picture storage strategy
3. Integration points with existing services
4. Data model and schema changes
5. Security architecture
6. Caching strategy

Format: Architecture document + ADR
```

**Output received (5 minutes):**
- Complete component design
- ADR for S3 vs database storage (recommends S3)
- Integration specifications
- Database migration scripts outline
- Security recommendations
- Caching strategy

**Time saved:** 3 hours → 20 minutes (89% savings)

---

#### Day 1 Afternoon: API Design & Planning (4 hours → 1 hour)

**3. API Design (Agent #12)**

```
Design REST API for User Profile Management:

**Requirements:** [Paste Agent #6 output]

**Architecture:** [Paste Agent #5 output]

**Framework:** Spring Boot 3.2, Java 17

**Authentication:** JWT (existing)

**Existing API Pattern:**
- Base URL: /api/v1
- Error format: {"error": {"code": "...", "message": "..."}}
- Pagination: ?page=0&size=20

Please provide:
1. Complete API design document
2. OpenAPI 3.0 specification
3. Request/response examples for all endpoints
4. Error handling specifications
5. Validation rules

Ensure consistency with existing API patterns.

Format: Markdown + OpenAPI YAML
```

**Output received (5 minutes):**
- 8 endpoints fully specified
- Complete OpenAPI 3.0 spec
- Request/response examples
- Error codes and messages
- Validation rules

**Validation (10 minutes):**
- Tested OpenAPI spec at swagger.io/editor ✅
- Reviewed with frontend team ✅
- Confirmed security requirements ✅

**Time saved:** 24 hours → 1 hour (95.8% savings)

---

**4. Sprint Planning (Agent #11)**

```
Create sprint plan for User Profile Management implementation:

**Sprint:** Sprint 15, 2 weeks
**Dates:** Nov 20 - Dec 1, 2024

**Team:**
- 1 backend developer (you)
- Historical velocity: 25 story points per 2 weeks

**Features:** [Paste API design summary]

**Constraints:**
- Must complete by end of sprint for frontend integration
- Need time for code review and testing
- Some time needed for bug fixes in other features

Please provide:
1. User stories with story points
2. Task breakdown per story
3. Sprint schedule
4. Risk assessment

Format: Sprint plan
```

**Output received (5 minutes):**
- 8 user stories (total 22 points)
- Detailed task breakdown
- Day-by-day schedule
- Risk mitigation plan

**Time saved:** 12 hours → 30 minutes (95.8% savings)

---

#### Day 2 Morning: Implementation (8 hours → 4 hours)

**5. Code Implementation (Agent #13)**

```
Open Cursor AI Composer (Cmd+I)

@api-design.md @database-schema.sql @existing-user-entity.java

Implement Spring Boot backend for User Profile Management:

**Tech Stack:**
- Spring Boot 3.2
- Java 17
- Spring Data JPA
- PostgreSQL
- Lombok
- MapStruct
- AWS S3 SDK

Generate all layers:
1. Update User entity with new fields
2. Create UserProfile entity for extended profile data
3. Create Address entity (one-to-many with User)
4. ProfilePictureService for S3 integration
5. UserProfileRepository
6. Request/Response DTOs with validation
7. UserProfileMapper (MapStruct)
8. UserProfileService + implementation
9. UserProfileController
10. Exception classes
11. Database migration scripts (Flyway)

Follow Spring Boot best practices, use DTOs, validation, error handling.

Format: Complete Spring Boot code
```

**Review and refine (2 hours):**
- Generated code reviewed
- Compilation successful ✅
- Minor adjustments to business logic
- S3 integration tested locally

**Manual coding time:** 60 hours
**With Agent #13:** 4 hours (93.3% savings)

---

#### Day 2 Afternoon: Testing & Review (6 hours → 2 hours)

**6. Unit Tests (Agent #15)**

```
Open Cursor AI Composer

@UserProfileService.java @UserProfileController.java @UserProfileRepository.java

Generate comprehensive JUnit 5 tests:

**Framework:** JUnit 5, Mockito, AssertJ, Spring Boot Test

**Files to test:**
- UserProfileService
- UserProfileController
- ProfilePictureService

Coverage goals: >80%, all paths, edge cases

Generate tests for:
1. All CRUD operations
2. Profile picture upload/delete
3. Address management
4. Password change
5. Email change with verification
6. Error scenarios
7. Security/authorization checks

Format: Complete test classes
```

**Output received (15 minutes):**
- 45 test methods
- 87% code coverage
- All edge cases covered

**Run and fix (1 hour):**
- All tests passing ✅
- Coverage: 88% ✅

**Time saved:** 30 hours → 2 hours (93.3% savings)

---

**7. Code Review (Agent #14)**

```
Back to Claude AI:

Review this implementation comprehensively:

[Paste key source files]

**Focus:** All aspects (quality, security, performance, testing)

Provide detailed review with issues and recommendations.
```

**Output received (5 minutes):**
- 2 security issues found (fixed in 20 minutes)
- 3 performance optimizations suggested (implemented in 30 minutes)
- 1 code smell identified (refactored in 15 minutes)

**Time saved:** 3 hours → 1 hour (66.7% savings)

---

### Summary

**Total Time:**
- **Traditional:** ~110 hours (2+ weeks)
- **With AI Agents:** ~9 hours (1.1 days)
- **Savings:** 91.8%

**Quality:**
- ✅ Comprehensive requirements
- ✅ Well-documented architecture
- ✅ Complete OpenAPI spec
- ✅ Production-ready code
- ✅ 88% test coverage
- ✅ Security reviewed

**Deliverables:**
- Technical requirements document
- Architecture document + ADR
- OpenAPI 3.0 specification
- Complete implementation (8 endpoints)
- 45 unit tests (88% coverage)
- Code review report

---

## Workflow #2: New Microservice Creation

**Scenario:** Creating a "Notification Service" microservice from scratch

**Team:** 1 backend developer
**Timeline:** Traditional 3 weeks → With agents: 3 days

### Process Overview

**Day 1: Design (Agent #6 → #5 → #7 → #12)**
1. Requirements analysis (30 min)
2. Architecture design (30 min)
3. C4 diagrams (20 min)
4. API design (1 hour)

**Day 2-3: Implementation (Agent #13 → #15 → #14)**
1. Project scaffolding (1 hour)
2. Implementation (5 hours)
3. Unit tests (2 hours)
4. Code review and fixes (2 hours)

**Total:** ~12 hours vs 120 hours (90% savings)

---

## Workflow #3: API Design & Implementation

**Scenario:** Designing and implementing a GraphQL API for product catalog

**Focus:** API-first development

### Quick Process

**Step 1: API Design (Agent #12) - 1 hour**

```
Design a GraphQL API for product catalog:

**Requirements:**
- Query products by category, price range, search term
- Filter and sort capabilities
- Nested data (product → category → subcategories)
- Pagination with cursor-based pagination
- Real-time updates for inventory changes (subscriptions)

**Data Models:** [Paste data models]

Please provide:
1. Complete GraphQL schema
2. Query examples
3. Mutation examples
4. Subscription examples
5. Resolver specifications
6. Performance considerations (DataLoader for N+1)

Format: GraphQL schema + documentation
```

**Step 2: Implementation (Agent #13) - 3 hours**

```
Implement GraphQL API using generated schema:

@graphql-schema.graphql @database-schema.sql

Framework: Node.js, Apollo Server, TypeScript, Prisma

Generate:
1. Type definitions
2. Resolvers
3. DataLoaders
4. Prisma schema
5. Context setup
6. Error handling

Format: Complete TypeScript code
```

**Step 3: Testing (Agent #15) - 1.5 hours**

```
Generate integration tests for GraphQL API:

@resolvers.ts @schema.graphql

Framework: Jest, Apollo Server Testing

Generate tests for:
- All queries
- All mutations
- All subscriptions
- Error handling
- Authorization
- DataLoader efficiency

Format: Complete test suite
```

**Total:** 5.5 hours vs 30 hours (81.7% savings)

---

## Workflow #4: Legacy System Documentation

**Scenario:** Documenting an undocumented legacy system before migration

**Challenge:** 50K lines of code, no documentation, original developers gone

### Process

**Step 1: Code Analysis (Manual) - 8 hours**
- Read through codebase
- Identify main components
- Understand data flows
- Document findings

**Step 2: Architecture Documentation (Agent #5) - 1 hour**

```
Based on this legacy system analysis:

[Paste your analysis notes and key code snippets]

**System:** Order Processing System
**Tech:** Spring Framework 4.x, Oracle DB, SOAP APIs

Create:
1. Architecture documentation
2. Component diagram specification
3. Data flow description
4. ADRs documenting current design decisions (even if not optimal)
5. Migration recommendations

Purpose: Document before migration to modern stack.
```

**Step 3: Diagram Generation (Agent #7) - 30 minutes**

```
Create C4 diagrams for this legacy system:

[Paste architecture documentation from Agent #5]

Generate:
1. System context diagram
2. Container diagram
3. Component diagram
4. Data flow diagram

Format: Mermaid diagrams
```

**Step 4: API Documentation (Agent #12) - 1 hour**

```
Create API documentation for existing SOAP services:

[Paste WSDL files and service descriptions]

Convert to modern REST API documentation format to aid migration:
1. Current SOAP endpoints documentation
2. Proposed REST API design (migration target)
3. Mapping between SOAP and REST
4. Migration path recommendations
```

**Total:** 10.5 hours vs 40 hours (73.8% savings)

**Output:**
- Complete architecture documentation
- Visual diagrams (C4, data flow)
- API documentation (current + proposed)
- Migration recommendations

---

## Workflow #5: Sprint Planning & Execution

**Scenario:** Planning and executing a 2-week sprint for an existing project

**Team:** 3 developers
**Sprint Goal:** Implement payment integration and refund flow

### Complete Sprint Workflow

**Pre-Sprint: Requirements (Agent #6) - 1 hour**

```
Convert these business requirements to technical specs:

**Requirements:**
- Integrate Stripe payment gateway
- Support credit card and ACH payments
- Implement refund functionality
- Send payment confirmation emails
- Store payment history
- Handle payment failures gracefully
- PCI DSS compliance required

**Constraints:**
- 3 developers (2 backend, 1 full-stack)
- 2-week sprint
- Must integrate with existing order system
- Test mode first, then production

Provide: FRs, NFRs, WBS, dependencies
```

**Sprint Planning (Agent #11) - 30 minutes**

```
Create sprint plan:

**Team:**
- 2 backend developers (senior)
- 1 full-stack developer
- Velocity: 35 points (team average)

**Requirements:** [Paste Agent #6 output]

**Sprint:** 2 weeks

Create:
1. User stories with story points
2. Task breakdown
3. Team assignments
4. Sprint schedule
5. Risk assessment
```

**Sprint Execution:**

**Story 1: Stripe Integration (8 points)**
- Agent #12: API design (1 hour)
- Agent #13: Implementation (3 hours)
- Agent #15: Tests (1 hour)
- Agent #14: Review (30 min)

**Story 2: Refund Flow (5 points)**
- Agent #12: API design (45 min)
- Agent #13: Implementation (2 hours)
- Agent #15: Tests (45 min)
- Agent #14: Review (20 min)

[... and so on for all stories]

**Total Sprint Time:**
- **Traditional:** 160 hours (3 developers × 2 weeks × 80%)
- **With Agents:** 40 hours (75% savings)
- **Extra capacity used for:** Quality improvements, tech debt, innovation

---

## Workflow #6: Code Quality Improvement

**Scenario:** Improving quality of existing codebase before major feature additions

**Target:** Order processing module (5K lines of code)

### Process

**Step 1: Code Review (Agent #14) - 2 hours**

```
Perform comprehensive code review:

[Paste Order processing code files]

**Framework:** Spring Boot

**Focus:** All aspects, especially:
- Security (OWASP Top 10)
- Performance (N+1 queries, caching opportunities)
- Code quality (code smells, SOLID violations)
- Testing gaps

Provide prioritized list of issues with fixes.
```

**Output:**
- 15 critical issues
- 23 high priority issues
- 34 medium priority issues

**Step 2: Refactoring Plan (Agent #11) - 30 minutes**

```
Create refactoring plan based on code review:

[Paste code review output from Agent #14]

**Team:** 2 developers
**Timeline:** 1 week

Create:
1. Prioritized refactoring tasks
2. Effort estimates
3. Risk assessment
4. Testing strategy

Ensure critical issues fixed first.
```

**Step 3: Implement Fixes (Agent #13) - 6 hours**

```
[For each critical issue]

Refactor this code to fix [ISSUE]:

@OrderService.java

[Paste specific issue description and recommendation]

Provide refactored code following best practices.
```

**Step 4: Add Missing Tests (Agent #15) - 3 hours**

```
Generate tests for refactored code:

@OrderService.java

Current coverage: 45%
Target coverage: >80%

Focus on:
- Business logic
- Edge cases
- Error scenarios
- Recently refactored code
```

**Step 5: Final Review (Agent #14) - 30 minutes**

```
Review refactored code:

@OrderService.java (refactored)

Verify:
- All critical issues resolved
- No new issues introduced
- Quality improvements achieved
```

**Total:** 12 hours vs 60 hours (80% savings)

**Results:**
- Code coverage: 45% → 85%
- Security issues: 15 → 0
- Code quality score: 62 → 89
- Performance improved (N+1 queries eliminated)

---

## 💡 Key Takeaways

### What Works Best

1. **Start with requirements** (Agent #6) - Sets foundation
2. **Architecture before implementation** (Agent #5) - Prevents rework
3. **API design first** (Agent #12) - Clarifies contracts
4. **Implementation with context** (Agent #13) - Better code quality
5. **Tests immediately** (Agent #15) - Catches issues early
6. **Review before PR** (Agent #14) - Higher quality merges

### Common Patterns

**New Feature:** #6 → #5 → #12 → #13 → #15 → #14

**API-First:** #6 → #12 → #13 → #15 → #14

**Documentation:** #6 → #5 → #7

**Quality Improvement:** #14 → #11 (plan) → #13 (fixes) → #15 (tests)

**Sprint Cycle:** #11 (plan) → [#12 → #13 → #15 → #14] per story

### Tips for Success

1. **Always start with clear requirements** - Garbage in, garbage out
2. **Provide context** - Reference existing code, patterns, constraints
3. **Iterate** - First output is a draft, refine based on review
4. **Validate** - Always validate AI-generated artifacts
5. **Learn patterns** - Save successful prompts for reuse

---

## 📊 Time Savings Summary

| Workflow | Traditional | With Agents | Savings |
|----------|-------------|-------------|---------|
| Complete Feature | 110h | 9h | 91.8% |
| New Microservice | 120h | 12h | 90% |
| API Design & Implementation | 30h | 5.5h | 81.7% |
| Legacy Documentation | 40h | 10.5h | 73.8% |
| Sprint Execution | 160h | 40h | 75% |
| Code Quality Improvement | 60h | 12h | 80% |

**Average Savings: 82.1%**

---

## Next Steps

1. **Choose a workflow** that matches your current need
2. **Follow the steps** with your own project
3. **Measure your results** against traditional approach
4. **Document learnings** for team reference
5. **Share success** with team

---

**Version:** 1.0
**Last Updated:** 2024-11-18

Ready to try these workflows on your projects? Start with the Quick Start Guide!
