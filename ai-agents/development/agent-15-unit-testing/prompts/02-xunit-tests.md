# xUnit Test Generation Prompt Template

**Agent:** #15 - Unit Testing Agent
**Tool:** Cursor AI
**Framework:** xUnit, Moq, FluentAssertions
**Coverage Target:** >85%

---

## Prompt Template

```
You are an expert C# test automation engineer specializing in xUnit, Moq, and FluentAssertions.

I need you to generate comprehensive unit tests for my ASP.NET Core code.

## Context

**Project:** [Your Project Name]
**Testing Framework:** xUnit 2.6+
**Mocking Framework:** Moq 4.20+
**Assertion Library:** FluentAssertions 6.12+
**Code Coverage Tool:** coverlet / dotCover

## Code to Test

[Paste the source code - Service, Repository, or Controller]

## Test Requirements

### Coverage Goals

- **Line Coverage:** >85%
- **Branch Coverage:** >80%
- **Method Coverage:** 100% of public methods

### Test Patterns

Use **AAA Pattern** (Arrange, Act, Assert):
```csharp
[Fact]
public async Task MethodName_Scenario_ExpectedResult()
{
    // Arrange
    // ... setup

    // Act
    var result = await sut.MethodAsync();

    // Assert
    result.Should().NotBeNull();
}
```

### Test Categories

Generate tests for:

1. **Happy Path** - Normal flow, valid inputs
2. **Edge Cases** - Boundary values, limits
3. **Error Cases** - Invalid inputs, exceptions
4. **Null Cases** - Null parameters, empty collections
5. **Concurrent Cases** - Thread safety (if applicable)

## Implementation Requirements

### 1. Test Class Structure

**File naming:** `[ClassName]Tests.cs`

**Location:** `Tests/Unit/[Layer]/`

**Example:**
```csharp
public class ProductServiceTests
{
    private readonly Mock<IProductRepository> _mockProductRepository;
    private readonly Mock<IMapper> _mockMapper;
    private readonly Mock<ILogger<ProductService>> _mockLogger;
    private readonly Mock<IValidator<CreateProductRequestDto>> _mockCreateValidator;
    private readonly Mock<IValidator<UpdateProductRequestDto>> _mockUpdateValidator;
    private readonly ProductService _sut; // System Under Test

    public ProductServiceTests()
    {
        _mockProductRepository = new Mock<IProductRepository>();
        _mockMapper = new Mock<IMapper>();
        _mockLogger = new Mock<ILogger<ProductService>>();
        _mockCreateValidator = new Mock<IValidator<CreateProductRequestDto>>();
        _mockUpdateValidator = new Mock<IValidator<UpdateProductRequestDto>>();

        _sut = new ProductService(
            _mockProductRepository.Object,
            _mockMapper.Object,
            _mockLogger.Object,
            _mockCreateValidator.Object,
            _mockUpdateValidator.Object
        );
    }
}
```

### 2. Test Method Naming Convention

Use this format: `MethodName_Scenario_ExpectedResult`

**Examples:**
- `GetByIdAsync_ValidId_ReturnsProduct`
- `GetByIdAsync_InvalidId_ReturnsNotFound`
- `CreateAsync_ValidRequest_CreatesProduct`
- `CreateAsync_NullRequest_ThrowsArgumentNullException`
- `UpdateAsync_ProductNotFound_ReturnsFailure`

### 3. Repository Tests

**File:** `ProductRepositoryTests.cs`

```csharp
public class ProductRepositoryTests : IDisposable
{
    private readonly ApplicationDbContext _context;
    private readonly ProductRepository _sut;
    private readonly ILogger<ProductRepository> _logger;

    public ProductRepositoryTests()
    {
        // Use In-Memory database for testing
        var options = new DbContextOptionsBuilder<ApplicationDbContext>()
            .UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
            .Options;

        _context = new ApplicationDbContext(options);
        _logger = new Mock<ILogger<ProductRepository>>().Object;
        _sut = new ProductRepository(_context, _logger);

        // Seed test data
        SeedTestData();
    }

    private void SeedTestData()
    {
        var category = new Category
        {
            Id = Guid.NewGuid(),
            Name = "Electronics"
        };

        var products = new List<Product>
        {
            new Product
            {
                Id = Guid.Parse("11111111-1111-1111-1111-111111111111"),
                Name = "Laptop",
                Description = "Gaming laptop",
                Price = 1200.00m,
                Stock = 50,
                CategoryId = category.Id,
                Category = category,
                CreatedAt = DateTime.UtcNow,
                IsDeleted = false
            },
            new Product
            {
                Id = Guid.Parse("22222222-2222-2222-2222-222222222222"),
                Name = "Mouse",
                Description = "Wireless mouse",
                Price = 25.50m,
                Stock = 0,
                CategoryId = category.Id,
                Category = category,
                CreatedAt = DateTime.UtcNow,
                IsDeleted = false
            }
        };

        _context.Categories.Add(category);
        _context.Products.AddRange(products);
        _context.SaveChanges();
    }

