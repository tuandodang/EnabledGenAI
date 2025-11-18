# Prompt Template: Sprint Planning

## Master Prompt

```
You are an experienced Scrum Master and Project Planner with 10+ years of
experience in agile software development. Create a comprehensive sprint plan.

# Context

Project: [PROJECT_NAME]
Sprint Number: [SPRINT_NUMBER]
Sprint Duration: [2 weeks / 3 weeks]
Sprint Dates: [START_DATE] to [END_DATE]

# Team Information

Team Composition:
- [Role 1]: [Number] developers ([Names if available])
- [Role 2]: [Number] developers
- Total: [TOTAL] developers

Team Capacity:
- Available days: [DAYS - accounting for holidays, PTO]
- Velocity (last 3 sprints): [VELOCITY_1], [VELOCITY_2], [VELOCITY_3]
- Average velocity: [AVG_VELOCITY] story points
- Target velocity this sprint: [TARGET_VELOCITY] story points

# Technical Requirements

[PASTE TECHNICAL REQUIREMENTS from Agent #6]

OR

[LIST OF FEATURES/USER STORIES]

# Sprint Goal

[SPRINT_GOAL - What should be accomplished this sprint]

OR

Please suggest an appropriate sprint goal based on priorities.

# Priorities

1. [PRIORITY_1]
2. [PRIORITY_2]
3. [PRIORITY_3]

# Constraints

- [CONSTRAINT_1 - e.g., "Must complete authentication by end of sprint"]
- [CONSTRAINT_2]
- [...]

# Task

Create a comprehensive sprint plan that includes:

## 1. Sprint Goal

Clear, achievable sprint goal that aligns with product goals.

## 2. Sprint Backlog

For EACH user story:

### US-[NUMBER]: [User Story Title]

**As a** [user type]
**I want** [capability]
**So that** [benefit]

**Priority:** Critical | High | Medium | Low

**Story Points:** [POINTS - using Fibonacci: 1, 2, 3, 5, 8, 13]

**Estimation Rationale:**
- Why this point value
- Complexity factors
- Risk factors
- Dependencies

**Acceptance Criteria:**
- [ ] [Testable criterion 1]
- [ ] [Testable criterion 2]
- [ ] [...]

**Tasks:**
1. [Task 1] - [Estimated hours] - [Suggested assignee role]
2. [Task 2] - [Estimated hours] - [Suggested assignee role]
3. [...]

**Dependencies:**
- Depends on: [Other stories/external items]
- Blocks: [What this blocks]

**Risks:**
- [Risk 1]: [Mitigation]
- [Risk 2]: [Mitigation]

**Definition of Done:**
- [ ] Code complete
- [ ] Unit tests written (>80% coverage)
- [ ] Code reviewed
- [ ] Integration tests pass
- [ ] Documentation updated
- [ ] Deployed to staging
- [ ] Acceptance criteria met

---

## 3. Sprint Commitment

**Total Story Points Committed:** [TOTAL_POINTS]
**Team Capacity:** [CAPACITY] points
**Commitment Status:** [Under/At/Over capacity by X points]

**Risk Assessment:**
- Commitment Risk: Low | Medium | High
- Rationale: [Why this risk level]
- Mitigation: [How to manage risk]

## 4. Sprint Schedule

### Week 1
**Day 1-2:**
- [User stories to start]

**Day 3-4:**
- [User stories to start]

**Day 5:**
- [User stories to start]
- Mid-sprint check-in

### Week 2
**Day 6-8:**
- [User stories to complete]

**Day 9:**
- Code freeze
- Testing and bug fixes

**Day 10:**
- Sprint review prep
- Sprint retrospective

## 5. Release Plan (if applicable)

What will be released/deployed after this sprint:
- [Feature 1]
- [Feature 2]
- [...]

Release date: [DATE]
Release notes: [Key highlights]

## 6. Dependencies & Blockers

**External Dependencies:**
- [Dependency 1]: [Status, owner, impact]
- [Dependency 2]: [...]

**Potential Blockers:**
- [Blocker 1]: [Mitigation plan]
- [Blocker 2]: [...]

## 7. Success Metrics

How to measure sprint success:
- [ ] Sprint goal achieved
- [ ] [X]% of story points completed
- [ ] [X]% of committed stories done
- [ ] Zero high-severity bugs
- [ ] Technical debt [reduced/maintained]

# Output Format

Provide complete sprint plan in markdown format, ready to:
- Share with team
- Import to project management tool
- Use in sprint planning meeting

# Quality Standards

- Stories should be sized appropriately (avoid 13+ point stories)
- Break large stories into smaller ones
- Ensure clear acceptance criteria
- Consider team capacity realistically
- Account for meetings, code review time (20-30% overhead)
- Include time for bug fixes and tech debt
- Balance feature work with quality work
```

---

## Quick Start Template

```
Create a sprint plan for:

**Sprint:** Sprint [NUMBER], [DURATION]
**Dates:** [START] to [END]

**Team:**
- [NUMBER] backend developers
- [NUMBER] frontend developers
- Velocity: [AVERAGE_VELOCITY] points

**Requirements:**
[PASTE USER STORIES OR FEATURES]

**Sprint Goal:** [GOAL or "suggest one"]

**Constraints:**
- [CONSTRAINT 1]
- [CONSTRAINT 2]

Please provide:
1. Sprint goal
2. Sprint backlog with story points
3. Task breakdown
4. Sprint schedule
5. Risk assessment
```

---

## Example Output (Excerpt)

