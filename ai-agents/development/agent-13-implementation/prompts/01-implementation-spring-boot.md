# Prompt Template: Spring Boot Backend Implementation

## Master Prompt for Cursor AI

```
You are an expert Spring Boot backend developer with 10+ years of experience.
Implement production-ready Spring Boot code based on the provided API specification.

# Project Context

@[api-design.md] - API design document
@[schema.sql] - Database schema

# Tech Stack

- Java 17
- Spring Boot 3.x
- Spring Data JPA
- Spring Security
- PostgreSQL
- Lombok
- MapStruct (for DTOs)
- Validation API

# Code Standards

- Follow Spring Boot best practices
- Use constructor injection
- Implement proper exception handling
- Use DTOs for API layer (never expose entities)
- Add validation annotations
- Include JavaDoc for public methods
- Use Lombok to reduce boilerplate
- Follow REST naming conventions
- Implement pagination for list endpoints

# Task

Implement the following components for [FEATURE_NAME - e.g., "Product Management"]:

## 1. Entity Class

Create JPA entity in: `src/main/java/com/example/domain/entity/`

Requirements:
- JPA annotations (@Entity, @Table, @Column)
- Relationships (@OneToMany, @ManyToOne, etc.)
- Indexes (@Index)
- Constraints (@Column nullable, unique)
- Audit fields (createdAt, updatedAt with @CreatedDate, @LastModifiedDate)
- Lombok annotations (@Data, @Builder, @NoArgsConstructor, @AllArgsConstructor)

## 2. Repository Interface

Create repository in: `src/main/java/com/example/infrastructure/repository/`

Requirements:
- Extend JpaRepository<Entity, ID>
- Custom query methods with @Query if needed
- Specification for complex queries
- Pagination support

## 3. DTO Classes

Create DTOs in: `src/main/java/com/example/application/dto/`

Requirements:
- Request DTOs (for POST, PUT, PATCH)
- Response DTOs (for GET)
- Validation annotations (@NotNull, @NotBlank, @Size, @Min, @Max, @Email, etc.)
- Lombok annotations
- Clear field naming
- JavaDoc

## 4. Mapper

Create mapper in: `src/main/java/com/example/application/mapper/`

Requirements:
- Use MapStruct (@Mapper)
- Entity to DTO mapping
- DTO to Entity mapping
- Handle nested objects
- Null handling

## 5. Service Interface and Implementation

Create service in: `src/main/java/com/example/application/service/`

Requirements:
- Service interface defining business operations
- Service implementation with @Service
- Business logic
- Transaction management (@Transactional)
- Exception handling
- Proper logging
- Input validation

## 6. Controller

Create controller in: `src/main/java/com/example/presentation/controller/`

Requirements:
- @RestController and @RequestMapping
- Endpoint methods with proper annotations
- @Valid for request body validation
- ResponseEntity with proper status codes
- Exception handling
- Pagination (Pageable)
- API versioning in path
- Swagger/OpenAPI annotations

## 7. Exception Classes

Create exceptions in: `src/main/java/com/example/domain/exception/`

Requirements:
- Custom exception classes
- Business exceptions (ResourceNotFoundException, etc.)
- Validation exceptions
- Proper exception hierarchy

## 8. Global Exception Handler

Create in: `src/main/java/com/example/presentation/exception/`

Requirements:
- @RestControllerAdvice
- Handle all exception types
- Consistent error response format
- Proper HTTP status codes
- Logging

# Code Generation Requirements

1. **Complete Implementation:** All methods fully implemented, no TODOs
2. **Production Ready:** Handle edge cases, nulls, errors
3. **Well Documented:** JavaDoc for classes and public methods
4. **Validated:** Input validation on all API endpoints
5. **Tested:** Code should be testable (dependency injection)
6. **Performant:** Use appropriate JPA fetch strategies
7. **Secure:** Prevent SQL injection, validate inputs

# Example Package Structure

```
com.example
├── domain
│   ├── entity
│   │   └── Product.java
│   └── exception
│       ├── ResourceNotFoundException.java
│       └── ValidationException.java
├── infrastructure
│   └── repository
│       └── ProductRepository.java
├── application
│   ├── dto
│   │   ├── ProductRequestDTO.java
│   │   └── ProductResponseDTO.java
│   ├── mapper
│   │   └── ProductMapper.java
│   └── service
│       ├── ProductService.java
│       └── ProductServiceImpl.java
└── presentation
    ├── controller
    │   └── ProductController.java
    └── exception
        ├── GlobalExceptionHandler.java
        └── ErrorResponse.java
```

# Output Format

Generate complete, compilable Java code for all components.
Include proper imports, annotations, and formatting.

# Quality Checklist

Before finishing, ensure:
- [ ] All classes have proper package declarations
- [ ] All imports are correct
- [ ] All annotations are in place
- [ ] Code follows naming conventions
- [ ] Exception handling is comprehensive
- [ ] Validation is on all inputs
- [ ] DTOs are used (not entities in API)
- [ ] Service layer has business logic
- [ ] Repository has only data access
- [ ] Controller is thin (delegates to service)
```