    [Fact]
    public async Task GetByIdAsync_ValidId_ReturnsProduct()
    {
        // Arrange
        var productId = Guid.Parse("11111111-1111-1111-1111-111111111111");

        // Act
        var result = await _sut.GetByIdAsync(productId);

        // Assert
        result.Should().NotBeNull();
        result!.Id.Should().Be(productId);
        result.Name.Should().Be("Laptop");
        result.Category.Should().NotBeNull();
    }

    [Fact]
    public async Task GetByIdAsync_InvalidId_ReturnsNull()
    {
        // Arrange
        var invalidId = Guid.NewGuid();

        // Act
        var result = await _sut.GetByIdAsync(invalidId);

        // Assert
        result.Should().BeNull();
    }

    [Fact]
    public async Task GetByIdAsync_DeletedProduct_ReturnsNull()
    {
        // Arrange
        var deletedProductId = Guid.NewGuid();
        var deletedProduct = new Product
        {
            Id = deletedProductId,
            Name = "Deleted Product",
            Price = 100m,
            Stock = 10,
            CategoryId = _context.Categories.First().Id,
            IsDeleted = true,
            DeletedAt = DateTime.UtcNow
        };
        _context.Products.Add(deletedProduct);
        await _context.SaveChangesAsync();

        // Act
        var result = await _sut.GetByIdAsync(deletedProductId);

        // Assert
        result.Should().BeNull();
    }

    [Theory]
    [InlineData("Laptop", 1)]
    [InlineData("Mouse", 1)]
    [InlineData("Keyboard", 0)]
    public async Task GetPagedAsync_SearchByName_ReturnsMatchingProducts(
        string searchTerm,
        int expectedCount)
    {
        // Arrange
        var query = new ProductQueryDto
        {
            SearchTerm = searchTerm,
            PageNumber = 1,
            PageSize = 10
        };

        // Act
        var result = await _sut.GetPagedAsync(query);

        // Assert
        result.Should().NotBeNull();
        result.Items.Should().HaveCount(expectedCount);
        result.TotalCount.Should().Be(expectedCount);
    }

    [Fact]
    public async Task GetPagedAsync_FilterByPriceRange_ReturnsProductsInRange()
    {
        // Arrange
        var query = new ProductQueryDto
        {
            MinPrice = 20m,
            MaxPrice = 30m,
            PageNumber = 1,
            PageSize = 10
        };

        // Act
        var result = await _sut.GetPagedAsync(query);

        // Assert
        result.Should().NotBeNull();
        result.Items.Should().HaveCount(1);
        result.Items.First().Name.Should().Be("Mouse");
    }

    [Fact]
    public async Task GetPagedAsync_FilterByInStock_ReturnsOnlyInStockProducts()
    {
        // Arrange
        var query = new ProductQueryDto
        {
            InStock = true,
            PageNumber = 1,
            PageSize = 10
        };

        // Act
        var result = await _sut.GetPagedAsync(query);

        // Assert
        result.Should().NotBeNull();
        result.Items.Should().HaveCount(1);
        result.Items.First().Stock.Should().BeGreaterThan(0);
    }

    [Theory]
    [InlineData("price", "asc", "Mouse")]
    [InlineData("price", "desc", "Laptop")]
    [InlineData("name", "asc", "Laptop")]
    public async Task GetPagedAsync_SortBy_ReturnsSortedProducts(
        string sortBy,
        string sortOrder,
        string expectedFirstProductName)
    {
        // Arrange
        var query = new ProductQueryDto
        {
            SortBy = sortBy,
            SortOrder = sortOrder,
            PageNumber = 1,
            PageSize = 10
        };

        // Act
        var result = await _sut.GetPagedAsync(query);

        // Assert
        result.Should().NotBeNull();
        result.Items.Should().NotBeEmpty();
        result.Items.First().Name.Should().Be(expectedFirstProductName);
    }

    [Fact]
    public async Task GetPagedAsync_Pagination_ReturnsCorrectPage()
    {
        // Arrange
        var query = new ProductQueryDto
        {
            PageNumber = 1,
            PageSize = 1
        };

        // Act
        var result = await _sut.GetPagedAsync(query);

        // Assert
        result.Should().NotBeNull();
        result.Items.Should().HaveCount(1);
        result.TotalCount.Should().Be(2);
        result.PageNumber.Should().Be(1);
        result.PageSize.Should().Be(1);
    }

