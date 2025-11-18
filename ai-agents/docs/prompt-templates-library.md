# Prompt Templates Library

**Version:** 1.0
**Date:** November 18, 2024
**Purpose:** Quick reference library of ready-to-use prompts for all AI agents

---

## 📚 How to Use This Library

1. **Find the agent** you need from the table of contents
2. **Copy the prompt template** for your use case
3. **Fill in the placeholders** with your specific information
4. **Paste into Claude AI or Cursor AI**
5. **Review and iterate** on the output

---

## 📑 Table of Contents

### Architecture Agents
- [Agent #5: Technical Documentation](#agent-5-technical-documentation)
- [Agent #6: Requirement Analysis](#agent-6-requirement-analysis)
- [Agent #7: Diagram Generation](#agent-7-diagram-generation)

### Development Agents
- [Agent #11: Sprint Planning](#agent-11-sprint-planning)
- [Agent #12: API Design](#agent-12-api-design)
- [Agent #13: Implementation](#agent-13-implementation)
- [Agent #14: Code Review](#agent-14-code-review)
- [Agent #15: Unit Testing](#agent-15-unit-testing)

---

## Agent #5: Technical Documentation

### Use Case 1: Create Architecture Document

```
Create a comprehensive architecture document for:

**Project:** [PROJECT_NAME]
**Type:** [Web Application / Microservices / Mobile App]
**Scale:** [Expected users, requests/day]

**Business Requirements:**
[Paste your business requirements here]

**Technical Requirements:**
[Paste technical requirements if available]

**Constraints:**
- [Technical constraints]
- [Budget constraints]
- [Timeline constraints]

Please provide:
1. Executive summary
2. System context and architecture overview
3. Quality attributes (scalability, security, performance)
4. Component details
5. Infrastructure architecture
6. Security architecture
7. Data architecture
8. Risks and mitigation

Format: Comprehensive markdown document
```

### Use Case 2: Create Architecture Decision Record (ADR)

```
Create an ADR for:

**Decision:** [e.g., "Database selection for e-commerce platform"]

**Context:**
[Provide background and current situation]

**Options to Consider:**
1. [Option 1 with brief description]
2. [Option 2 with brief description]
3. [Option 3 with brief description]

**Requirements:**
- [Key requirement 1]
- [Key requirement 2]

**Constraints:**
- [Constraint 1]
- [Constraint 2]

Please provide complete ADR with:
- Context and problem statement
- Decision drivers
- Detailed analysis of each option (pros, cons, costs, risks)
- Recommended decision with justification
- Consequences (positive, negative, neutral)
- Implementation plan
```

---

## Agent #6: Requirement Analysis

### Use Case 1: Convert Business Requirements to Technical Specs

```
Analyze these business requirements and create detailed technical specifications:

**Project:** [PROJECT_NAME]
**Domain:** [e.g., E-commerce, Healthcare, Fintech]

**Business Requirements:**
[Paste business requirements here]

**Context:**
- Target users: [User types and count]
- Scale: [Expected scale]
- Timeline: [Timeline]

Please provide:
1. Functional Requirements (FRs) with acceptance criteria
2. Non-Functional Requirements (NFRs) with specific, measurable targets
3. Work Breakdown Structure (WBS)
4. Requirements Traceability Matrix
5. Clarification Questions (critical unknowns)
6. Risk Assessment
7. Out of Scope items

Format: Comprehensive markdown document
```

### Use Case 2: Extract User Stories from Requirements

```
Extract and elaborate user stories from these requirements:

**Requirements:**
[Paste requirements]

For each user story, provide:
- User story in format: "As a [user], I want [goal], so that [benefit]"
- Detailed requirements
- Acceptance criteria (testable)
- Business rules
- Priority (Critical/High/Medium/Low)
- Complexity (Low/Medium/High)
- Estimated effort (story points or hours)

Format: Structured user stories ready for sprint planning
```

---

## Agent #7: Diagram Generation

### Use Case 1: Generate C4 Diagrams

```
Create C4 diagrams in Mermaid format for:

**System:** [SYSTEM_NAME]

**Architecture:**
[Paste architecture description or document]

**Components:**
- [Component 1]: [Description]
- [Component 2]: [Description]

**External Systems:**
- [System 1]: [Purpose]
- [System 2]: [Purpose]

Please generate in Mermaid format:
1. System Context Diagram (Level 1)
2. Container Diagram (Level 2)
3. Component Diagram for [main container] (Level 3)

Ensure diagrams:
- Include all components
- Show relationships clearly
- Include technology stack
- Are ready to render
```

### Use Case 2: Generate Database ERD

```
Create an Entity-Relationship Diagram for:

**Database Schema:**
[Paste database schema or describe tables]

**Tables:**
- [Table 1]: [Columns]
- [Table 2]: [Columns]

**Relationships:**
- [Relationship 1]
- [Relationship 2]

Format: Mermaid ERD diagram, ready to render
```

---

## Agent #11: Sprint Planning

### Use Case 1: Create Sprint Plan

```
Create a sprint plan for:

**Sprint:** Sprint [NUMBER], [DURATION]
**Dates:** [START_DATE] to [END_DATE]

**Team:**
- [NUMBER] backend developers
- [NUMBER] frontend developers
- Average velocity: [VELOCITY] story points

**Sprint Goal:** [GOAL or "Please suggest"]

**User Stories/Features:**
[Paste user stories or features to implement]

**Constraints:**
- [Constraint 1 - e.g., "Must complete authentication by end of sprint"]
- [Constraint 2]

Please provide:
1. Sprint goal (if not provided)
2. Sprint backlog with story points
3. Task breakdown for each user story
4. Sprint schedule (week-by-week)
5. Risk assessment
6. Success metrics

Format: Comprehensive sprint plan ready for team
```

### Use Case 2: Estimate Project Timeline

```
Estimate timeline for this project:

**Project:** [PROJECT_NAME]

**Features:**
[List all features]

**Team:**
- Team size: [NUMBER] developers
- Team composition: [Backend/Frontend/Full-stack breakdown]
- Historical velocity: [If available]

**Constraints:**
- Target launch date: [DATE or "TBD"]
- Must-have vs nice-to-have features: [Clarify]

Please provide:
1. Development roadmap (phases and milestones)
2. Feature sequencing with dependencies
3. Effort estimates per feature
4. Total timeline estimate (optimistic, realistic, pessimistic)
5. Risk factors affecting timeline
```

---

## Agent #12: API Design

### Use Case 1: Design REST API

```
Design a REST API for:

**Project:** [PROJECT_NAME]
**Framework:** [Spring Boot / Express / FastAPI / Django]

**Requirements:**
[Paste requirements or user stories]

**Data Models:**
[Describe data models]

**Authentication:** [JWT / OAuth 2.0 / API Key]

Please provide:
1. Complete API design document
2. OpenAPI 3.0 specification in YAML
3. Endpoint documentation with examples (curl)
4. Request/response schemas with validation
5. Error handling specification
6. Authentication/authorization details

Format: Markdown document + YAML OpenAPI spec
```

### Use Case 2: Design GraphQL API

```
Design a GraphQL API for:

**Project:** [PROJECT_NAME]

**Requirements:**
[Paste requirements]

**Data Models:**
[Describe data models and relationships]

Please provide:
1. GraphQL schema definition
2. Query examples
3. Mutation examples
4. Subscription examples (if needed)
5. Authentication strategy
6. Error handling approach
7. Performance considerations (N+1 queries, DataLoader)

Format: Complete GraphQL schema and documentation
```

---

## Agent #13: Implementation

### Use Case 1: Generate Spring Boot Backend Code

```
Implement Spring Boot backend code for:

**Feature:** [FEATURE_NAME]

**API Design:** @api-design.md
**Database Schema:** @schema.sql

**Tech Stack:**
- Java 17
- Spring Boot 3.x
- Spring Data JPA
- PostgreSQL
- Lombok
- MapStruct

Generate all layers:
1. Entity with JPA annotations
2. Repository interface
3. Request/Response DTOs with validation
4. Mapper (MapStruct)
5. Service interface and implementation
6. REST Controller
7. Exception classes
8. Global exception handler

Follow best practices:
- Use DTOs (not entities in API)
- Constructor injection
- Proper error handling
- Input validation
- Logging

Format: Complete, compilable Java code
```

### Use Case 2: Generate Express.js API

```
Implement Express.js API for:

**Feature:** [FEATURE_NAME]

**API Design:** @api-design.md

**Tech Stack:**
- Node.js 18+
- Express 4.x
- TypeScript
- Prisma ORM
- PostgreSQL

Generate:
1. Route handlers
2. Service layer
3. Prisma schema
4. DTO interfaces
5. Validation middleware
6. Error handling middleware
7. Authentication middleware (if needed)

Follow best practices:
- TypeScript strict mode
- Async/await
- Input validation
- Error handling
- Logging

Format: Complete TypeScript code
```

---

## Agent #14: Code Review

### Use Case 1: Comprehensive Code Review

```
Review this code comprehensively:

**Language/Framework:** [LANGUAGE/FRAMEWORK]

**Code:**
[Paste code or reference files: @filename.java]

**Review Focus:** All (or specify: Security / Performance / Quality)

Please review:
1. Code quality (clean code, SOLID, code smells)
2. Security (OWASP Top 10, vulnerabilities)
3. Performance (efficiency, N+1 queries, caching)
4. Error handling and logging
5. Testing and testability
6. Documentation

Provide:
- Severity-based issues (Critical, High, Medium, Low)
- Specific file/line references
- Code examples of problems
- Suggested fixes with code examples
- Rationale for each issue
- Positive highlights

Format: Structured review report with examples
```

### Use Case 2: Security-Focused Review

```
Perform security review of this code:

**Code:**
[Paste code]

Focus on OWASP Top 10:
1. Broken Access Control
2. Cryptographic Failures
3. Injection (SQL, NoSQL, Command, LDAP)
4. Insecure Design
5. Security Misconfiguration
6. Vulnerable Components
7. Authentication Failures
8. Data Integrity Failures
9. Logging/Monitoring Failures
10. SSRF

Also check:
- XSS prevention
- CSRF protection
- Input validation
- Sensitive data handling
- Secrets in code

Provide:
- Critical security issues with CVSS scores
- Specific vulnerabilities with code examples
- Remediation recommendations with code
- Security best practices not followed

Format: Security audit report
```

---

## Agent #15: Unit Testing

### Use Case 1: Generate JUnit Tests

```
Generate comprehensive JUnit 5 tests for:

**Source Code:** @[SourceFile.java]
**Dependencies to Mock:** @[Dependency1.java] @[Dependency2.java]

**Framework:** JUnit 5, Mockito, AssertJ

Generate tests that:
1. Cover all public methods
2. Include happy path, error path, and edge cases
3. Use AAA pattern (Arrange-Act-Assert)
4. Achieve >80% coverage
5. Use proper mocking
6. Have descriptive test names (@DisplayName)
7. Include parameterized tests where applicable

Test cases should include:
- Success scenarios
- Validation errors
- Null/empty inputs
- Boundary values
- Exception handling

Format: Complete JUnit test class ready to run
```

### Use Case 2: Generate Jest Tests

```
Generate comprehensive Jest tests for:

**Source Code:** @[sourceFile.ts]

**Framework:** Jest, TypeScript

Generate tests that:
1. Cover all exported functions
2. Include success cases, error cases, edge cases
3. Use proper mocking (jest.fn(), jest.mock())
4. Achieve >80% coverage
5. Have descriptive test names

Test structure:
- Use describe() blocks for grouping
- Clear test names with it() / test()
- Setup with beforeEach() if needed
- Cleanup with afterEach() if needed

Format: Complete Jest test file ready to run
```

---

## 🔄 Workflow Prompts

### Complete Feature Development Workflow

#### Step 1: Requirements (Agent #6)

```
Analyze requirements and create technical specifications for:

[Paste business requirements]

Provide: FRs, NFRs, WBS, clarification questions
```

#### Step 2: Architecture (Agent #5)

```
Create architecture document using these technical requirements:

@technical-requirements.md

Provide: Architecture document, ADRs, tech stack specs
```

#### Step 3: API Design (Agent #12)

```
Design REST API using these requirements:

@technical-requirements.md

Provide: API design, OpenAPI spec, examples
```

#### Step 4: Implementation (Agent #13)

```
Implement backend code:

@api-design.md @database-schema.sql

Framework: [Framework]

Generate: All layers (controller, service, repository, DTOs, entities)
```

#### Step 5: Unit Tests (Agent #15)

```
Generate unit tests for:

@[ImplementedCode.java]

Framework: [Testing Framework]

Coverage: >80%, all paths, edge cases
```

#### Step 6: Code Review (Agent #14)

```
Review this implementation:

@[ImplementedCode.java]

Focus: All aspects (quality, security, performance)
```

---

## 💡 Tips for Effective Prompts

### DO:
- ✅ Be specific with project context
- ✅ Provide concrete examples
- ✅ Use @mentions in Cursor to reference files
- ✅ Specify framework versions
- ✅ Include constraints upfront
- ✅ Request specific output format
- ✅ Iterate with follow-up prompts

### DON'T:
- ❌ Be vague or generic
- ❌ Ask for everything at once
- ❌ Skip validation of outputs
- ❌ Forget to specify tech stack
- ❌ Ignore context and constraints

---

## 🎯 Quick Reference by Use Case

### "I need to design a new feature"
1. Agent #6: Requirements → FRs/NFRs
2. Agent #12: API Design → OpenAPI spec
3. Agent #13: Implementation → Code
4. Agent #15: Tests → Unit tests

### "I need to start a new project"
1. Agent #6: Requirements → Technical specs
2. Agent #5: Architecture → Architecture doc
3. Agent #7: Diagrams → C4 diagrams
4. Agent #11: Planning → Sprint plan

### "I need to review and improve code"
1. Agent #14: Code Review → Issues and suggestions
2. Agent #15: Tests → Improve test coverage
3. Agent #13: Refactoring → Improved code

### "I need documentation"
1. Agent #5: Architecture → Architecture doc
2. Agent #12: API Design → API documentation
3. Agent #7: Diagrams → Visual diagrams

---

## 📋 Copy-Paste Ready Templates

See individual agent prompt directories for:
- Complete master prompts
- Extended examples
- Framework-specific variations
- Advanced use cases

**Location:** `ai-agents/[agent-category]/[agent-name]/prompts/`

---

## Version History

- **v1.0** (2024-11-18): Initial prompt library
- Ready for production use
- Covers all 8 agents

---

**Happy Prompting!** 🚀

For detailed documentation on each agent, see the README in each agent's directory.
