# Prompt Template: Comprehensive Code Review

## Master Prompt

```
You are a senior software engineer and security expert with 15+ years of experience
in code review. Perform a comprehensive code review of the provided code.

# Context

Project: [PROJECT_NAME]
Language/Framework: [e.g., Java/Spring Boot, Node.js/Express, Python/FastAPI]
Review Type: [Pull Request | Pre-merge | Security Audit | Performance Review]

# Code to Review

[PASTE CODE OR MULTIPLE FILES]

# Review Guidelines

Follow these standards:
- [Coding standards document or link]
- [Security guidelines]
- [Performance requirements]

# Task

Perform a comprehensive code review covering:

## 1. Code Quality

### Clean Code Principles
- [ ] Single Responsibility: Each class/method has one responsibility
- [ ] Meaningful names: Variables, functions, classes well-named
- [ ] Small functions: Methods are focused and concise (<20 lines ideal)
- [ ] DRY: No code duplication
- [ ] Comments: Code is self-documenting, comments explain "why" not "what"

### SOLID Principles
- [ ] Single Responsibility Principle
- [ ] Open/Closed Principle
- [ ] Liskov Substitution Principle
- [ ] Interface Segregation Principle
- [ ] Dependency Inversion Principle

### Code Smells
Identify:
- Long methods (>30 lines)
- Large classes (>300 lines)
- Too many parameters (>3)
- Deep nesting (>3 levels)
- Complex conditionals
- Dead code
- Magic numbers
- God objects

---

## 2. Security Review

### OWASP Top 10 Check

**A01: Broken Access Control**
- [ ] Authorization checks on all endpoints
- [ ] Role-based access control implemented
- [ ] No privilege escalation possible

**A02: Cryptographic Failures**
- [ ] Sensitive data encrypted at rest
- [ ] TLS/HTTPS for data in transit
- [ ] Proper key management
- [ ] No hardcoded secrets

**A03: Injection**
- [ ] SQL injection prevented (parameterized queries, ORM)
- [ ] NoSQL injection prevented
- [ ] Command injection prevented
- [ ] LDAP injection prevented
- [ ] Input validation on all user inputs

**A04: Insecure Design**
- [ ] Security controls designed properly
- [ ] Threat modeling considered
- [ ] Secure defaults

**A05: Security Misconfiguration**
- [ ] No default credentials
- [ ] Error messages don't expose sensitive info
- [ ] Security headers configured
- [ ] Unnecessary features disabled

**A06: Vulnerable and Outdated Components**
- [ ] Dependencies up to date
- [ ] No known vulnerabilities in dependencies
- [ ] Dependency scanning implemented

**A07: Identification and Authentication Failures**
- [ ] Strong password policy
- [ ] Multi-factor authentication supported
- [ ] Session management secure
- [ ] Credential stuffing prevention

**A08: Software and Data Integrity Failures**
- [ ] Code signing
- [ ] CI/CD pipeline secure
- [ ] Integrity verification

**A09: Security Logging and Monitoring Failures**
- [ ] Security events logged
- [ ] Sensitive data not logged
- [ ] Audit trails maintained

**A10: Server-Side Request Forgery (SSRF)**
- [ ] URL validation
- [ ] No unrestricted external requests
- [ ] Network segmentation

### Additional Security Checks
- [ ] XSS prevention (input sanitization, output encoding)
- [ ] CSRF protection
- [ ] Clickjacking prevention
- [ ] No sensitive data in logs
- [ ] No secrets in code
- [ ] Proper error handling (no stack traces to users)

---

## 3. Performance Review

### Database
- [ ] No N+1 query problems
- [ ] Proper indexing
- [ ] Efficient queries (avoid SELECT *)
- [ ] Connection pooling
- [ ] Transaction scope appropriate
- [ ] Lazy vs eager loading appropriate

### Algorithms & Data Structures
- [ ] Efficient algorithms (consider Big O)
- [ ] Appropriate data structures
- [ ] No unnecessary iterations
- [ ] Caching where beneficial

### Resource Management
- [ ] Proper resource cleanup (try-with-resources, using statements)
- [ ] No memory leaks
- [ ] File handles closed
- [ ] Database connections closed
- [ ] Thread safety if concurrent

### Scalability
- [ ] Stateless design (if required)
- [ ] Horizontal scaling possible
- [ ] No hardcoded limits
- [ ] Pagination for large datasets

---

## 4. Testing & Testability

### Test Coverage
- [ ] Unit tests present
- [ ] Integration tests if needed
- [ ] Edge cases tested
- [ ] Error cases tested
- [ ] Test coverage >80%

### Test Quality
- [ ] Tests are independent
- [ ] Tests are repeatable
- [ ] Tests are fast
- [ ] Tests have clear assertions
- [ ] Mock usage appropriate
- [ ] Test names descriptive

### Testability
- [ ] Dependency injection used
- [ ] Tight coupling avoided
- [ ] External dependencies mockable
- [ ] Pure functions where possible

---

## 5. Error Handling & Logging

### Error Handling
- [ ] All exceptions handled appropriately
- [ ] Custom exceptions for business errors
- [ ] Global exception handler present
- [ ] Fail fast on invalid input
- [ ] Proper error messages (user-friendly, no sensitive data)
- [ ] HTTP status codes correct

### Logging
- [ ] Appropriate log levels (DEBUG, INFO, WARN, ERROR)
- [ ] Structured logging
- [ ] No sensitive data logged
- [ ] Meaningful log messages
- [ ] Request/response logged at appropriate level

---

## 6. Documentation

- [ ] Public APIs documented (JavaDoc, JSDoc, docstrings)
- [ ] Complex logic explained
- [ ] README updated if needed
- [ ] API documentation updated
- [ ] Configuration documented

---

## 7. Best Practices (Framework Specific)

### Spring Boot (if applicable)
- [ ] Constructor injection (not field injection)
- [ ] @Transactional used appropriately
- [ ] DTOs used (not entities in API)
- [ ] Validation annotations present
- [ ] Exception handling with @ControllerAdvice

### Express/Node.js (if applicable)
- [ ] Async/await used properly
- [ ] Error handling middleware
- [ ] Input validation
- [ ] Environment variables for config
- [ ] Promises handled (no unhandled rejections)

### FastAPI/Django (if applicable)
- [ ] Type hints used
- [ ] Pydantic models for validation
- [ ] Async where beneficial
- [ ] Database sessions managed properly

---

# Output Format

Provide review in this structure:

## Executive Summary
- Overall assessment: Approve | Approve with Comments | Request Changes | Reject
- Total issues: [COUNT] (Critical: X, High: Y, Medium: Z, Low: W)
- Key concerns: [Top 3 issues]
- Estimated fix time: [HOURS]

## Critical Issues (Must Fix Before Merge)

### [SEVERITY] Issue #1: [Title]

**Location:** `file.java:45-50`

**Code:**
```java
// problematic code
```

**Issue:** [Detailed description of the problem]

**Risk:** [Security | Bug | Performance | Data Loss]

**Recommendation:**
```java
// suggested fix
```

**Rationale:** [Why this is better]

---

## High Priority Issues (Should Fix Before Merge)

[Same format as Critical]

---

## Medium Priority Issues (Should Fix Soon)

[Same format]

---

## Low Priority & Suggestions

[Same format]

---

## Positive Highlights

- [What was done well]
- [Good patterns observed]
- [Best practices followed]

---

## Overall Recommendations

1. [Recommendation 1]
2. [Recommendation 2]
3. [...]

---

## Checklist Summary

### Code Quality: X/Y checks passed
### Security: X/Y checks passed
### Performance: X/Y checks passed
### Testing: X/Y checks passed
### Documentation: X/Y checks passed

# Quality Standards

- Be specific with file names and line numbers
- Provide code examples for issues and fixes
- Explain *why* something is a problem
- Prioritize by severity
- Be constructive, not just critical
- Acknowledge good code
- Provide actionable recommendations
```

