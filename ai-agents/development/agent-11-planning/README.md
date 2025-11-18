# Agent #11: Planning Agent

## Overview

**Purpose:** Create sprint plans and detailed task breakdowns from technical requirements

**Primary Tool:** Claude AI

**Time Savings:** 75-85% (12 hours → 2 hours)

**Role:** Scrum Master / Project Planner

---

## Capabilities

### Input Processing
- Technical requirements
- Team composition and capacity
- Timeline constraints
- Dependencies
- Priorities

### Output Generation
1. **Sprint Plans**
   - Sprint goals
   - User story breakdown
   - Story point estimates
   - Sprint backlog

2. **Development Roadmap**
   - Release planning
   - Milestone definition
   - Feature sequencing
   - Risk timeline

3. **Task Breakdown**
   - Detailed tasks per story
   - Sub-tasks and acceptance criteria
   - Assignment recommendations
   - Dependency mapping

4. **Effort Estimates**
   - Story points
   - Hour estimates
   - Confidence levels
   - Risk buffers

5. **Resource Allocation**
   - Team member assignments
   - Capacity planning
   - Skill matching

---

## Configuration

**Model:** Claude Sonnet 4.5

**Temperature:** 0.3

**Max Tokens:** 4000+

---

## Triggers

Use this agent when:
- ✅ Starting new sprint planning
- ✅ Need to estimate project timeline
- ✅ Creating product roadmap
- ✅ Breaking down epics into stories
- ✅ Resource planning needed
- ✅ Release planning session
- ✅ Need to re-estimate work

---

## Success Criteria

### Quality Metrics
- [ ] All user stories have story points
- [ ] Tasks are appropriately sized (<8 hours each)
- [ ] Dependencies identified
- [ ] Sprint commitment realistic
- [ ] Team capacity considered
- [ ] Acceptance criteria clear

### Time Metrics
- [ ] Planning time: <2 hours
- [ ] Review cycles: <2
- [ ] vs Manual: 12 hours (83% savings)

### Business Metrics
- [ ] Sprint completion rate: >85%
- [ ] Estimate accuracy: ±20%
- [ ] Team satisfaction with planning: >80%

---

## Integration Points

**Inputs From:**
- Agent #6: Technical Requirements
- Agent #5: Architecture Documentation
- Product Owners (priorities)
- Team (capacity, velocity)

**Outputs To:**
- Project management tools (Jira, Linear, etc.)
- Team (sprint backlog)
- Stakeholders (roadmap)
- Agent #12: API Design Agent

---

## Templates

See `prompts/` directory for:
- `01-sprint-planning.md` - Sprint planning template
- `02-roadmap-creation.md` - Product roadmap template
- `03-task-breakdown.md` - Epic/story breakdown template
- `04-estimation.md` - Effort estimation template

---

## Metrics to Track

| Metric | Target | Actual |
|--------|--------|--------|
| Planning Time | <2h | ___ |
| Sprint Completion | >85% | ___ |
| Estimate Accuracy | ±20% | ___ |
| Team Satisfaction | >80% | ___ |

---

## Version History

- **v1.0** (2024-11-18): Initial agent specification
