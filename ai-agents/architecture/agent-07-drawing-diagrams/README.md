# Agent #7: Drawing Agent

## Overview

**Purpose:** Generate technical diagrams automatically from architecture and design specifications

**Primary Tool:** Claude AI (with Mermaid, PlantUML output)

**Time Savings:** 90-95% (8 hours → 1 hour)

**Role:** Technical Illustrator / Diagram Specialist

---

## Capabilities

### Input Processing
- Architecture documentation
- Technical requirements
- Design specifications
- System descriptions
- Data models

### Output Generation
1. **C4 Diagrams**
   - Context Diagram (System in environment)
   - Container Diagram (High-level architecture)
   - Component Diagram (Detailed components)
   - Code Diagram (Class diagrams)

2. **UML Diagrams**
   - Class Diagrams
   - Sequence Diagrams
   - Activity Diagrams
   - State Diagrams
   - Use Case Diagrams

3. **Database Diagrams**
   - Entity-Relationship Diagrams (ERD)
   - Database Schema Diagrams
   - Data Flow Diagrams

4. **Infrastructure Diagrams**
   - Deployment Diagrams
   - Network Architecture
   - Cloud Architecture (AWS/Azure/GCP)

5. **Flowcharts**
   - Process Flows
   - Decision Trees
   - Business Process Diagrams

---

## Configuration

**Model:** Claude Sonnet 4.5

**Temperature:** 0.3

**Output Formats:**
- Mermaid (recommended - renders in Markdown)
- PlantUML (for complex diagrams)
- DOT/Graphviz (for specialized needs)

---

## Triggers

Use this agent when:
- ✅ Architecture documentation created
- ✅ Need visual representation of system
- ✅ Database schema designed
- ✅ API workflows need illustration
- ✅ Presentation or documentation needs diagrams
- ✅ Team onboarding materials needed
- ✅ Stakeholder communication requires visuals

---

## Success Criteria

### Quality Metrics
- [ ] Diagrams accurately represent architecture
- [ ] All major components included
- [ ] Relationships correctly shown
- [ ] Diagrams render correctly
- [ ] Consistent notation used
- [ ] Stakeholder comprehension >90%

### Time Metrics
- [ ] Generation time: <1 hour for complete set
- [ ] Review cycles: <2
- [ ] vs Manual: 8 hours (87.5% savings)

---

## Integration Points

**Inputs From:**
- Agent #5: Technical Documentation Agent (architecture specs)
- Agent #6: Requirements Agent (system requirements)
- Agent #12: API Design Agent (API specifications)

**Outputs To:**
- Documentation repositories
- Presentation decks
- Team wikis
- Stakeholder reports

---

## Templates

See `prompts/` directory for:
- `01-c4-diagrams.md` - C4 diagram generation
- `02-uml-diagrams.md` - UML diagram templates
- `03-database-diagrams.md` - ERD and schema diagrams
- `04-flowcharts.md` - Process and workflow diagrams

---

## Output Format Examples

### Mermaid (Recommended)
- Renders directly in GitHub, GitLab, Notion
- Copy-paste into markdown files
- Easy to modify

### PlantUML
- More advanced features
- Requires PlantUML renderer
- Better for complex diagrams

---

## Metrics to Track

| Metric | Target | Actual |
|--------|--------|--------|
| Generation Time | <1h | ___ |
| Diagram Accuracy | 100% | ___ |
| Render Success Rate | 100% | ___ |
| Stakeholder Satisfaction | >90% | ___ |

---

## Version History

- **v1.0** (2024-11-18): Initial agent specification
