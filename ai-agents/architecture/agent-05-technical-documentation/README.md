# Agent #5: Technical Documentation Agent

## Overview

**Purpose:** Create comprehensive system architecture documentation and Architecture Decision Records (ADRs)

**Primary Tool:** Claude AI

**Time Savings:** 80-90% (30 hours → 3 hours)

**Role:** Architecture Documentation Specialist

---

## Capabilities

### Input Processing
- Business requirements documents
- System constraints and non-functional requirements
- Technology preferences
- Stakeholder concerns
- Existing system context

### Output Generation
1. **Architecture Document**
   - System overview and context
   - Architecture vision and principles
   - Quality attributes (scalability, security, performance)
   - Constraints and assumptions

2. **C4 Diagrams**
   - Context diagram (System in environment)
   - Container diagram (High-level architecture)
   - Component diagram (Detailed design)
   - Deployment diagram (Infrastructure)

3. **Architecture Decision Records (ADRs)**
   - Decision title and status
   - Context and problem statement
   - Considered options
   - Decision and rationale
   - Consequences (positive/negative)

4. **Technical Stack Specification**
   - Framework selections
   - Database choices
   - Infrastructure requirements
   - Third-party integrations

---

## Configuration

**Model:** Claude Sonnet 4.5 (recommended for balance of speed and quality)

**Temperature:** 0.3 (for consistency)

**Max Tokens:** 4000+

---

## Triggers

Use this agent when:
- ✅ Starting a new project requiring architecture documentation
- ✅ Need to document architecture decisions
- ✅ Creating RFCs or design proposals
- ✅ Stakeholders require architecture overview
- ✅ Onboarding new team members
- ✅ Planning major refactoring
- ✅ Compliance or audit documentation needed

---

## Success Criteria

### Quality Metrics
- [ ] Architecture document is comprehensive (>10 pages)
- [ ] All major components documented
- [ ] C4 diagrams complete (Context, Container, Component)
- [ ] At least 3-5 ADRs created
- [ ] Tech stack fully specified
- [ ] Stakeholder review completed

### Time Metrics
- [ ] Generation time: <3 hours
- [ ] Review cycles: <2
- [ ] Total time: <5 hours
- [ ] vs Manual: 30 hours (83% savings)

### Business Metrics
- [ ] Stakeholder approval received
- [ ] Team understands architecture
- [ ] Documentation used for implementation
- [ ] Decisions traceable

---

## Integration Points

**Inputs From:**
- Agent #6: Technical Requirement Analysis Agent (technical requirements)
- Business Analysts (business requirements)
- Product Owners (product vision)

**Outputs To:**
- Agent #7: Drawing Agent (diagram specifications)
- Agent #11: Planning Agent (architecture for planning)
- Agent #12: API Design Agent (architecture context)
- Development Team (implementation guide)

---

## Best Practices

### DO:
- ✅ Provide complete business requirements
- ✅ Specify all constraints upfront
- ✅ Include stakeholder concerns
- ✅ Request specific diagram types
- ✅ Ask for ADRs on major decisions
- ✅ Iterate on feedback
- ✅ Save outputs for project reference

### DON'T:
- ❌ Be vague about requirements
- ❌ Skip constraint documentation
- ❌ Forget non-functional requirements
- ❌ Accept output without review
- ❌ Miss stakeholder review
- ❌ Skip ADR documentation

---

## Example Use Cases

### Use Case 1: New Microservice Architecture
**Input:** Requirements for e-commerce platform
**Output:** Complete architecture with API gateway, microservices, event bus, ADRs for tech stack

### Use Case 2: Legacy System Modernization
**Input:** Current monolith system, modernization goals
**Output:** Migration architecture, ADRs for gradual migration strategy

### Use Case 3: Compliance Documentation
**Input:** System overview, compliance requirements (HIPAA, GDPR)
**Output:** Architecture document with security controls, data flow diagrams, compliance mapping

---

## Templates

See `prompts/` directory for:
- `01-architecture-document.md` - Main architecture document template
- `02-adr-template.md` - Architecture Decision Record template
- `03-tech-stack.md` - Technology stack specification template
- `04-c4-diagrams.md` - C4 diagram specifications template

---

## Examples

See `examples/` directory for:
- Sample architecture documents
- Example ADRs
- Real-world outputs

---

## Metrics to Track

| Metric | Target | Actual |
|--------|--------|--------|
| Generation Time | <3h | ___ |
| Review Cycles | <2 | ___ |
| Stakeholder Satisfaction | >85% | ___ |
| Documentation Completeness | 100% | ___ |
| ADR Coverage | >80% decisions | ___ |

---

## Version History

- **v1.0** (2024-11-18): Initial agent specification
