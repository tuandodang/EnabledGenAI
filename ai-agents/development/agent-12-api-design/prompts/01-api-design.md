# Prompt Template: REST API Design & OpenAPI Specification

## Master Prompt

```
You are an expert API architect with 15+ years of experience designing RESTful APIs
following industry best practices. Create a comprehensive API design with OpenAPI 3.0
specification.

# Context

Project: [PROJECT_NAME]
API Type: REST | GraphQL | gRPC
API Version: v1
Framework: [e.g., Spring Boot, Express.js, FastAPI, Django]

# Requirements

[PASTE TECHNICAL REQUIREMENTS OR USER STORIES]

# Data Models

[PASTE DATABASE SCHEMA OR DATA MODELS IF AVAILABLE]

# Authentication

Method: [JWT | OAuth 2.0 | API Key | Session]
User Roles: [List of roles: Admin, User, Guest, etc.]

# Constraints

- [Constraint 1 - e.g., "Must support 1000 requests/second"]
- [Constraint 2 - e.g., "Response time <200ms"]
- [...]

# Task

Create a comprehensive API design that includes:

## 1. API Design Document

### Overview
- API purpose and scope
- Target audience (mobile app, web app, third-party)
- API style and principles

### Design Principles
- RESTful constraints followed
- Resource naming conventions
- HTTP methods usage
- Status code conventions

### Authentication & Authorization
- Authentication method details
- Authorization model (RBAC, ABAC)
- Token format and lifecycle
- Security best practices

### Versioning Strategy
- Versioning approach (URL, header, media type)
- Deprecation policy
- Breaking vs non-breaking changes

### Error Handling
- Error response format
- Error codes and meanings
- Validation errors
- Common error scenarios

### Pagination
- Pagination strategy (offset, cursor, page-based)
- Default and max page sizes
- Response format with pagination metadata

### Rate Limiting
- Rate limit policies
- Rate limit headers
- Throttling behavior

### CORS Policy
- Allowed origins
- Allowed methods
- Allowed headers

---

## 2. API Endpoints Specification

For EACH endpoint:

### [METHOD] /api/v1/[resource]

**Description:** Clear description of what this endpoint does

**Authentication:** Required | Optional | None

**Authorization:** [Roles that can access]

**Request:**

**Path Parameters:**
- `param1` (type): Description

**Query Parameters:**
- `param1` (type, optional/required): Description, default value
- `param2` (type, optional/required): Description

**Request Headers:**
```
Content-Type: application/json
Authorization: Bearer {token}
```

**Request Body:**
```json
{
  "field1": "string (required) - Description",
  "field2": 123,
  "field3": {
    "nested": "object"
  }
}
```

**Request Example:**
```bash
curl -X POST https://api.example.com/api/v1/resource \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer eyJ..." \
  -d '{
    "field1": "example value",
    "field2": 123
  }'
```

**Response:**

**Success Response (200 OK):**
```json
{
  "id": "uuid",
  "field1": "string",
  "field2": 123,
  "createdAt": "2024-11-18T10:00:00Z",
  "updatedAt": "2024-11-18T10:00:00Z"
}
```

**Error Responses:**

**400 Bad Request:**
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid request data",
    "details": [
      {
        "field": "field1",
        "message": "Field is required"
      }
    ]
  }
}
```

**401 Unauthorized:**
```json
{
  "error": {
    "code": "UNAUTHORIZED",
    "message": "Authentication required"
  }
}
```

**403 Forbidden:**
```json
{
  "error": {
    "code": "FORBIDDEN",
    "message": "Insufficient permissions"
  }
}
```

**404 Not Found:**
```json
{
  "error": {
    "code": "NOT_FOUND",
    "message": "Resource not found"
  }
}
```

**429 Too Many Requests:**
```json
{
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Rate limit exceeded. Try again in 60 seconds."
  }
}
```

**500 Internal Server Error:**
```json
{
  "error": {
    "code": "INTERNAL_ERROR",
    "message": "An unexpected error occurred"
  }
}
```

**Validation Rules:**
- field1: Required, min length 3, max length 100
- field2: Required, must be > 0

**Business Rules:**
- [Business rule 1]
- [Business rule 2]

**Performance:**
- Expected response time: <200ms (p95)
- Rate limit: 100 requests/minute per user

---

## 3. Complete OpenAPI 3.0 Specification

Provide full OpenAPI 3.0 spec in YAML format that includes:

