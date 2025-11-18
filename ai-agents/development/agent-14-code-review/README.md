# Agent #14: Code Review Agent

## Overview

**Purpose:** Automated code quality, security, and performance review

**Primary Tool:** Claude AI

**Time Savings:** 85-90% (3 hours → 0.5 hours)

**Role:** Senior Code Reviewer / Security Auditor

---

## Capabilities

### Input Processing
- Source code files
- Pull requests
- Coding standards documentation
- Security guidelines
- Performance requirements

### Output Generation
1. **Code Quality Report**
   - Code smells
   - Anti-patterns
   - Best practice violations
   - Maintainability issues
   - Complexity analysis

2. **Security Findings**
   - Security vulnerabilities (OWASP Top 10)
   - SQL injection risks
   - XSS vulnerabilities
   - Authentication/authorization issues
   - Data exposure risks
   - Dependency vulnerabilities

3. **Performance Issues**
   - N+1 query problems
   - Inefficient algorithms
   - Memory leaks
   - Resource management issues
   - Caching opportunities

4. **Refactoring Suggestions**
   - Code duplication
   - Long methods/classes
   - Complex conditionals
   - Design pattern opportunities
   - SOLID principle violations

5. **Standards Compliance**
   - Naming conventions
   - Documentation completeness
   - Error handling patterns
   - Logging standards
   - Test coverage

---

## Configuration

**Model:** Claude Sonnet 4.5

**Temperature:** 0.2

**Max Tokens:** 4000+

---

## Triggers

Use this agent when:
- ✅ Pull request created
- ✅ Code ready for review
- ✅ Pre-merge quality check
- ✅ Security audit needed
- ✅ Performance review required
- ✅ Refactoring assessment
- ✅ Code standards enforcement

---

## Success Criteria

### Quality Metrics
- [ ] All critical issues identified
- [ ] Security vulnerabilities found
- [ ] Performance issues flagged
- [ ] Actionable recommendations provided
- [ ] Standards compliance verified

### Time Metrics
- [ ] Review time: <30 minutes
- [ ] vs Manual: 3 hours (83% savings)

### Business Metrics
- [ ] Bug detection rate: >95%
- [ ] False positive rate: <10%
- [ ] Developer satisfaction: >85%

---

## Integration Points

**Inputs From:**
- Agent #13: Implementation Agent (code)
- Version control (pull requests)
- Security team (guidelines)
- Architecture team (standards)

**Outputs To:**
- Developers (review feedback)
- Pull request comments
- Code quality dashboards
- Security reports

---

## Review Categories

### 1. Code Quality
- Clean code principles
- DRY violations
- SOLID principles
- Code complexity
- Maintainability

### 2. Security
- OWASP Top 10
- Input validation
- Authentication/authorization
- Data encryption
- Dependency security

### 3. Performance
- Algorithm efficiency
- Database queries
- Caching strategy
- Resource management
- Scalability

### 4. Testing
- Test coverage
- Test quality
- Edge cases
- Mock usage
- Integration tests

### 5. Documentation
- Code comments
- JavaDoc/JSDoc
- README
- API documentation

---

## Templates

See `prompts/` directory for:
- `01-comprehensive-review.md` - Full code review template
- `02-security-review.md` - Security-focused review
- `03-performance-review.md` - Performance-focused review
- `04-standards-compliance.md` - Standards compliance check

---

## Severity Levels

- **Critical:** Must fix before merge (security, bugs)
- **High:** Should fix before merge (quality, performance)
- **Medium:** Should fix soon (maintainability)
- **Low:** Nice to have (style, minor improvements)
- **Info:** Suggestions and best practices

---

## Metrics to Track

| Metric | Target | Actual |
|--------|--------|--------|
| Review Time | <30min | ___ |
| Bug Detection | >95% | ___ |
| False Positives | <10% | ___ |
| Developer Satisfaction | >85% | ___ |

---

## Version History

- **v1.0** (2024-11-18): Initial agent specification
