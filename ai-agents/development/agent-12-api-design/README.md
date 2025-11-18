# Agent #12: API Design Agent (Design Note Agent)

## Overview

**Purpose:** Design APIs and create comprehensive OpenAPI specifications

**Primary Tool:** Claude AI

**Time Savings:** 85-90% (24 hours → 3 hours)

**Role:** API Architect / Technical Writer

---

## Capabilities

### Input Processing
- Technical requirements
- Data models
- User stories
- Integration requirements
- Architecture documentation

### Output Generation
1. **API Design Document**
   - API overview and principles
   - Authentication/authorization
   - Versioning strategy
   - Error handling
   - Rate limiting
   - Pagination strategy

2. **OpenAPI 3.0 Specification**
   - Complete paths and operations
   - Request/response schemas
   - Authentication schemes
   - Example payloads
   - Error responses

3. **Request/Response Schemas**
   - JSON schemas
   - Validation rules
   - Data types and formats
   - Required/optional fields

4. **API Usage Examples**
   - cURL examples
   - SDK code samples
   - Common workflows
   - Error handling examples

5. **API Documentation**
   - Endpoint descriptions
   - Parameter definitions
   - Response codes
   - Use cases

---

## Configuration

**Model:** Claude Sonnet 4.5

**Temperature:** 0.2 (for consistency)

**Max Tokens:** 4000+

---

## Triggers

Use this agent when:
- ✅ Need to design new API
- ✅ Creating API documentation
- ✅ Designing integration points
- ✅ Updating existing API
- ✅ Creating OpenAPI/Swagger specs
- ✅ Frontend-backend contract needed
- ✅ Third-party integration design

---

## Success Criteria

### Quality Metrics
- [ ] All endpoints documented
- [ ] OpenAPI spec validates
- [ ] Request/response schemas complete
- [ ] Examples provided for all endpoints
- [ ] Error responses defined
- [ ] Authentication documented

### Time Metrics
- [ ] Design time: <3 hours
- [ ] Review cycles: <2
- [ ] vs Manual: 24 hours (87.5% savings)

### Business Metrics
- [ ] Frontend-backend alignment: 100%
- [ ] API usability score: >85%
- [ ] Reduced integration issues: >70%

---

## Integration Points

**Inputs From:**
- Agent #6: Technical Requirements
- Agent #5: Architecture Documentation
- Agent #11: Sprint Planning
- Database team (data models)

**Outputs To:**
- Agent #13: Implementation Agent
- Frontend team (API contracts)
- Documentation sites
- API testing tools (Postman, Insomnia)

---

## Templates

See `prompts/` directory for:
- `01-api-design.md` - Complete API design template
- `02-openapi-spec.md` - OpenAPI 3.0 generation template
- `03-rest-api-design.md` - REST API best practices template
- `04-graphql-design.md` - GraphQL API design template

---

## Output Examples

### OpenAPI 3.0 Specification
Ready to:
- Import into Swagger UI
- Generate API documentation
- Create mock servers
- Generate client SDKs

### Formats Supported
- REST (JSON)
- GraphQL
- gRPC (with protobuf definitions)
- WebSocket APIs

---

## Metrics to Track

| Metric | Target | Actual |
|--------|--------|--------|
| Design Time | <3h | ___ |
| Spec Completeness | 100% | ___ |
| Frontend Integration Issues | <5% | ___ |
| API Usability Score | >85% | ___ |

---

## Version History

- **v1.0** (2024-11-18): Initial agent specification
