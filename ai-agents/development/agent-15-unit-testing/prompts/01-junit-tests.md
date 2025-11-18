# Prompt Template: JUnit 5 Unit Test Generation

## Master Prompt for Cursor AI

```
You are an expert QA engineer specializing in test automation with JUnit 5.
Generate comprehensive unit tests with high coverage for the provided code.

# Project Context

@[SourceFile.java] - Source code to test
@[Repository.java] - Dependencies to mock

# Tech Stack

- JUnit 5 (Jupiter)
- Mockito
- AssertJ
- Spring Boot Test (if Spring project)
- Java 17

# Test Standards

- Use JUnit 5 annotations (@Test, @BeforeEach, etc.)
- Follow AAA pattern (Arrange, Act, Assert)
- Use descriptive test method names
- Mock all external dependencies
- Use AssertJ for fluent assertions
- Achieve >80% code coverage
- Test all public methods
- Include edge cases and error scenarios

# Task

Generate comprehensive unit tests for [CLASS_NAME] that includes:

## 1. Test Class Setup

```java
@ExtendWith(MockitoExtension.class)
class [ClassName]Test {

    @Mock
    private [Dependency1] dependency1;

    @Mock
    private [Dependency2] dependency2;

    @InjectMocks
    private [ClassUnderTest] classUnderTest;

    @BeforeEach
    void setUp() {
        // Common test setup
    }

    @AfterEach
    void tearDown() {
        // Cleanup if needed
    }
}
```

## 2. Test Methods

For EACH public method in the source class, generate:

### Happy Path Tests

```java
@Test
@DisplayName("Should [expected behavior] when [condition]")
void should[ExpectedBehavior]_When[Condition]() {
    // Arrange
    [SetupTestData]
    when([mockMethod]()).thenReturn([expectedValue]);

    // Act
    [ResultType] result = classUnderTest.[methodUnderTest]([params]);

    // Assert
    assertThat(result)
        .[assertion]([expectedValue]);
    verify([mock]).[verifyCall]();
}
```

### Error Path Tests

```java
@Test
@DisplayName("Should throw [exception] when [error condition]")
void shouldThrow[Exception]_When[ErrorCondition]() {
    // Arrange
    when([mockMethod]()).thenThrow(new [Exception]());

    // Act & Assert
    assertThatThrownBy(() -> classUnderTest.[methodUnderTest]([params]))
        .isInstanceOf([Exception].class)
        .hasMessage("[expected message]");
}
```

### Edge Case Tests

```java
@Test
@DisplayName("Should handle [edge case]")
void shouldHandle[EdgeCase]() {
    // Test with:
    // - Null values
    // - Empty collections
    // - Boundary values (min/max)
    // - Large datasets
    // - Special characters
}
```

### Parameterized Tests

```java
@ParameterizedTest
@CsvSource({
    "input1, expected1",
    "input2, expected2",
    "input3, expected3"
})
@DisplayName("Should return [expected] for [input]")
void shouldReturn[Expected]_For[Input](String input, String expected) {
    // Arrange & Act
    String result = classUnderTest.method(input);

    // Assert
    assertThat(result).isEqualTo(expected);
}
```

## 3. Test Coverage Requirements

Ensure tests cover:
- [ ] All public methods (100%)
- [ ] All branches (>80%)
- [ ] All error paths
- [ ] Boundary conditions
- [ ] Null/empty inputs
- [ ] Success scenarios
- [ ] Exception scenarios

## 4. Mock Configuration

For each dependency:
```java
@BeforeEach
void setUp() {
    // Configure default mock behavior
    when([mock].[method]()).thenReturn([defaultValue]);

    // Can be overridden in specific tests
}
```

## 5. Test Data Builders

Create test data builders for complex objects:
```java
private [EntityType] create[EntityType]() {
    return [EntityType].builder()
        .field1([testValue1])
        .field2([testValue2])
        .build();
}
```

# Code Generation Requirements

1. **Complete Coverage:** Test all public methods
2. **Independent Tests:** No test interdependencies
3. **Fast Tests:** Each test <100ms
4. **Clear Naming:** Descriptive test and method names
5. **Proper Mocking:** Mock all external dependencies
6. **Assertions:** Use AssertJ for readable assertions
7. **Edge Cases:** Include boundary and error tests
8. **Documentation:** Use @DisplayName for clarity

# Output Format

Generate complete test class ready to run with:
- All imports
- Class annotations
- Mock setup
- Test methods
- Test data builders
- Proper formatting
```

---

## Quick Start Template for Cursor