    [Fact]
    public async Task CreateAsync_ValidProduct_CreatesProductSuccessfully()
    {
        // Arrange
        var newProduct = new Product
        {
            Id = Guid.NewGuid(),
            Name = "Keyboard",
            Description = "Mechanical keyboard",
            Price = 120m,
            Stock = 30,
            CategoryId = _context.Categories.First().Id
        };

        // Act
        var result = await _sut.CreateAsync(newProduct);

        // Assert
        result.Should().NotBeNull();
        result.Id.Should().Be(newProduct.Id);
        result.CreatedAt.Should().BeCloseTo(DateTime.UtcNow, TimeSpan.FromSeconds(1));

        var savedProduct = await _context.Products.FindAsync(newProduct.Id);
        savedProduct.Should().NotBeNull();
    }

    [Fact]
    public async Task UpdateAsync_ValidProduct_UpdatesProductSuccessfully()
    {
        // Arrange
        var productId = Guid.Parse("11111111-1111-1111-1111-111111111111");
        var product = await _context.Products.FindAsync(productId);
        product!.Name = "Updated Laptop";
        product.Price = 1300m;

        // Act
        var result = await _sut.UpdateAsync(product);

        // Assert
        result.Should().NotBeNull();
        result.Name.Should().Be("Updated Laptop");
        result.Price.Should().Be(1300m);
        result.UpdatedAt.Should().NotBeNull();
        result.UpdatedAt.Should().BeCloseTo(DateTime.UtcNow, TimeSpan.FromSeconds(1));
    }

    [Fact]
    public async Task DeleteAsync_ValidId_SoftDeletesProduct()
    {
        // Arrange
        var productId = Guid.Parse("11111111-1111-1111-1111-111111111111");

        // Act
        await _sut.DeleteAsync(productId);

        // Assert
        var product = await _context.Products.IgnoreQueryFilters()
            .FirstOrDefaultAsync(p => p.Id == productId);

        product.Should().NotBeNull();
        product!.IsDeleted.Should().BeTrue();
        product.DeletedAt.Should().NotBeNull();
        product.DeletedAt.Should().BeCloseTo(DateTime.UtcNow, TimeSpan.FromSeconds(1));
    }

    [Fact]
    public async Task DeleteAsync_InvalidId_DoesNothing()
    {
        // Arrange
        var invalidId = Guid.NewGuid();
        var initialCount = await _context.Products.CountAsync();

        // Act
        await _sut.DeleteAsync(invalidId);

        // Assert
        var finalCount = await _context.Products.CountAsync();
        finalCount.Should().Be(initialCount);
    }

    [Fact]
    public async Task ExistsAsync_ValidId_ReturnsTrue()
    {
        // Arrange
        var productId = Guid.Parse("11111111-1111-1111-1111-111111111111");

        // Act
        var result = await _sut.ExistsAsync(productId);

        // Assert
        result.Should().BeTrue();
    }

    [Fact]
    public async Task ExistsAsync_InvalidId_ReturnsFalse()
    {
        // Arrange
        var invalidId = Guid.NewGuid();

        // Act
        var result = await _sut.ExistsAsync(invalidId);

        // Assert
        result.Should().BeFalse();
    }

    [Fact]
    public async Task GetStockAsync_ValidId_ReturnsStock()
    {
        // Arrange
        var productId = Guid.Parse("11111111-1111-1111-1111-111111111111");

        // Act
        var result = await _sut.GetStockAsync(productId);

        // Assert
        result.Should().Be(50);
    }

    [Fact]
    public async Task GetStockAsync_InvalidId_ReturnsZero()
    {
        // Arrange
        var invalidId = Guid.NewGuid();

        // Act
        var result = await _sut.GetStockAsync(invalidId);

        // Assert
        result.Should().Be(0);
    }

    public void Dispose()
    {
        _context.Database.EnsureDeleted();
        _context.Dispose();
    }
}
```

### 4. Service Tests

**File:** `ProductServiceTests.cs`

```csharp
public class ProductServiceTests
{
    private readonly Mock<IProductRepository> _mockProductRepository;
    private readonly Mock<IMapper> _mockMapper;
    private readonly Mock<ILogger<ProductService>> _mockLogger;
    private readonly Mock<IValidator<CreateProductRequestDto>> _mockCreateValidator;
    private readonly Mock<IValidator<UpdateProductRequestDto>> _mockUpdateValidator;
    private readonly ProductService _sut;

    public ProductServiceTests()
    {
        _mockProductRepository = new Mock<IProductRepository>();
        _mockMapper = new Mock<IMapper>();
        _mockLogger = new Mock<ILogger<ProductService>>();
        _mockCreateValidator = new Mock<IValidator<CreateProductRequestDto>>();
        _mockUpdateValidator = new Mock<IValidator<UpdateProductRequestDto>>();

        _sut = new ProductService(
            _mockProductRepository.Object,
            _mockMapper.Object,
            _mockLogger.Object,
            _mockCreateValidator.Object,
            _mockUpdateValidator.Object
        );
    }

