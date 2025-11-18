# Prompt Template: Technical Requirement Analysis

## Master Prompt

```
You are an expert Business Analyst and Requirements Engineer with 15+ years of
experience transforming business requirements into detailed technical specifications.

# Context

Project: [PROJECT_NAME]
Domain: [DOMAIN - e.g., E-commerce, Healthcare, Fintech]
Stakeholders: [STAKEHOLDER_LIST]
Timeline: [TIMELINE]

# Business Requirements

[PASTE_BUSINESS_REQUIREMENTS_HERE]

# Additional Context

Current System: [CURRENT_STATE]
Target Users: [USER_PERSONAS]
Scale: [EXPECTED_SCALE]
Budget: [BUDGET_CONSTRAINTS]

# Task

Analyze the business requirements and produce:

## 1. Functional Requirements (FR)

For EACH feature/capability:

### FR-[NUMBER]: [Feature Name]

**Description:** Clear, concise description

**User Stories:**
- As a [user type], I want to [action], so that [benefit]
- [Additional user stories]

**Detailed Requirements:**
1. [Specific requirement 1]
2. [Specific requirement 2]
3. [...]

**Acceptance Criteria:**
- [ ] Criterion 1 (testable, measurable)
- [ ] Criterion 2
- [ ] [...]

**Business Rules:**
- Rule 1: [Specific business rule]
- Rule 2: [...]

**Dependencies:**
- Depends on: [Other FRs or systems]
- Blocks: [What depends on this]

**Priority:** Critical | High | Medium | Low

**Complexity:** Low | Medium | High | Very High

**Estimated Effort:** [Story points or hours]

---

## 2. Non-Functional Requirements (NFR)

### Performance Requirements

**NFR-PERF-001:** [Specific Performance Requirement]
- Metric: [What to measure]
- Target: [Specific number with units]
- Measurement: [How to measure]
- Priority: [Critical/High/Medium/Low]

Example:
- NFR-PERF-001: API Response Time
  - Metric: 95th percentile response time for API calls
  - Target: < 200ms
  - Measurement: Application Performance Monitoring (APM) tool
  - Priority: High

### Security Requirements

**NFR-SEC-001:** [Specific Security Requirement]
- Standard: [Compliance standard if applicable]
- Control: [What needs to be implemented]
- Verification: [How to verify]
- Priority: [Usually Critical]

### Scalability Requirements

**NFR-SCALE-001:** [Specific Scalability Requirement]
- Metric: [What scales]
- Current: [Current capacity]
- Target: [Target capacity]
- Timeframe: [When needed]

### Availability/Reliability Requirements

**NFR-AVAIL-001:** [Availability Requirement]
- Uptime Target: [e.g., 99.9% = 8.76 hours downtime/year]
- Recovery Time Objective (RTO): [Maximum acceptable downtime]
- Recovery Point Objective (RPO): [Maximum acceptable data loss]

### Compliance Requirements

**NFR-COMP-001:** [Compliance Requirement]
- Regulation: [GDPR, HIPAA, PCI-DSS, SOC2, etc.]
- Requirement: [Specific requirement]
- Verification: [Audit method]

### Usability Requirements

**NFR-USE-001:** [Usability Requirement]
- Standard: [WCAG 2.1 AA, etc.]
- Target: [Specific metric]
- Measurement: [User testing, analytics]

---

## 3. Work Breakdown Structure (WBS)

### Epic: [Epic Name]

#### Feature 1: [Feature Name]
- Task 1.1: [Task description]
  - Effort: [Hours/Story Points]
  - Dependencies: [Other tasks]
  - Assigned to: [Role]

- Task 1.2: [Task description]
  - Effort: [Hours/Story Points]
  - Dependencies: [Other tasks]
  - Assigned to: [Role]

#### Feature 2: [Feature Name]
[...]

**Total Estimated Effort:** [Total hours/points]

---

## 4. Requirements Traceability Matrix

| Req ID | Requirement | Type | Priority | Related FRs | Test Cases | Status |
|--------|-------------|------|----------|-------------|------------|--------|
| FR-001 | [Name] | Functional | High | - | TC-001, TC-002 | Draft |
| NFR-001 | [Name] | Performance | Critical | FR-001 | TC-010 | Draft |

---

## 5. Clarification Questions

### Critical Unknowns (Block Development)
1. [Question about critical ambiguity]
   - **Why:** [Why this blocks development]
   - **For:** [Stakeholder to answer]
   - **Impact:** [What can't proceed without answer]

### High Priority Questions
1. [Important clarification needed]
   - **Context:** [Background]
   - **Options:** [Possible interpretations]
   - **Recommendation:** [Suggested approach]

### Medium Priority Questions
1. [Question that would improve design]
   - **Context:** [Background]
   - **Impact:** [Benefit of clarification]

### Assumptions (Document for Validation)
1. [Assumption made]: [Describe assumption and rationale]

---

## 6. Constraints & Dependencies

### Technical Constraints
- [Constraint 1]: [Description and impact]
- [Constraint 2]: [...]

### Business Constraints
- [Constraint 1]: [Description and impact]
- [Constraint 2]: [...]

### External Dependencies
- [System/Service 1]: [What depends on it]
- [System/Service 2]: [...]

### Resource Constraints
- Team: [Team size and composition]
- Timeline: [Key dates]
- Budget: [Budget limits]

---

## 7. Risk Assessment

| Risk | Probability | Impact | Mitigation | Owner |
|------|-------------|--------|------------|-------|
| [Risk description] | High/Medium/Low | High/Medium/Low | [Mitigation strategy] | [Role] |

---

## 8. Out of Scope

Explicitly list what is NOT included:
- [Out of scope item 1]
- [Out of scope item 2]
- [...]

# Output Format

Provide complete requirements document in markdown format with:
- Clear section headers
- Numbered requirements
- Tables for matrices
- Testable, measurable criteria
- No ambiguous terms (fast, scalable, user-friendly)
- Specific numbers with units

# Quality Standards

- Every FR must have acceptance criteria
- Every NFR must have measurable targets
- Use active voice
- Be specific, not generic
- Avoid "should", "might", "could" - use "must", "will"
- Flag all ambiguities
- Ask clarifying questions
- Consider edge cases
```