```markdown
# Sprint 5 Plan - E-Commerce Platform

## Sprint Goal
**Enable customers to browse products and add items to shopping cart**

Sprint Dates: Nov 20 - Dec 1, 2024 (2 weeks)
Team Capacity: 40 story points
Commitment: 38 story points

---

## Sprint Backlog

### US-012: Product Catalog Browsing

**As a** customer
**I want** to browse products by category
**So that** I can find products I'm interested in

**Priority:** Critical

**Story Points:** 8

**Estimation Rationale:**
- Medium complexity (filtering, sorting, pagination)
- Backend API + Frontend UI required
- Database queries need optimization
- Some uncertainty around performance requirements
- Risk: Performance at scale

**Acceptance Criteria:**
- [ ] User can view products in a category
- [ ] User can filter by price range
- [ ] User can sort by price, name, popularity
- [ ] Pagination works (20 products per page)
- [ ] Page loads in <2 seconds with 10K products
- [ ] Mobile responsive

**Tasks:**
1. Design database indexes for product queries - 3h - Backend Dev
2. Implement product API endpoints (GET /products) - 5h - Backend Dev
3. Add filtering and sorting logic - 4h - Backend Dev
4. Create product grid component - 4h - Frontend Dev
5. Implement filter UI - 3h - Frontend Dev
6. Add pagination controls - 2h - Frontend Dev
7. Performance testing and optimization - 4h - Backend Dev
8. Write unit tests - 3h - Backend + Frontend
9. Integration testing - 2h - QA

**Total Hours:** 30h

**Dependencies:**
- Depends on: US-010 (Database schema)
- Blocks: US-013 (Shopping cart)

**Risks:**
- Query performance at scale: Mitigate with early load testing
- Filter complexity: Start with basic filters, iterate

**Definition of Done:**
- [ ] Code complete and reviewed
- [ ] Unit tests >80% coverage
- [ ] Integration tests pass
- [ ] Performance meets targets (<2s load time)
- [ ] Deployed to staging
- [ ] Product owner acceptance

---

### US-013: Shopping Cart

**As a** customer
**I want** to add products to my shopping cart
**So that** I can purchase multiple items at once

**Priority:** Critical

**Story Points:** 5

**Estimation Rationale:**
- Moderate complexity
- CRUD operations for cart
- Session management needed
- Well-understood pattern

**Acceptance Criteria:**
- [ ] User can add product to cart
- [ ] User can update quantity
- [ ] User can remove items
- [ ] Cart persists across sessions
- [ ] Cart shows total price
- [ ] Out-of-stock items handled

**Tasks:**
1. Design cart data model - 2h - Backend Dev
2. Implement cart API (POST, PUT, DELETE) - 4h - Backend Dev
3. Add session management - 3h - Backend Dev
4. Create cart component - 4h - Frontend Dev
5. Implement cart icon with count - 2h - Frontend Dev
6. Add cart page - 4h - Frontend Dev
7. Write tests - 3h - Backend + Frontend

**Total Hours:** 22h

**Dependencies:**
- Depends on: US-012 (Product catalog)
- Blocks: US-015 (Checkout)

**Risks:**
- Session persistence complexity: Use Redis for simplicity

---

[... more user stories ...]

---

## Sprint Commitment

**Total Story Points:** 38 points
**Team Velocity:** 40 points average
**Capacity Utilization:** 95%

**Commitment Risk:** Medium

**Rationale:**
- Slightly below capacity provides buffer
- Some stories have technical uncertainty
- One junior developer on team (learning curve)

**Mitigation:**
- Daily standups to catch blockers early
- Pair programming for complex tasks
- Mid-sprint review to adjust if needed

---

## Sprint Schedule

### Week 1 (Nov 20-24)

**Monday-Tuesday:**
- Kick off US-012 (Product Catalog)
- Backend: Database and API work
- Frontend: Component setup

**Wednesday-Thursday:**
- Continue US-012
- Start US-013 (Shopping Cart) backend
- Mid-sprint sync on Thursday afternoon

**Friday:**
- Complete US-012 backend
- US-013 in progress
- Mid-sprint review/adjustment

### Week 2 (Nov 27-Dec 1)

**Monday-Tuesday:**
- Complete US-013
- Start US-014 (smaller story)
- Begin testing and bug fixes

**Wednesday:**
- Complete remaining stories
- Code freeze end of day

**Thursday:**
- Testing, bug fixes, polish
- Sprint review preparation

**Friday:**
- Sprint review at 10 AM
- Sprint retrospective at 2 PM
- Sprint 6 planning at 3 PM

---

## Success Metrics

Sprint will be successful if:
- [ ] Sprint goal achieved (browse + cart functional)
- [ ] 85%+ of story points completed
- [ ] Zero P0/P1 bugs
- [ ] Code coverage remains >80%
- [ ] All committed stories meet DoD

---

## Dependencies & Blockers

**External Dependencies:**
- Payment gateway sandbox access (needed for future sprint)
- Design mockups for checkout flow (needed by Dec 5)

**Potential Blockers:**
- Performance issues with product queries: Plan load testing early
- Redis setup for session management: DevOps to provision by Nov 21

**Action Items:**
- [ ] Request payment gateway sandbox access
- [ ] Schedule design review for checkout
- [ ] Provision Redis instance
```

---

## Tips for Best Results

1. **Provide Team Context:** Velocity, capacity, composition
2. **Be Clear on Priorities:** What must be done vs nice-to-have
3. **Include Constraints:** Hard deadlines, dependencies
4. **Iterate:** Refine estimates with team input
5. **Use Historical Data:** Reference past sprint velocity

---

## Version

- **Template Version:** 1.0
- **Last Updated:** 2024-11-18
- **Compatible With:** Claude Sonnet 4.5