```yaml
openapi: 3.0.3
info:
  title: [API_NAME]
  description: [API_DESCRIPTION]
  version: 1.0.0
  contact:
    name: API Support
    email: api@example.com

servers:
  - url: https://api.example.com/v1
    description: Production
  - url: https://staging-api.example.com/v1
    description: Staging

security:
  - bearerAuth: []

paths:
  /resource:
    get:
      summary: [Summary]
      description: [Detailed description]
      operationId: getResource
      tags:
        - Resource
      parameters:
        - name: page
          in: query
          schema:
            type: integer
            default: 1
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ResourceList'
      security:
        - bearerAuth: []

components:
  schemas:
    Resource:
      type: object
      required:
        - id
        - name
      properties:
        id:
          type: string
          format: uuid
          example: "123e4567-e89b-12d3-a456-426614174000"
        name:
          type: string
          minLength: 3
          maxLength: 100
          example: "Example Resource"

  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT

  responses:
    UnauthorizedError:
      description: Authentication required
    ForbiddenError:
      description: Insufficient permissions
    NotFoundError:
      description: Resource not found
```

---

## 4. API Usage Examples

### Common Workflows

**Workflow 1: [Workflow Name - e.g., "Create and Retrieve Resource"]**

Step 1: Authenticate
```bash
curl -X POST https://api.example.com/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com", "password": "password123"}'

Response:
{
  "token": "eyJhbGci...",
  "expiresIn": 3600
}
```

Step 2: Create Resource
```bash
curl -X POST https://api.example.com/v1/resource \
  -H "Authorization: Bearer eyJhbGci..." \
  -H "Content-Type: application/json" \
  -d '{"name": "New Resource"}'

Response:
{
  "id": "abc123",
  "name": "New Resource",
  "createdAt": "2024-11-18T10:00:00Z"
}
```

Step 3: Retrieve Resource
```bash
curl -X GET https://api.example.com/v1/resource/abc123 \
  -H "Authorization: Bearer eyJhbGci..."

Response:
{
  "id": "abc123",
  "name": "New Resource",
  "createdAt": "2024-11-18T10:00:00Z"
}
```

---

## 5. Data Models & Schemas

### JSON Schema Validation

[Provide detailed JSON schemas for request/response validation]

---

## 6. Testing Recommendations

### Postman Collection

[Suggest Postman collection structure]

### Test Scenarios

1. Happy path testing
2. Validation testing
3. Authentication/authorization testing
4. Error handling testing
5. Performance testing

# Output Format

Provide:
1. Complete API design document in markdown
2. Full OpenAPI 3.0 specification in YAML
3. Example requests/responses in bash/curl
4. JSON schemas for validation

Ensure all outputs are:
- Production-ready
- Following REST best practices
- Consistent across all endpoints
- Properly documented
- Include realistic examples

# Quality Standards

- Use proper HTTP methods (GET, POST, PUT, PATCH, DELETE)
- Use proper status codes (200, 201, 400, 401, 403, 404, 500)
- RESTful resource naming (plural nouns, lowercase, hyphens)
- Consistent error format across all endpoints
- Proper pagination for list endpoints
- Include rate limiting considerations
- Security best practices (authentication, authorization)
- Validation on all inputs
- Idempotency where appropriate
```

---

## Quick Start Template

```
Design a REST API for:

**Project:** [NAME]
**Framework:** [FRAMEWORK]

**Requirements:**
[PASTE REQUIREMENTS OR USER STORIES]

**Data Models:**
[PASTE DATA MODELS]

**Authentication:** [METHOD]

Please provide:
1. API design document
2. Complete OpenAPI 3.0 specification
3. Endpoint documentation with examples
4. Request/response schemas
5. Error handling specification

Format: Markdown document + YAML OpenAPI spec
```

---

## Example for E-Commerce

```
Design a REST API for an e-commerce platform's product catalog.

**Requirements:**
- Browse products by category
- Search products
- View product details
- Admin can create/update/delete products

**Data Model:**
- Product: id, name, description, price, category, inventory, images

**Authentication:** JWT

Provide complete API design with OpenAPI spec.
```

---

## Tips for Best Results

1. **Provide Data Models:** Better data models = better API design
2. **Specify Framework:** API design varies by framework
3. **Include Use Cases:** Real-world scenarios improve design
4. **Request Examples:** Ask for cURL, SDK examples
5. **Iterate:** Refine based on frontend feedback

---

## Version

- **Template Version:** 1.0
- **Last Updated:** 2024-11-18
- **Compatible With:** Claude Sonnet 4.5