    #region GetByIdAsync Tests

    [Fact]
    public async Task GetByIdAsync_ValidId_ReturnsSuccessWithProduct()
    {
        // Arrange
        var productId = Guid.NewGuid();
        var product = new Product
        {
            Id = productId,
            Name = "Test Product",
            Price = 100m,
            Stock = 10
        };
        var productDto = new ProductResponseDto
        {
            Id = productId,
            Name = "Test Product"
        };

        _mockProductRepository.Setup(x => x.GetByIdAsync(productId, default))
            .ReturnsAsync(product);
        _mockMapper.Setup(x => x.Map<ProductResponseDto>(product))
            .Returns(productDto);

        // Act
        var result = await _sut.GetByIdAsync(productId);

        // Assert
        result.Should().NotBeNull();
        result.IsSuccess.Should().BeTrue();
        result.Data.Should().NotBeNull();
        result.Data!.Id.Should().Be(productId);

        _mockProductRepository.Verify(x => x.GetByIdAsync(productId, default), Times.Once);
        _mockMapper.Verify(x => x.Map<ProductResponseDto>(product), Times.Once);
    }

    [Fact]
    public async Task GetByIdAsync_InvalidId_ReturnsFailure()
    {
        // Arrange
        var invalidId = Guid.NewGuid();
        _mockProductRepository.Setup(x => x.GetByIdAsync(invalidId, default))
            .ReturnsAsync((Product?)null);

        // Act
        var result = await _sut.GetByIdAsync(invalidId);

        // Assert
        result.Should().NotBeNull();
        result.IsSuccess.Should().BeFalse();
        result.Error.Should().Contain("not found");

        _mockProductRepository.Verify(x => x.GetByIdAsync(invalidId, default), Times.Once);
        _mockMapper.Verify(x => x.Map<ProductResponseDto>(It.IsAny<Product>()), Times.Never);
    }

    [Fact]
    public async Task GetByIdAsync_RepositoryThrowsException_ReturnsFailure()
    {
        // Arrange
        var productId = Guid.NewGuid();
        _mockProductRepository.Setup(x => x.GetByIdAsync(productId, default))
            .ThrowsAsync(new Exception("Database error"));

        // Act
        var result = await _sut.GetByIdAsync(productId);

        // Assert
        result.Should().NotBeNull();
        result.IsSuccess.Should().BeFalse();
        result.Error.Should().Contain("error occurred");

        _mockLogger.Verify(
            x => x.Log(
                LogLevel.Error,
                It.IsAny<EventId>(),
                It.Is<It.IsAnyType>((v, t) => true),
                It.IsAny<Exception>(),
                It.Is<Func<It.IsAnyType, Exception?, string>>((v, t) => true)),
            Times.Once);
    }

    #endregion

    #region GetPagedAsync Tests

    [Fact]
    public async Task GetPagedAsync_ValidQuery_ReturnsSuccessWithPagedResults()
    {
        // Arrange
        var query = new ProductQueryDto { PageNumber = 1, PageSize = 10 };
        var products = new List<Product>
        {
            new Product { Id = Guid.NewGuid(), Name = "Product 1", Price = 100m },
            new Product { Id = Guid.NewGuid(), Name = "Product 2", Price = 200m }
        };
        var pagedProducts = new PagedResult<Product>
        {
            Items = products,
            TotalCount = 2,
            PageNumber = 1,
            PageSize = 10
        };
        var productDtos = new List<ProductListItemDto>
        {
            new ProductListItemDto { Id = products[0].Id, Name = "Product 1" },
            new ProductListItemDto { Id = products[1].Id, Name = "Product 2" }
        };

        _mockProductRepository.Setup(x => x.GetPagedAsync(query, default))
            .ReturnsAsync(pagedProducts);
        _mockMapper.Setup(x => x.Map<List<ProductListItemDto>>(products))
            .Returns(productDtos);

        // Act
        var result = await _sut.GetPagedAsync(query);

        // Assert
        result.Should().NotBeNull();
        result.IsSuccess.Should().BeTrue();
        result.Data.Should().NotBeNull();
        result.Data!.Items.Should().HaveCount(2);
        result.Data.TotalCount.Should().Be(2);
    }