---

## Quick Start Template

```
Analyze these business requirements and create detailed technical specifications:

**Project:** [NAME]
**Domain:** [DOMAIN]

**Business Requirements:**
[PASTE REQUIREMENTS]

**Context:**
- Users: [NUMBER/TYPE]
- Scale: [SCALE]
- Timeline: [TIMELINE]

Please provide:
1. Functional Requirements (FRs) with acceptance criteria
2. Non-Functional Requirements (NFRs) with specific targets
3. Work Breakdown Structure
4. Traceability Matrix
5. Clarification Questions
6. Risk Assessment

Format: Comprehensive markdown document.
```

---

## Example Usage

### Input Example

```markdown
# E-Commerce Platform Requirements

## Business Need
Build an online shopping platform for retail business

## Features Needed
- Product catalog with search
- Shopping cart
- Checkout with payment
- User accounts
- Order tracking
- Admin dashboard

## Constraints
- Launch in 6 months
- Support 10K users initially
- Mobile-friendly
- PCI compliant
```

### Output Example (Excerpt)

```markdown
# Technical Requirements Specification

## 1. Functional Requirements

### FR-001: Product Catalog Management

**Description:** System shall provide a comprehensive product catalog with
search, filter, and browse capabilities.

**User Stories:**
- As a customer, I want to search for products by keyword, so that I can
  quickly find what I'm looking for
- As a customer, I want to filter products by category, price, and rating,
  so that I can narrow down my options
- As an admin, I want to add/edit/delete products, so that I can manage
  the catalog

**Detailed Requirements:**
1. System must support minimum 100,000 products
2. Search must return results in < 500ms for 95% of queries
3. Each product must have: name, description, price, images (min 1, max 10),
   category, SKU, inventory count
4. Support product variants (size, color, etc.)
5. Display out-of-stock status
6. Support bulk product import via CSV
7. Product images must be optimized for web (< 200KB each)

**Acceptance Criteria:**
- [ ] User can search products by keyword
- [ ] Search returns relevant results ranked by relevance
- [ ] User can filter by category, price range, rating
- [ ] User can sort by price, popularity, newest
- [ ] Product detail page shows all product information
- [ ] Out-of-stock products are clearly marked
- [ ] Admin can CRUD products via dashboard
- [ ] Bulk import processes 1000 products in < 5 minutes

**Business Rules:**
- Products with 0 inventory are shown as "Out of Stock" but not hidden
- Price must be > 0
- Each product must belong to at least one category
- Product SKUs must be unique
- Deleted products are soft-deleted (archived) for order history

**Dependencies:**
- Depends on: User authentication (FR-003)
- Blocks: Shopping cart (FR-002), Checkout (FR-004)

**Priority:** Critical
**Complexity:** Medium
**Estimated Effort:** 13 story points

---

## 2. Non-Functional Requirements

### Performance Requirements

**NFR-PERF-001: API Response Time**
- Metric: 95th percentile API response time
- Target: < 200ms for read operations, < 500ms for write operations
- Measurement: APM tool (Datadog/New Relic)
- Priority: High

**NFR-PERF-002: Page Load Time**
- Metric: Time to interactive (TTI)
- Target: < 3 seconds on 4G connection
- Measurement: Google Lighthouse
- Priority: High

**NFR-PERF-003: Search Performance**
- Metric: Search query response time
- Target: < 500ms for 95% of queries
- Measurement: Application logs
- Priority: Critical

### Security Requirements

**NFR-SEC-001: Data Encryption**
- Standard: TLS 1.3 for data in transit
- Control: All API communications must use HTTPS
- Verification: Security scan, certificate validation
- Priority: Critical

**NFR-SEC-002: Payment Security**
- Standard: PCI DSS Level 1
- Control: Use PCI-compliant payment gateway (Stripe), no card data storage
- Verification: PCI compliance audit
- Priority: Critical

**NFR-SEC-003: Authentication**
- Standard: OWASP guidelines
- Control: Password requirements (min 12 chars, complexity), MFA optional
- Verification: Security audit
- Priority: Critical

### Scalability Requirements

**NFR-SCALE-001: Concurrent Users**
- Metric: Simultaneous active users
- Current: 0
- Target: 10,000 concurrent users (Year 1), 100,000 (Year 3)
- Timeframe: Year 1 at launch, Year 3 growth

**NFR-SCALE-002: Order Volume**
- Metric: Orders processed per day
- Current: 0
- Target: 1,000 orders/day (Year 1), 10,000 orders/day (Year 3)
- Timeframe: Progressive growth

### Availability/Reliability Requirements

**NFR-AVAIL-001: System Uptime**
- Uptime Target: 99.9% (8.76 hours downtime/year)
- Recovery Time Objective (RTO): 1 hour
- Recovery Point Objective (RPO): 15 minutes
- Measurement: Uptime monitoring (UptimeRobot, Pingdom)

---

## 5. Clarification Questions

### Critical Unknowns
1. **Payment Gateway Preference**
   - Why: Affects integration timeline and PCI compliance approach
   - For: Product Owner, CFO
   - Impact: 2-week difference in timeline between options
   - Options: Stripe (faster, higher fees), PayPal, Square

2. **International Support**
   - Why: Affects currency, language, shipping integrations
   - For: Product Owner
   - Impact: 4-week additional development if multi-currency needed
   - Question: Is international sales required for MVP?

### High Priority Questions
1. **Return/Refund Policy**
   - Context: No mention of return/refund handling
   - Options: (a) No returns for MVP, (b) Simple return request, (c) Full RMA system
   - Recommendation: Option (b) for MVP

2. **Promotional/Discount System**
   - Context: Not mentioned in requirements
   - Impact: Common e-commerce feature, affects pricing logic
   - Question: Should MVP include discount codes, sales, bundles?

[... continued ...]
```

---

## Version

- **Template Version:** 1.0
- **Last Updated:** 2024-11-18
- **Compatible With:** Claude Sonnet 4.5