```
Generate comprehensive JUnit 5 tests for:

@[SourceFile.java]

**Dependencies to mock:**
@[Dependency1.java]
@[Dependency2.java]

**Framework:** JUnit 5, Mockito, AssertJ

Generate tests that:
1. Cover all public methods
2. Include happy path, error path, and edge cases
3. Use AAA pattern
4. Achieve >80% coverage
5. Use proper mocking
6. Have descriptive names

Follow JUnit 5 best practices.
```

---

## Example Usage in Cursor

### Step 1: Open Cursor Composer

Press `Cmd/Ctrl+I`

### Step 2: Reference Source Files

```
@ProductService.java @ProductRepository.java

Generate comprehensive JUnit 5 unit tests for ProductService.

Tech Stack: JUnit 5, Mockito, AssertJ, Spring Boot

Cover:
- getAllProducts() - happy path, empty list, pagination
- getProductById() - found, not found, invalid ID
- createProduct() - success, validation errors, duplicate
- updateProduct() - success, not found, validation errors
- deleteProduct() - success, not found

Use mocks, AAA pattern, descriptive names, >80% coverage.
```

---

## Example Output

```java
package com.example.service;

import com.example.domain.entity.Product;
import com.example.domain.exception.ResourceNotFoundException;
import com.example.domain.exception.ValidationException;
import com.example.application.dto.ProductRequestDTO;
import com.example.application.dto.ProductResponseDTO;
import com.example.application.mapper.ProductMapper;
import com.example.infrastructure.repository.ProductRepository;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Collections;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * Unit tests for ProductService
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("ProductService Tests")
class ProductServiceTest {

    @Mock
    private ProductRepository productRepository;

    @Mock
    private ProductMapper productMapper;

    @InjectMocks
    private ProductServiceImpl productService;

    private UUID productId;
    private Product product;
    private ProductRequestDTO requestDTO;
    private ProductResponseDTO responseDTO;

    @BeforeEach
    void setUp() {
        productId = UUID.randomUUID();

        product = Product.builder()
            .id(productId)
            .name("Test Product")
            .description("Test Description")
            .price(new BigDecimal("99.99"))
            .inventory(100)
            .build();

        requestDTO = ProductRequestDTO.builder()
            .name("Test Product")
            .description("Test Description")
            .price(new BigDecimal("99.99"))
            .inventory(100)
            .build();

        responseDTO = ProductResponseDTO.builder()
            .id(productId)
            .name("Test Product")
            .description("Test Description")
            .price(new BigDecimal("99.99"))
            .inventory(100)
            .build();
    }

    @Test
    @DisplayName("Should return paginated products when products exist")
    void shouldReturnPaginatedProducts_WhenProductsExist() {
        // Arrange
        Pageable pageable = PageRequest.of(0, 10);
        Page<Product> productPage = new PageImpl<>(Arrays.asList(product));

        when(productRepository.findAll(pageable)).thenReturn(productPage);
        when(productMapper.toResponseDTO(any(Product.class))).thenReturn(responseDTO);

        // Act
        Page<ProductResponseDTO> result = productService.getAllProducts(pageable);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getContent()).hasSize(1);
        assertThat(result.getContent().get(0).getName()).isEqualTo("Test Product");

        verify(productRepository).findAll(pageable);
        verify(productMapper).toResponseDTO(product);
    }

    @Test
    @DisplayName("Should return empty page when no products exist")
    void shouldReturnEmptyPage_WhenNoProductsExist() {
        // Arrange
        Pageable pageable = PageRequest.of(0, 10);
        Page<Product> emptyPage = new PageImpl<>(Collections.emptyList());

        when(productRepository.findAll(pageable)).thenReturn(emptyPage);

        // Act
        Page<ProductResponseDTO> result = productService.getAllProducts(pageable);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getContent()).isEmpty();
        assertThat(result.getTotalElements()).isZero();

        verify(productRepository).findAll(pageable);
        verify(productMapper, never()).toResponseDTO(any());
    }

    @Test
    @DisplayName("Should return product when valid ID provided")
    void shouldReturnProduct_WhenValidIdProvided() {
        // Arrange
        when(productRepository.findById(productId)).thenReturn(Optional.of(product));
        when(productMapper.toResponseDTO(product)).thenReturn(responseDTO);

        // Act
        ProductResponseDTO result = productService.getProductById(productId);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getId()).isEqualTo(productId);
        assertThat(result.getName()).isEqualTo("Test Product");

        verify(productRepository).findById(productId);
        verify(productMapper).toResponseDTO(product);
    }

    @Test
    @DisplayName("Should throw ResourceNotFoundException when product not found")
    void shouldThrowResourceNotFoundException_WhenProductNotFound() {
        // Arrange
        UUID nonExistentId = UUID.randomUUID();
        when(productRepository.findById(nonExistentId)).thenReturn(Optional.empty());

        // Act & Assert
        assertThatThrownBy(() -> productService.getProductById(nonExistentId))
            .isInstanceOf(ResourceNotFoundException.class)
            .hasMessage("Product not found with id: " + nonExistentId);

        verify(productRepository).findById(nonExistentId);
        verify(productMapper, never()).toResponseDTO(any());
    }

    @Test
    @DisplayName("Should throw IllegalArgumentException when ID is null")
    void shouldThrowIllegalArgumentException_WhenIdIsNull() {
        // Act & Assert
        assertThatThrownBy(() -> productService.getProductById(null))
            .isInstanceOf(IllegalArgumentException.class)
            .hasMessage("Product ID cannot be null");

        verify(productRepository, never()).findById(any());
    }

    @Test
    @DisplayName("Should create product when valid request provided")
    void shouldCreateProduct_WhenValidRequestProvided() {
        // Arrange
        when(productMapper.toEntity(requestDTO)).thenReturn(product);
        when(productRepository.save(product)).thenReturn(product);
        when(productMapper.toResponseDTO(product)).thenReturn(responseDTO);

        // Act
        ProductResponseDTO result = productService.createProduct(requestDTO);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getName()).isEqualTo("Test Product");

        verify(productMapper).toEntity(requestDTO);
        verify(productRepository).save(product);
        verify(productMapper).toResponseDTO(product);
    }

    @Test
    @DisplayName("Should throw ValidationException when price is negative")
    void shouldThrowValidationException_WhenPriceIsNegative() {
        // Arrange
        requestDTO.setPrice(new BigDecimal("-10.00"));

        // Act & Assert
        assertThatThrownBy(() -> productService.createProduct(requestDTO))
            .isInstanceOf(ValidationException.class)
            .hasMessage("Price cannot be negative");

        verify(productRepository, never()).save(any());
    }

    @ParameterizedTest
    @CsvSource({
        "0, 'Inventory cannot be negative'",
        "-1, 'Inventory cannot be negative'",
        "-100, 'Inventory cannot be negative'"
    })
    @DisplayName("Should throw ValidationException for invalid inventory")
    void shouldThrowValidationException_ForInvalidInventory(
            int inventory, String expectedMessage) {
        // Arrange
        requestDTO.setInventory(inventory);

        // Act & Assert
        assertThatThrownBy(() -> productService.createProduct(requestDTO))
            .isInstanceOf(ValidationException.class)
            .hasMessage(expectedMessage);
    }

    @Test
    @DisplayName("Should update product when valid ID and request provided")
    void shouldUpdateProduct_WhenValidIdAndRequestProvided() {
        // Arrange
        when(productRepository.findById(productId)).thenReturn(Optional.of(product));
        when(productRepository.save(any(Product.class))).thenReturn(product);
        when(productMapper.toResponseDTO(any(Product.class))).thenReturn(responseDTO);

        // Act
        ProductResponseDTO result = productService.updateProduct(productId, requestDTO);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getId()).isEqualTo(productId);

        verify(productRepository).findById(productId);
        verify(productRepository).save(any(Product.class));
    }

    @Test
    @DisplayName("Should delete product when valid ID provided")
    void shouldDeleteProduct_WhenValidIdProvided() {
        // Arrange
        when(productRepository.existsById(productId)).thenReturn(true);
        doNothing().when(productRepository).deleteById(productId);

        // Act
        productService.deleteProduct(productId);

        // Assert
        verify(productRepository).existsById(productId);
        verify(productRepository).deleteById(productId);
    }

    @Test
    @DisplayName("Should throw ResourceNotFoundException when deleting non-existent product")
    void shouldThrowResourceNotFoundException_WhenDeletingNonExistentProduct() {
        // Arrange
        UUID nonExistentId = UUID.randomUUID();
        when(productRepository.existsById(nonExistentId)).thenReturn(false);

        // Act & Assert
        assertThatThrownBy(() -> productService.deleteProduct(nonExistentId))
            .isInstanceOf(ResourceNotFoundException.class)
            .hasMessage("Product not found with id: " + nonExistentId);

        verify(productRepository).existsById(nonExistentId);
        verify(productRepository, never()).deleteById(any());
    }
}
```

---

## Tips for Best Results

1. **Reference Source Files:** Use @mentions for context
2. **Specify Coverage Goals:** Ask for >80% coverage
3. **Request Edge Cases:** Explicitly ask for boundary tests
4. **Mock Dependencies:** List all dependencies to mock
5. **Use Builders:** Request test data builders for complex objects
6. **Review Generated Tests:** Always review and run tests

---

## Version

- **Template Version:** 1.0
- **Last Updated:** 2024-11-18
- **Compatible With:** Cursor AI + Claude Sonnet 4.5