    [Fact]
    public async Task GetPagedAsync_EmptyResults_ReturnsSuccessWithEmptyList()
    {
        // Arrange
        var query = new ProductQueryDto { PageNumber = 1, PageSize = 10 };
        var pagedProducts = new PagedResult<Product>
        {
            Items = new List<Product>(),
            TotalCount = 0,
            PageNumber = 1,
            PageSize = 10
        };

        _mockProductRepository.Setup(x => x.GetPagedAsync(query, default))
            .ReturnsAsync(pagedProducts);
        _mockMapper.Setup(x => x.Map<List<ProductListItemDto>>(It.IsAny<List<Product>>()))
            .Returns(new List<ProductListItemDto>());

        // Act
        var result = await _sut.GetPagedAsync(query);

        // Assert
        result.Should().NotBeNull();
        result.IsSuccess.Should().BeTrue();
        result.Data!.Items.Should().BeEmpty();
        result.Data.TotalCount.Should().Be(0);
    }

    #endregion

    #region CreateAsync Tests

    [Fact]
    public async Task CreateAsync_ValidRequest_ReturnsSuccessWithCreatedProduct()
    {
        // Arrange
        var request = new CreateProductRequestDto
        {
            Name = "New Product",
            Price = 150m,
            Stock = 20,
            CategoryId = Guid.NewGuid()
        };
        var product = new Product { Id = Guid.NewGuid(), Name = request.Name };
        var productDto = new ProductResponseDto { Id = product.Id, Name = request.Name };
        var validationResult = new ValidationResult();

        _mockCreateValidator.Setup(x => x.ValidateAsync(request, default))
            .ReturnsAsync(validationResult);
        _mockMapper.Setup(x => x.Map<Product>(request))
            .Returns(product);
        _mockProductRepository.Setup(x => x.CreateAsync(It.IsAny<Product>(), default))
            .ReturnsAsync(product);
        _mockMapper.Setup(x => x.Map<ProductResponseDto>(product))
            .Returns(productDto);

        // Act
        var result = await _sut.CreateAsync(request);

        // Assert
        result.Should().NotBeNull();
        result.IsSuccess.Should().BeTrue();
        result.Data.Should().NotBeNull();
        result.Data!.Name.Should().Be(request.Name);

        _mockProductRepository.Verify(x => x.CreateAsync(It.IsAny<Product>(), default), Times.Once);
    }

    [Fact]
    public async Task CreateAsync_InvalidRequest_ReturnsFailure()
    {
        // Arrange
        var request = new CreateProductRequestDto
        {
            Name = "A", // Too short
            Price = 0m, // Invalid
            Stock = -1, // Negative
            CategoryId = Guid.NewGuid()
        };
        var validationResult = new ValidationResult(new[]
        {
            new ValidationFailure("Name", "Name too short"),
            new ValidationFailure("Price", "Price must be greater than 0")
        });

        _mockCreateValidator.Setup(x => x.ValidateAsync(request, default))
            .ReturnsAsync(validationResult);

        // Act
        var result = await _sut.CreateAsync(request);

        // Assert
        result.Should().NotBeNull();
        result.IsSuccess.Should().BeFalse();
        result.Error.Should().Contain("Name too short");

        _mockProductRepository.Verify(x => x.CreateAsync(It.IsAny<Product>(), default), Times.Never);
    }

    #endregion

    #region UpdateAsync Tests

    [Fact]
    public async Task UpdateAsync_ValidRequest_ReturnsSuccessWithUpdatedProduct()
    {
        // Arrange
        var productId = Guid.NewGuid();
        var request = new UpdateProductRequestDto
        {
            Name = "Updated Name",
            Price = 200m
        };
        var existingProduct = new Product
        {
            Id = productId,
            Name = "Old Name",
            Price = 100m,
            Stock = 10,
            CategoryId = Guid.NewGuid()
        };
        var productDto = new ProductResponseDto { Id = productId, Name = "Updated Name" };
        var validationResult = new ValidationResult();

        _mockProductRepository.Setup(x => x.GetByIdAsync(productId, default))
            .ReturnsAsync(existingProduct);
        _mockUpdateValidator.Setup(x => x.ValidateAsync(request, default))
            .ReturnsAsync(validationResult);
        _mockProductRepository.Setup(x => x.UpdateAsync(It.IsAny<Product>(), default))
            .ReturnsAsync(existingProduct);
        _mockMapper.Setup(x => x.Map<ProductResponseDto>(It.IsAny<Product>()))
            .Returns(productDto);

        // Act
        var result = await _sut.UpdateAsync(productId, request);

        // Assert
        result.Should().NotBeNull();
        result.IsSuccess.Should().BeTrue();
        result.Data.Should().NotBeNull();

        existingProduct.Name.Should().Be("Updated Name");
        existingProduct.Price.Should().Be(200m);

        _mockProductRepository.Verify(x => x.UpdateAsync(It.IsAny<Product>(), default), Times.Once);
    }

