# Quick Reference Guide - AI Agents for Backend Development

**Print this page and keep it handy!**

---

## 🎯 Quick Decision Tree

**I need to...**

```
├─ Understand requirements
│  └─ Use Agent #6 (Requirement Analysis)
│     Input: Business requirements
│     Output: FRs, NFRs, WBS, questions
│     Tool: Claude AI
│     Time: 4h → 30min
│
├─ Design architecture
│  └─ Use Agent #5 (Technical Documentation)
│     Input: Technical requirements
│     Output: Architecture doc, ADRs
│     Tool: Claude AI
│     Time: 30h → 3h
│
├─ Create diagrams
│  └─ Use Agent #7 (Diagram Generation)
│     Input: Architecture docs
│     Output: C4, UML, ERD (Mermaid)
│     Tool: Claude AI
│     Time: 8h → 1h
│
├─ Plan sprint
│  └─ Use Agent #11 (Sprint Planning)
│     Input: Requirements, team info
│     Output: Sprint plan, tasks, estimates
│     Tool: Claude AI
│     Time: 12h → 2h
│
├─ Design API
│  └─ Use Agent #12 (API Design)
│     Input: Requirements, data models
│     Output: API design, OpenAPI spec
│     Tool: Claude AI
│     Time: 24h → 3h
│
├─ Write code
│  └─ Use Agent #13 (Implementation)
│     Input: API design, schema
│     Output: Complete code (all layers)
│     Tool: Cursor AI
│     Time: 60h → 8h
│
├─ Review code
│  └─ Use Agent #14 (Code Review)
│     Input: Source code
│     Output: Quality/security report
│     Tool: Claude AI
│     Time: 3h → 30min
│
└─ Write tests
   └─ Use Agent #15 (Unit Testing)
      Input: Source code
      Output: Unit tests, mocks
      Tool: Cursor AI
      Time: 30h → 3h
```

---

## 📝 Agent Cheat Sheet

| Agent | Tool | Input | Output | Time Savings |
|-------|------|-------|--------|--------------|
| **#5** Doc | Claude | Business reqs | Arch doc, ADRs | 90% |
| **#6** Reqs | Claude | Business reqs | FRs, NFRs | 90% |
| **#7** Diagrams | Claude | Arch docs | C4, UML, ERD | 87.5% |
| **#11** Planning | Claude | Tech reqs, team | Sprint plan | 83.3% |
| **#12** API | Claude | Reqs, models | API design, OpenAPI | 87.5% |
| **#13** Code | Cursor | API, schema | Full code | 86.7% |
| **#14** Review | Claude | Source code | Review report | 83.3% |
| **#15** Tests | Cursor | Source code | Unit tests | 90% |

---

## 🔄 Common Workflows

### New Feature (Complete)
```
#6 → #5 → #12 → #13 → #15 → #14
(30min) (1h) (1h) (4h) (2h) (30min)
Total: 9h vs 110h traditional (92% savings)
```

### API-First Development
```
#6 → #12 → #13 → #15 → #14
(30min) (1h) (3h) (1.5h) (30min)
Total: 6.5h vs 50h traditional (87% savings)
```

### Documentation Only
```
#6 → #5 → #7
(30min) (1h) (30min)
Total: 2h vs 40h traditional (95% savings)
```

### Sprint Planning
```
#11 → [#12 → #13 → #15 → #14] per story
(1h) + (per story workflow)
```

---

## 💡 Quick Tips

### For Claude AI
- ✅ Be specific with context
- ✅ Include all constraints upfront
- ✅ Request specific output format
- ✅ Iterate if output is truncated
- ✅ Save successful prompts

### For Cursor AI
- ✅ Use @mentions for files
- ✅ Use Composer mode (Cmd/Ctrl+I)
- ✅ Reference multiple files for context
- ✅ Create .cursorrules file
- ✅ Review generated code

### General
- ⚠️ Always validate AI output
- ⚠️ Review before committing
- ⚠️ Test generated code
- ⚠️ Don't skip security review
- ⚠️ Document what works

---

## 🚀 Emergency Quick Start

**Need to start NOW?**

1. **Go to:** claude.ai
2. **Create account** (15 min)
3. **Copy this prompt:**

```
Design a REST API for [YOUR FEATURE]:

**Requirements:**
[PASTE YOUR REQUIREMENTS]

**Framework:** [YOUR FRAMEWORK]

Provide:
1. API design document
2. OpenAPI 3.0 specification
3. Request/response examples
4. Error handling

Format: Markdown + YAML
```

4. **Paste and submit**
5. **Review output** (1 hour total)

Congratulations! You just saved 20+ hours! 🎉

---

## 📊 Quick ROI Calculator

**Time saved this project:**

| Agent Used | Time Saved |
|------------|------------|
| #5 | ___h |
| #6 | ___h |
| #7 | ___h |
| #11 | ___h |
| #12 | ___h |
| #13 | ___h |
| #14 | ___h |
| #15 | ___h |
| **TOTAL** | **___h** |

**Hours × Hourly Rate = $_____saved**

---

## 🔗 Quick Links

**Documentation:**
- Quick Start: `docs/quick-start-guide.md`
- Prompts: `docs/prompt-templates-library.md`
- Examples: `docs/example-workflows.md`
- Checklist: `docs/implementation-checklist.md`

**Tools:**
- Claude: https://claude.ai
- Cursor: https://cursor.com
- Copilot: https://github.com/features/copilot

**Validation:**
- OpenAPI: https://editor.swagger.io
- Mermaid: https://mermaid.live

---

## 🐛 Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| Output truncated | Type "Please continue" |
| Tool doesn't understand | Add more context, use @mentions |
| API spec errors | Validate at editor.swagger.io |
| Code won't compile | Be more specific about framework version |
| Tests failing | Ask agent to fix with error message |

---

## ✅ Daily Checklist

**Using an agent?**

- [ ] Read agent README
- [ ] Prepare inputs (requirements, context)
- [ ] Use prompt template
- [ ] Review output
- [ ] Validate (compile, render, test)
- [ ] Measure time saved
- [ ] Document learnings

---

## 📞 Getting Help

1. Check agent README
2. Review prompt templates
3. Look at examples
4. Check troubleshooting guide
5. Ask team member

---

## 🎯 Success Criteria

**You're successful when:**

- ✅ Saving >80% time per agent
- ✅ Output quality >8/10
- ✅ Using agents regularly
- ✅ Team is adopting (>50%)
- ✅ ROI is positive
- ✅ Code quality maintained

---

## 💪 Motivational Stats

- **88.2%** average time savings
- **1,117%** ROI after 1 project
- **6,083%** ROI after 5 projects
- **<1 project** to break even

**You can do this!** 🚀

---

**Version:** 1.0
**Last Updated:** 2024-11-18

Keep this guide handy and refer to it often!
