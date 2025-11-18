# Agent #15: Unit Test Agent

## Overview

**Purpose:** Generate comprehensive unit tests with high coverage

**Primary Tool:** Cursor AI (with Claude integration)

**Time Savings:** 90-95% (30 hours → 3 hours)

**Role:** QA Engineer / Test Automation Specialist

---

## Capabilities

### Input Processing
- Source code (classes, functions, modules)
- API specifications
- Acceptance criteria
- Business requirements
- Edge cases documentation

### Output Generation
1. **Unit Test Classes**
   - Test classes for each component
   - Comprehensive test methods
   - Clear test naming
   - Proper test structure (Arrange-Act-Assert)

2. **Test Fixtures & Setup**
   - Test data setup
   - Before/After hooks
   - Test builders
   - Factory methods

3. **Mocks & Stubs**
   - Mock objects for dependencies
   - Stub data for external services
   - Spy objects for verification
   - Proper mock isolation

4. **Edge Case Tests**
   - Boundary value tests
   - Null/empty input handling
   - Error condition tests
   - Concurrency tests (if applicable)

5. **Integration Test Scaffolding**
   - Integration test structure
   - Database test setup
   - API test templates
   - End-to-end test scenarios

---

## Configuration

**Tool:** Cursor AI with Claude Sonnet 4.5

**Temperature:** 0.2

**Mode:** Composer Mode

---

## Triggers

Use this agent when:
- ✅ New code implementation complete
- ✅ Need to improve test coverage
- ✅ TDD implementation (tests first)
- ✅ Regression test suite needed
- ✅ Refactoring with test safety
- ✅ Bug fix requiring tests
- ✅ CI/CD pipeline requires tests

---

## Success Criteria

### Quality Metrics
- [ ] Code coverage >80%
- [ ] All critical paths tested
- [ ] Edge cases covered
- [ ] Tests are independent
- [ ] Tests are fast (<100ms each)
- [ ] No flaky tests

### Time Metrics
- [ ] Test generation time: <3 hours
- [ ] vs Manual: 30 hours (90% savings)

### Business Metrics
- [ ] Bug detection in tests: >90%
- [ ] Test maintenance effort: <10%
- [ ] Developer confidence: >85%

---

## Integration Points

**Inputs From:**
- Agent #13: Implementation Agent (source code)
- Agent #12: API Design (specifications)
- Agent #6: Requirements (acceptance criteria)

**Outputs To:**
- CI/CD pipeline
- Code coverage tools
- Test reports
- Quality dashboards

---

## Supported Test Frameworks

### Java
- JUnit 5
- Mockito
- AssertJ
- Spring Boot Test

### JavaScript/TypeScript
- Jest
- Mocha + Chai
- Vitest
- Sinon (mocking)

### Python
- pytest
- unittest
- mock/unittest.mock
- faker (test data)

### Go
- testing package
- testify
- gomock

---

## Test Coverage Goals

### Unit Tests
- All public methods
- All business logic
- All error paths
- All edge cases

### Test Types
- **Positive tests:** Happy path
- **Negative tests:** Error conditions
- **Boundary tests:** Min/max values
- **Null tests:** Null handling
- **Exception tests:** Error handling

---

## Templates

See `prompts/` directory for:
- `01-junit-tests.md` - JUnit 5 test generation
- `02-jest-tests.md` - Jest test generation
- `03-pytest-tests.md` - pytest test generation
- `04-integration-tests.md` - Integration test templates

---

## Test Quality Standards

### AAA Pattern
- **Arrange:** Set up test data and conditions
- **Act:** Execute the method under test
- **Assert:** Verify expected outcome

### Test Naming
- Descriptive test names
- Format: `should_ExpectedBehavior_When_StateUnderTest`
- Example: `shouldReturnProduct_WhenValidIdProvided`

### Test Independence
- No test order dependency
- Each test cleans up after itself
- No shared mutable state

---

## Metrics to Track

| Metric | Target | Actual |
|--------|--------|--------|
| Test Generation Time | <3h | ___ |
| Code Coverage | >80% | ___ |
| Test Pass Rate | 100% | ___ |
| Test Speed | <100ms/test | ___ |

---

## Version History

- **v1.0** (2024-11-18): Initial agent specification