    [Fact]
    public async Task UpdateAsync_ProductNotFound_ReturnsFailure()
    {
        // Arrange
        var productId = Guid.NewGuid();
        var request = new UpdateProductRequestDto { Name = "Updated Name" };

        _mockProductRepository.Setup(x => x.GetByIdAsync(productId, default))
            .ReturnsAsync((Product?)null);

        // Act
        var result = await _sut.UpdateAsync(productId, request);

        // Assert
        result.Should().NotBeNull();
        result.IsSuccess.Should().BeFalse();
        result.Error.Should().Contain("not found");

        _mockProductRepository.Verify(x => x.UpdateAsync(It.IsAny<Product>(), default), Times.Never);
    }

    [Fact]
    public async Task UpdateAsync_OnlyProvidedFieldsUpdated_UpdatesSelectiveFields()
    {
        // Arrange
        var productId = Guid.NewGuid();
        var request = new UpdateProductRequestDto
        {
            Price = 250m // Only update price
            // Name, Stock, etc. are null
        };
        var existingProduct = new Product
        {
            Id = productId,
            Name = "Original Name",
            Price = 100m,
            Stock = 50,
            CategoryId = Guid.NewGuid()
        };
        var validationResult = new ValidationResult();

        _mockProductRepository.Setup(x => x.GetByIdAsync(productId, default))
            .ReturnsAsync(existingProduct);
        _mockUpdateValidator.Setup(x => x.ValidateAsync(request, default))
            .ReturnsAsync(validationResult);
        _mockProductRepository.Setup(x => x.UpdateAsync(It.IsAny<Product>(), default))
            .ReturnsAsync(existingProduct);
        _mockMapper.Setup(x => x.Map<ProductResponseDto>(It.IsAny<Product>()))
            .Returns(new ProductResponseDto { Id = productId });

        // Act
        var result = await _sut.UpdateAsync(productId, request);

        // Assert
        result.Should().NotBeNull();
        result.IsSuccess.Should().BeTrue();

        existingProduct.Name.Should().Be("Original Name"); // Not changed
        existingProduct.Price.Should().Be(250m); // Changed
        existingProduct.Stock.Should().Be(50); // Not changed
    }

    #endregion

    #region DeleteAsync Tests

    [Fact]
    public async Task DeleteAsync_ValidId_ReturnsSuccess()
    {
        // Arrange
        var productId = Guid.NewGuid();
        _mockProductRepository.Setup(x => x.ExistsAsync(productId, default))
            .ReturnsAsync(true);
        _mockProductRepository.Setup(x => x.DeleteAsync(productId, default))
            .Returns(Task.CompletedTask);

        // Act
        var result = await _sut.DeleteAsync(productId);

        // Assert
        result.Should().NotBeNull();
        result.IsSuccess.Should().BeTrue();

        _mockProductRepository.Verify(x => x.DeleteAsync(productId, default), Times.Once);
    }

    [Fact]
    public async Task DeleteAsync_ProductNotFound_ReturnsFailure()
    {
        // Arrange
        var productId = Guid.NewGuid();
        _mockProductRepository.Setup(x => x.ExistsAsync(productId, default))
            .ReturnsAsync(false);

        // Act
        var result = await _sut.DeleteAsync(productId);

        // Assert
        result.Should().NotBeNull();
        result.IsSuccess.Should().BeFalse();
        result.Error.Should().Contain("not found");

        _mockProductRepository.Verify(x => x.DeleteAsync(It.IsAny<Guid>(), default), Times.Never);
    }

    #endregion
}
```

### 5. Controller Tests

**File:** `ProductsControllerTests.cs`

```csharp
public class ProductsControllerTests
{
    private readonly Mock<IProductService> _mockProductService;
    private readonly Mock<ILogger<ProductsController>> _mockLogger;
    private readonly ProductsController _controller;

    public ProductsControllerTests()
    {
        _mockProductService = new Mock<IProductService>();
        _mockLogger = new Mock<ILogger<ProductsController>>();
        _controller = new ProductsController(_mockProductService.Object, _mockLogger.Object);
    }

    #region GetById Tests

    [Fact]
    public async Task GetById_ValidId_ReturnsOkWithProduct()
    {
        // Arrange
        var productId = Guid.NewGuid();
        var productDto = new ProductResponseDto
        {
            Id = productId,
            Name = "Test Product"
        };
        var serviceResult = Result<ProductResponseDto>.Success(productDto);

        _mockProductService.Setup(x => x.GetByIdAsync(productId, default))
            .ReturnsAsync(serviceResult);

        // Act
        var result = await _controller.GetById(productId, default);

        // Assert
        result.Should().NotBeNull();
        var okResult = result.Result.Should().BeOfType<OkObjectResult>().Subject;
        okResult.StatusCode.Should().Be(200);

        var response = okResult.Value.Should().BeOfType<ApiResponse<ProductResponseDto>>().Subject;
        response.Success.Should().BeTrue();
        response.Data.Should().NotBeNull();
        response.Data!.Id.Should().Be(productId);
    }