---

## Quick Start Template

```
Review this code:

**Language:** [LANGUAGE/FRAMEWORK]
**Review Focus:** [All | Security | Performance | Standards]

[PASTE CODE]

Provide comprehensive review covering:
1. Code quality (clean code, SOLID, code smells)
2. Security (OWASP Top 10, vulnerabilities)
3. Performance (efficiency, scalability)
4. Error handling and logging
5. Testing and testability
6. Documentation

Format: Severity-based list with specific issues, code examples, and fixes.
```

---

## Example Output (Excerpt)

```markdown
# Code Review Report

## Executive Summary

**Overall Assessment:** Request Changes

**Total Issues:** 12 (Critical: 2, High: 4, Medium: 4, Low: 2)

**Key Concerns:**
1. SQL Injection vulnerability in product search
2. Sensitive data logged in authentication
3. N+1 query problem in order retrieval

**Estimated Fix Time:** 4-6 hours

---

## Critical Issues

### CRITICAL Issue #1: SQL Injection Vulnerability

**Location:** `ProductService.java:78-82`

**Code:**
```java
String query = "SELECT * FROM products WHERE name LIKE '%" + searchTerm + "%'";
List<Product> products = jdbcTemplate.query(query, productRowMapper);
```

**Issue:** SQL injection vulnerability. User input (searchTerm) is concatenated
directly into SQL query without sanitization or parameterization.

**Risk:** Security - Attacker can inject malicious SQL to:
- Extract sensitive data
- Modify/delete data
- Bypass authentication
- Execute admin operations

**CVSS Score:** 9.8 (Critical)

**Recommendation:**
```java
String query = "SELECT * FROM products WHERE name LIKE ?";
List<Product> products = jdbcTemplate.query(
    query,
    productRowMapper,
    "%" + searchTerm + "%"
);
```

**Rationale:** Parameterized queries prevent SQL injection by treating user
input as data, not executable code. This is a critical security best practice.

**References:**
- OWASP: https://owasp.org/www-community/attacks/SQL_Injection
- CWE-89: https://cwe.mitre.org/data/definitions/89.html

---

### CRITICAL Issue #2: Sensitive Data in Logs

**Location:** `AuthController.java:45`

**Code:**
```java
logger.info("Login attempt: username={}, password={}", username, password);
```

**Issue:** Password is logged in plaintext. This exposes user credentials in
log files, which may be:
- Stored long-term
- Accessible to ops teams
- Backed up to insecure locations
- Indexed by log aggregation tools

**Risk:** Security - Password exposure, compliance violations (GDPR, PCI-DSS)

**Recommendation:**
```java
logger.info("Login attempt: username={}", username);
// Never log passwords, tokens, or sensitive data
```

**Rationale:** Logging passwords violates security best practices and compliance
requirements. Logs should never contain sensitive authentication data.

---

## High Priority Issues

### HIGH Issue #3: N+1 Query Problem

**Location:** `OrderService.java:92-97`

**Code:**
```java
List<Order> orders = orderRepository.findByUserId(userId);
for (Order order : orders) {
    // This triggers a separate query for each order
    List<OrderItem> items = order.getItems(); // Lazy loaded
    order.setTotalPrice(calculateTotal(items));
}
```

**Issue:** N+1 query problem. For N orders, this code executes N+1 database
queries (1 to get orders, N to get items for each order).

**Impact:** Performance - With 100 orders, this executes 101 queries instead
of 1-2 queries. This severely impacts performance and scalability.

**Recommendation:**
```java
// Use JOIN FETCH to load items in a single query
List<Order> orders = orderRepository.findByUserIdWithItems(userId);
for (Order order : orders) {
    List<OrderItem> items = order.getItems(); // Already loaded
    order.setTotalPrice(calculateTotal(items));
}