---

## Quick Start Template for Cursor

```
Implement Spring Boot backend code for:

**Feature:** [FEATURE_NAME]

**Files to reference:**
@api-design.md
@database-schema.sql

**Framework:** Spring Boot 3.x, Java 17

Generate all layers:
1. Entity with JPA annotations
2. Repository interface
3. Request/Response DTOs with validation
4. Mapper with MapStruct
5. Service interface and implementation
6. REST Controller
7. Exception classes
8. Global exception handler

Follow Spring Boot best practices, use DTOs, add validation, handle errors properly.
```

---

## Example Usage in Cursor

### Step 1: Prepare Files

Create API design file: `docs/api-design.md`
Create schema file: `docs/schema.sql`

### Step 2: Open Cursor Composer

Press `Cmd/Ctrl+I` to open Composer

### Step 3: Provide Context

Type:
```
@api-design.md @schema.sql

Implement Spring Boot backend for Product Management API.

Tech Stack:
- Spring Boot 3.2
- Java 17
- PostgreSQL
- Lombok
- MapStruct

Generate:
1. Product entity
2. ProductRepository
3. ProductRequestDTO, ProductResponseDTO
4. ProductMapper
5. ProductService + ProductServiceImpl
6. ProductController
7. Exception classes

Use best practices, DTOs, validation, error handling.
```

### Step 4: Review and Accept

Cursor will generate all files. Review each file and accept or modify.

---

## Example Output

### Product.java (Entity)

```java
package com.example.domain.entity;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Product entity representing a product in the catalog
 */
@Entity
@Table(name = "products", indexes = {
    @Index(name = "idx_product_name", columnList = "name"),
    @Index(name = "idx_product_category", columnList = "category_id")
})
@EntityListeners(AuditingEntityListener.class)
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(nullable = false, length = 200)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal price;

    @Column(nullable = false)
    private Integer inventory;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    @CreatedDate
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(nullable = false)
    private LocalDateTime updatedAt;
}
```

### ProductController.java

```java
package com.example.presentation.controller;

import com.example.application.dto.ProductRequestDTO;
import com.example.application.dto.ProductResponseDTO;
import com.example.application.service.ProductService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

/**
 * REST Controller for Product operations
 */
@RestController
@RequestMapping("/api/v1/products")
@RequiredArgsConstructor
@Tag(name = "Products", description = "Product management APIs")
public class ProductController {

    private final ProductService productService;

    /**
     * Get all products with pagination
     */
    @GetMapping
    @Operation(summary = "Get all products")
    public ResponseEntity<Page<ProductResponseDTO>> getAllProducts(Pageable pageable) {
        Page<ProductResponseDTO> products = productService.getAllProducts(pageable);
        return ResponseEntity.ok(products);
    }

    /**
     * Get product by ID
     */
    @GetMapping("/{id}")
    @Operation(summary = "Get product by ID")
    public ResponseEntity<ProductResponseDTO> getProductById(@PathVariable UUID id) {
        ProductResponseDTO product = productService.getProductById(id);
        return ResponseEntity.ok(product);
    }

    /**
     * Create new product
     */
    @PostMapping
    @Operation(summary = "Create new product")
    public ResponseEntity<ProductResponseDTO> createProduct(
            @Valid @RequestBody ProductRequestDTO requestDTO) {
        ProductResponseDTO product = productService.createProduct(requestDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(product);
    }

    /**
     * Update existing product
     */
    @PutMapping("/{id}")
    @Operation(summary = "Update product")
    public ResponseEntity<ProductResponseDTO> updateProduct(
            @PathVariable UUID id,
            @Valid @RequestBody ProductRequestDTO requestDTO) {
        ProductResponseDTO product = productService.updateProduct(id, requestDTO);
        return ResponseEntity.ok(product);
    }

    /**
     * Delete product
     */
    @DeleteMapping("/{id}")
    @Operation(summary = "Delete product")
    public ResponseEntity<Void> deleteProduct(@PathVariable UUID id) {
        productService.deleteProduct(id);
        return ResponseEntity.noContent().build();
    }
}
```

---

## Tips for Best Results with Cursor

1. **Use @mentions:** Reference API design and schema files
2. **Be Specific:** Mention exact framework versions
3. **Request All Layers:** Don't generate one layer at a time
4. **Set Standards:** Create .cursorrules for consistent code
5. **Review Carefully:** AI-generated code needs human review
6. **Iterate:** Refine with follow-up prompts
7. **Test:** Always test generated code

---

## Common Follow-up Prompts

```
"Add search functionality to ProductService and Controller"

"Implement soft delete for Product entity"

"Add caching with Redis to ProductService"

"Create integration tests for ProductController"

"Add filtering by category in getAllProducts"

"Implement bulk operations for products"
```

---

## Version

- **Template Version:** 1.0
- **Last Updated:** 2024-11-18
- **Compatible With:** Cursor AI + Claude Sonnet 4.5