    [Fact]
    public async Task GetById_InvalidId_ReturnsNotFound()
    {
        // Arrange
        var productId = Guid.NewGuid();
        var serviceResult = Result<ProductResponseDto>.Failure("Product not found");

        _mockProductService.Setup(x => x.GetByIdAsync(productId, default))
            .ReturnsAsync(serviceResult);

        // Act
        var result = await _controller.GetById(productId, default);

        // Assert
        result.Should().NotBeNull();
        var notFoundResult = result.Result.Should().BeOfType<NotFoundObjectResult>().Subject;
        notFoundResult.StatusCode.Should().Be(404);

        var response = notFoundResult.Value.Should().BeOfType<ApiResponse>().Subject;
        response.Success.Should().BeFalse();
        response.Message.Should().Contain("Product not found");
    }

    #endregion

    #region GetPaged Tests

    [Fact]
    public async Task GetPaged_ValidQuery_ReturnsOkWithPagedResults()
    {
        // Arrange
        var query = new ProductQueryDto { PageNumber = 1, PageSize = 10 };
        var pagedResult = new PagedResult<ProductListItemDto>
        {
            Items = new List<ProductListItemDto>
            {
                new ProductListItemDto { Id = Guid.NewGuid(), Name = "Product 1" }
            },
            TotalCount = 1,
            PageNumber = 1,
            PageSize = 10
        };
        var serviceResult = Result<PagedResult<ProductListItemDto>>.Success(pagedResult);

        _mockProductService.Setup(x => x.GetPagedAsync(query, default))
            .ReturnsAsync(serviceResult);

        // Act
        var result = await _controller.GetPaged(query, default);

        // Assert
        result.Should().NotBeNull();
        var okResult = result.Result.Should().BeOfType<OkObjectResult>().Subject;
        okResult.StatusCode.Should().Be(200);
    }

    #endregion

    #region Create Tests

    [Fact]
    public async Task Create_ValidRequest_ReturnsCreatedAtAction()
    {
        // Arrange
        var request = new CreateProductRequestDto
        {
            Name = "New Product",
            Price = 100m,
            Stock = 10,
            CategoryId = Guid.NewGuid()
        };
        var createdProduct = new ProductResponseDto
        {
            Id = Guid.NewGuid(),
            Name = request.Name
        };
        var serviceResult = Result<ProductResponseDto>.Success(createdProduct);

        _mockProductService.Setup(x => x.CreateAsync(request, default))
            .ReturnsAsync(serviceResult);

        // Act
        var result = await _controller.Create(request, default);

        // Assert
        result.Should().NotBeNull();
        var createdResult = result.Result.Should().BeOfType<CreatedAtActionResult>().Subject;
        createdResult.StatusCode.Should().Be(201);
        createdResult.ActionName.Should().Be(nameof(ProductsController.GetById));

        var routeValues = createdResult.RouteValues;
        routeValues.Should().ContainKey("id");
        routeValues!["id"].Should().Be(createdProduct.Id);
    }

    [Fact]
    public async Task Create_InvalidModelState_ReturnsBadRequest()
    {
        // Arrange
        var request = new CreateProductRequestDto
        {
            Name = "A",
            Price = 0m,
            Stock = 10,
            CategoryId = Guid.NewGuid()
        };
        _controller.ModelState.AddModelError("Name", "Name too short");

        // Act
        var result = await _controller.Create(request, default);

        // Assert
        result.Should().NotBeNull();
        var badRequestResult = result.Result.Should().BeOfType<BadRequestObjectResult>().Subject;
        badRequestResult.StatusCode.Should().Be(400);

        _mockProductService.Verify(x => x.CreateAsync(It.IsAny<CreateProductRequestDto>(), default), Times.Never);
    }

    #endregion

    #region Update Tests

    [Fact]
    public async Task Update_ValidRequest_ReturnsOk()
    {
        // Arrange
        var productId = Guid.NewGuid();
        var request = new UpdateProductRequestDto { Name = "Updated Name" };
        var updatedProduct = new ProductResponseDto
        {
            Id = productId,
            Name = "Updated Name"
        };
        var serviceResult = Result<ProductResponseDto>.Success(updatedProduct);

        _mockProductService.Setup(x => x.UpdateAsync(productId, request, default))
            .ReturnsAsync(serviceResult);

        // Act
        var result = await _controller.Update(productId, request, default);

        // Assert
        result.Should().NotBeNull();
        var okResult = result.Result.Should().BeOfType<OkObjectResult>().Subject;
        okResult.StatusCode.Should().Be(200);
    }