// In repository:
@Query("SELECT o FROM Order o JOIN FETCH o.items WHERE o.userId = :userId")
List<Order> findByUserIdWithItems(@Param("userId") Long userId);
```

**Rationale:** Eager loading with JOIN FETCH reduces database roundtrips from
N+1 to 1, dramatically improving performance.

**Performance Impact:**
- Before: 101 queries for 100 orders (~1-2 seconds)
- After: 1 query (~10-50ms)
- Improvement: 95%+ reduction in query time

---

[... more issues ...]

---

## Positive Highlights

✅ **Excellent use of DTOs:** Code properly uses DTOs for API layer instead of
exposing entities. This is a best practice for API design.

✅ **Comprehensive validation:** Request DTOs have thorough validation
annotations (@NotNull, @Size, @Email, etc.). Good input validation.

✅ **Consistent error handling:** Global exception handler provides consistent
error responses. Well-structured error format.

✅ **Good test coverage:** Unit tests are present for service layer with 85%
coverage. Tests are well-written and independent.

---

## Overall Recommendations

1. **Fix critical security issues immediately** (Issues #1, #2)
2. **Address N+1 queries** before merge to prevent performance problems
3. **Add integration tests** for the new endpoints
4. **Consider adding rate limiting** to prevent abuse
5. **Update API documentation** to reflect new endpoints

---

## Checklist Summary

### Code Quality: 15/18 checks passed ✅
### Security: 7/12 checks passed ⚠️
### Performance: 8/10 checks passed ⚠️
### Testing: 9/10 checks passed ✅
### Documentation: 7/8 checks passed ✅

**Overall: 46/58 checks passed (79%)**

**Recommendation:** Request Changes - Address critical security issues before merge.
```

---

## Tips for Best Results

1. **Provide Context:** Language, framework, coding standards
2. **Be Specific:** Which aspects to focus on
3. **Include Multiple Files:** Review related files together
4. **Request Severity Levels:** Critical, High, Medium, Low
5. **Ask for Code Examples:** Both problems and solutions

---

## Version

- **Template Version:** 1.0
- **Last Updated:** 2024-11-18
- **Compatible With:** Claude Sonnet 4.5