    [Fact]
    public async Task Update_ProductNotFound_ReturnsNotFound()
    {
        // Arrange
        var productId = Guid.NewGuid();
        var request = new UpdateProductRequestDto { Name = "Updated Name" };
        var serviceResult = Result<ProductResponseDto>.Failure("Product not found");

        _mockProductService.Setup(x => x.UpdateAsync(productId, request, default))
            .ReturnsAsync(serviceResult);

        // Act
        var result = await _controller.Update(productId, request, default);

        // Assert
        result.Should().NotBeNull();
        var notFoundResult = result.Result.Should().BeOfType<NotFoundObjectResult>().Subject;
        notFoundResult.StatusCode.Should().Be(404);
    }

    #endregion

    #region Delete Tests

    [Fact]
    public async Task Delete_ValidId_ReturnsNoContent()
    {
        // Arrange
        var productId = Guid.NewGuid();
        var serviceResult = Result.Success();

        _mockProductService.Setup(x => x.DeleteAsync(productId, default))
            .ReturnsAsync(serviceResult);

        // Act
        var result = await _controller.Delete(productId, default);

        // Assert
        result.Should().NotBeNull();
        var noContentResult = result.Should().BeOfType<NoContentResult>().Subject;
        noContentResult.StatusCode.Should().Be(204);
    }

    [Fact]
    public async Task Delete_ProductNotFound_ReturnsNotFound()
    {
        // Arrange
        var productId = Guid.NewGuid();
        var serviceResult = Result.Failure("Product not found");

        _mockProductService.Setup(x => x.DeleteAsync(productId, default))
            .ReturnsAsync(serviceResult);

        // Act
        var result = await _controller.Delete(productId, default);

        // Assert
        result.Should().NotBeNull();
        var notFoundResult = result.Should().BeOfType<NotFoundObjectResult>().Subject;
        notFoundResult.StatusCode.Should().Be(404);
    }

    #endregion
}
```

## Test Coverage Requirements

Generate tests to achieve:

- **Line Coverage:** >85%
- **Branch Coverage:** >80%
- **All public methods:** 100% coverage

### Coverage Report Command

```bash
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover
```

### View Coverage Report

```bash
reportgenerator -reports:coverage.opencover.xml -targetdir:coveragereport
```

## Quality Checklist

Before completing, verify:

- [ ] All tests follow AAA pattern
- [ ] Test names follow convention: `MethodName_Scenario_ExpectedResult`
- [ ] All public methods tested
- [ ] Happy path tested
- [ ] Edge cases tested
- [ ] Error cases tested
- [ ] Null cases tested
- [ ] FluentAssertions used for readable assertions
- [ ] Moq used correctly for mocking
- [ ] No test dependencies (tests can run in any order)
- [ ] Tests are fast (<100ms each)
- [ ] InMemory database for repository tests
- [ ] Proper cleanup in Dispose()
- [ ] Async tests use async/await correctly
- [ ] Coverage >85%
- [ ] All tests pass

```

## Common Testing Patterns

### 1. Testing Async Methods

```csharp
[Fact]
public async Task AsyncMethod_Scenario_ExpectedResult()
{
    // Always use async/await
    var result = await _sut.MethodAsync();
    result.Should().NotBeNull();
}
```

### 2. Testing Exceptions

```csharp
[Fact]
public async Task Method_InvalidInput_ThrowsException()
{
    // Act & Assert
    await Assert.ThrowsAsync<ArgumentNullException>(() =>
        _sut.MethodAsync(null!));
}

// Or with FluentAssertions
[Fact]
public async Task Method_InvalidInput_ThrowsException()
{
    // Act
    Func<Task> act = async () => await _sut.MethodAsync(null!);

    // Assert
    await act.Should().ThrowAsync<ArgumentNullException>()
        .WithMessage("*parameter*");
}
```

### 3. Parameterized Tests (Theory)

```csharp
[Theory]
[InlineData(10, 5, 15)]
[InlineData(0, 0, 0)]
[InlineData(-5, 5, 0)]
public void Add_VariousInputs_ReturnsCorrectSum(int a, int b, int expected)
{
    // Act
    var result = _calculator.Add(a, b);

    // Assert
    result.Should().Be(expected);
}
```

### 4. Testing Logger Calls

```csharp
_mockLogger.Verify(
    x => x.Log(
        LogLevel.Error,
        It.IsAny<EventId>(),
        It.Is<It.IsAnyType>((v, t) => v.ToString()!.Contains("error message")),
        It.IsAny<Exception>(),
        It.Is<Func<It.IsAnyType, Exception?, string>>((v, t) => true)),
    Times.Once);
```

---

**Time Estimate:** 3-4 hours for complete test suite

**Success Criteria:**
- All tests pass
- Coverage >85%
- All layers tested (Repository, Service, Controller)
- Edge cases covered
- Error scenarios covered
