# ASP.NET Core Implementation Prompt Template

**Agent:** #13 - Implementation Agent
**Tool:** Cursor AI
**Framework:** ASP.NET Core 8.0 / C# 12
**Complexity:** High

---

## Prompt Template

```
You are an expert C# backend developer specializing in ASP.NET Core 8.0.

I need you to implement a complete feature following modern ASP.NET Core best practices.

## Context

**Project:** [Your Project Name]
**Framework:** ASP.NET Core 8.0
**Database:** [SQL Server / PostgreSQL / etc.]
**ORM:** Entity Framework Core 8.0

## Requirements

### API Specification

**Base URL:** /api/v1/[resource]

**Endpoints:**

[Paste OpenAPI specification or API design from Agent #12]

### Data Model

**Entity:** [EntityName]

```csharp
// Example structure (modify as needed)
public class Product
{
    public Guid Id { get; set; }
    public string Name { get; set; }
    public decimal Price { get; set; }
    public int Stock { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
```

### Business Rules

1. [List all business rules]
2. [Validation requirements]
3. [Authorization rules]
4. [Specific constraints]

## Implementation Requirements

### 1. Entity (Domain Model)

**Location:** `Domain/Entities/[EntityName].cs`

**Requirements:**
- Use C# 12 features (primary constructors, required properties where applicable)
- Include proper validation attributes
- Implement IEntity interface if using base entity pattern
- Add navigation properties for relationships
- Include audit fields (CreatedAt, UpdatedAt, CreatedBy, UpdatedBy)
- Use proper data annotations for EF Core configuration

**Example:**
```csharp
public class Product
{
    public Guid Id { get; set; }

    [Required]
    [MaxLength(200)]
    public required string Name { get; set; }

    [MaxLength(2000)]
    public string? Description { get; set; }

    [Column(TypeName = "decimal(18,2)")]
    [Range(0.01, 999999.99)]
    public decimal Price { get; set; }

    [Range(0, int.MaxValue)]
    public int Stock { get; set; }

    public Guid CategoryId { get; set; }

    // Navigation properties
    public Category Category { get; set; } = null!;
    public ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();

    // Audit fields
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
    public string CreatedBy { get; set; } = string.Empty;
    public string? UpdatedBy { get; set; }

    // Soft delete
    public bool IsDeleted { get; set; }
    public DateTime? DeletedAt { get; set; }
}
```

### 2. DTOs (Data Transfer Objects)

**Location:** `Application/DTOs/[EntityName]/`

**Create these DTOs:**

**a) Request DTOs:**

```csharp
// Application/DTOs/Product/CreateProductRequestDto.cs
public record CreateProductRequestDto
{
    [Required(ErrorMessage = "Product name is required")]
    [StringLength(200, MinimumLength = 3, ErrorMessage = "Name must be between 3 and 200 characters")]
    public required string Name { get; init; }

    [StringLength(2000, ErrorMessage = "Description cannot exceed 2000 characters")]
    public string? Description { get; init; }

    [Required(ErrorMessage = "Price is required")]
    [Range(0.01, 999999.99, ErrorMessage = "Price must be between 0.01 and 999999.99")]
    public decimal Price { get; init; }

    [Required(ErrorMessage = "Stock is required")]
    [Range(0, int.MaxValue, ErrorMessage = "Stock cannot be negative")]
    public int Stock { get; init; }

    [Required(ErrorMessage = "Category ID is required")]
    public Guid CategoryId { get; init; }
}

// Application/DTOs/Product/UpdateProductRequestDto.cs
public record UpdateProductRequestDto
{
    [StringLength(200, MinimumLength = 3)]
    public string? Name { get; init; }

    [StringLength(2000)]
    public string? Description { get; init; }

    [Range(0.01, 999999.99)]
    public decimal? Price { get; init; }

    [Range(0, int.MaxValue)]
    public int? Stock { get; init; }

    public Guid? CategoryId { get; init; }
}
```

**b) Response DTOs:**

```csharp
// Application/DTOs/Product/ProductResponseDto.cs
public record ProductResponseDto
{
    public Guid Id { get; init; }
    public required string Name { get; init; }
    public string? Description { get; init; }
    public decimal Price { get; init; }
    public int Stock { get; init; }
    public Guid CategoryId { get; init; }
    public string CategoryName { get; init; } = string.Empty;
    public DateTime CreatedAt { get; init; }
    public DateTime? UpdatedAt { get; init; }
}

// Application/DTOs/Product/ProductListItemDto.cs
public record ProductListItemDto
{
    public Guid Id { get; init; }
    public required string Name { get; init; }
    public decimal Price { get; init; }
    public int Stock { get; init; }
    public string CategoryName { get; init; } = string.Empty;
    public bool IsLowStock { get; init; }
}
```

**c) Query DTOs:**

```csharp
// Application/DTOs/Product/ProductQueryDto.cs
public record ProductQueryDto
{
    public string? SearchTerm { get; init; }
    public Guid? CategoryId { get; init; }
    public decimal? MinPrice { get; init; }
    public decimal? MaxPrice { get; init; }
    public bool? InStock { get; init; }
    public int PageNumber { get; init; } = 1;
    public int PageSize { get; init; } = 20;
    public string? SortBy { get; init; } = "Name";
    public string SortOrder { get; init; } = "asc";
}
```

### 3. Repository Interface & Implementation

**Location:** `Infrastructure/Repositories/`

**Interface:**
```csharp
// Domain/Repositories/IProductRepository.cs
public interface IProductRepository
{
    Task<Product?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);
    Task<PagedResult<Product>> GetPagedAsync(ProductQueryDto query, CancellationToken cancellationToken = default);
    Task<Product> CreateAsync(Product product, CancellationToken cancellationToken = default);
    Task<Product> UpdateAsync(Product product, CancellationToken cancellationToken = default);
    Task DeleteAsync(Guid id, CancellationToken cancellationToken = default);
    Task<bool> ExistsAsync(Guid id, CancellationToken cancellationToken = default);
    Task<int> GetStockAsync(Guid id, CancellationToken cancellationToken = default);
}
```

**Implementation:**
```csharp
// Infrastructure/Repositories/ProductRepository.cs
public class ProductRepository : IProductRepository
{
    private readonly ApplicationDbContext _context;
    private readonly ILogger<ProductRepository> _logger;

    public ProductRepository(ApplicationDbContext context, ILogger<ProductRepository> logger)
    {
        _context = context;
        _logger = logger;
    }

    public async Task<Product?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default)
    {
        return await _context.Products
            .Include(p => p.Category)
            .FirstOrDefaultAsync(p => p.Id == id && !p.IsDeleted, cancellationToken);
    }

    public async Task<PagedResult<Product>> GetPagedAsync(
        ProductQueryDto query,
        CancellationToken cancellationToken = default)
    {
        var queryable = _context.Products
            .Include(p => p.Category)
            .Where(p => !p.IsDeleted)
            .AsQueryable();

        // Apply filters
        if (!string.IsNullOrWhiteSpace(query.SearchTerm))
        {
            queryable = queryable.Where(p =>
                EF.Functions.Like(p.Name, $"%{query.SearchTerm}%") ||
                EF.Functions.Like(p.Description ?? "", $"%{query.SearchTerm}%"));
        }

        if (query.CategoryId.HasValue)
        {
            queryable = queryable.Where(p => p.CategoryId == query.CategoryId.Value);
        }

        if (query.MinPrice.HasValue)
        {
            queryable = queryable.Where(p => p.Price >= query.MinPrice.Value);
        }

        if (query.MaxPrice.HasValue)
        {
            queryable = queryable.Where(p => p.Price <= query.MaxPrice.Value);
        }

        if (query.InStock.HasValue && query.InStock.Value)
        {
            queryable = queryable.Where(p => p.Stock > 0);
        }

        // Get total count before pagination
        var totalCount = await queryable.CountAsync(cancellationToken);

        // Apply sorting
        queryable = query.SortBy?.ToLower() switch
        {
            "price" => query.SortOrder.ToLower() == "desc"
                ? queryable.OrderByDescending(p => p.Price)
                : queryable.OrderBy(p => p.Price),
            "stock" => query.SortOrder.ToLower() == "desc"
                ? queryable.OrderByDescending(p => p.Stock)
                : queryable.OrderBy(p => p.Stock),
            "createdat" => query.SortOrder.ToLower() == "desc"
                ? queryable.OrderByDescending(p => p.CreatedAt)
                : queryable.OrderBy(p => p.CreatedAt),
            _ => query.SortOrder.ToLower() == "desc"
                ? queryable.OrderByDescending(p => p.Name)
                : queryable.OrderBy(p => p.Name)
        };

        // Apply pagination
        var items = await queryable
            .Skip((query.PageNumber - 1) * query.PageSize)
            .Take(query.PageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<Product>
        {
            Items = items,
            TotalCount = totalCount,
            PageNumber = query.PageNumber,
            PageSize = query.PageSize
        };
    }

    public async Task<Product> CreateAsync(Product product, CancellationToken cancellationToken = default)
    {
        product.CreatedAt = DateTime.UtcNow;
        _context.Products.Add(product);
        await _context.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("Created product {ProductId} - {ProductName}", product.Id, product.Name);

        return product;
    }

    public async Task<Product> UpdateAsync(Product product, CancellationToken cancellationToken = default)
    {
        product.UpdatedAt = DateTime.UtcNow;
        _context.Products.Update(product);
        await _context.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("Updated product {ProductId}", product.Id);

        return product;
    }

    public async Task DeleteAsync(Guid id, CancellationToken cancellationToken = default)
    {
        var product = await GetByIdAsync(id, cancellationToken);
        if (product != null)
        {
            // Soft delete
            product.IsDeleted = true;
            product.DeletedAt = DateTime.UtcNow;
            await _context.SaveChangesAsync(cancellationToken);

            _logger.LogInformation("Deleted product {ProductId}", id);
        }
    }

    public async Task<bool> ExistsAsync(Guid id, CancellationToken cancellationToken = default)
    {
        return await _context.Products
            .AnyAsync(p => p.Id == id && !p.IsDeleted, cancellationToken);
    }

    public async Task<int> GetStockAsync(Guid id, CancellationToken cancellationToken = default)
    {
        return await _context.Products
            .Where(p => p.Id == id && !p.IsDeleted)
            .Select(p => p.Stock)
            .FirstOrDefaultAsync(cancellationToken);
    }
}
```

### 4. Service Interface & Implementation

**Location:** `Application/Services/`

**Interface:**
```csharp
// Application/Interfaces/IProductService.cs
public interface IProductService
{
    Task<Result<ProductResponseDto>> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);
    Task<Result<PagedResult<ProductListItemDto>>> GetPagedAsync(ProductQueryDto query, CancellationToken cancellationToken = default);
    Task<Result<ProductResponseDto>> CreateAsync(CreateProductRequestDto request, CancellationToken cancellationToken = default);
    Task<Result<ProductResponseDto>> UpdateAsync(Guid id, UpdateProductRequestDto request, CancellationToken cancellationToken = default);
    Task<Result> DeleteAsync(Guid id, CancellationToken cancellationToken = default);
}
```

**Implementation:**
```csharp
// Application/Services/ProductService.cs
public class ProductService : IProductService
{
    private readonly IProductRepository _productRepository;
    private readonly IMapper _mapper;
    private readonly ILogger<ProductService> _logger;
    private readonly IValidator<CreateProductRequestDto> _createValidator;
    private readonly IValidator<UpdateProductRequestDto> _updateValidator;

    public ProductService(
        IProductRepository productRepository,
        IMapper mapper,
        ILogger<ProductService> logger,
        IValidator<CreateProductRequestDto> createValidator,
        IValidator<UpdateProductRequestDto> updateValidator)
    {
        _productRepository = productRepository;
        _mapper = mapper;
        _logger = logger;
        _createValidator = createValidator;
        _updateValidator = updateValidator;
    }

    public async Task<Result<ProductResponseDto>> GetByIdAsync(
        Guid id,
        CancellationToken cancellationToken = default)
    {
        try
        {
            var product = await _productRepository.GetByIdAsync(id, cancellationToken);

            if (product == null)
            {
                return Result<ProductResponseDto>.Failure($"Product with ID {id} not found");
            }

            var dto = _mapper.Map<ProductResponseDto>(product);
            return Result<ProductResponseDto>.Success(dto);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting product {ProductId}", id);
            return Result<ProductResponseDto>.Failure("An error occurred while retrieving the product");
        }
    }

    public async Task<Result<PagedResult<ProductListItemDto>>> GetPagedAsync(
        ProductQueryDto query,
        CancellationToken cancellationToken = default)
    {
        try
        {
            var pagedProducts = await _productRepository.GetPagedAsync(query, cancellationToken);

            var dtoItems = _mapper.Map<List<ProductListItemDto>>(pagedProducts.Items);

            var result = new PagedResult<ProductListItemDto>
            {
                Items = dtoItems,
                TotalCount = pagedProducts.TotalCount,
                PageNumber = pagedProducts.PageNumber,
                PageSize = pagedProducts.PageSize
            };

            return Result<PagedResult<ProductListItemDto>>.Success(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting paged products");
            return Result<PagedResult<ProductListItemDto>>.Failure("An error occurred while retrieving products");
        }
    }

    public async Task<Result<ProductResponseDto>> CreateAsync(
        CreateProductRequestDto request,
        CancellationToken cancellationToken = default)
    {
        try
        {
            // Validate
            var validationResult = await _createValidator.ValidateAsync(request, cancellationToken);
            if (!validationResult.IsValid)
            {
                var errors = string.Join(", ", validationResult.Errors.Select(e => e.ErrorMessage));
                return Result<ProductResponseDto>.Failure(errors);
            }

            // Map to entity
            var product = _mapper.Map<Product>(request);
            product.Id = Guid.NewGuid();

            // Save
            var created = await _productRepository.CreateAsync(product, cancellationToken);

            // Map to response
            var dto = _mapper.Map<ProductResponseDto>(created);

            _logger.LogInformation("Product created successfully: {ProductId}", created.Id);

            return Result<ProductResponseDto>.Success(dto);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating product");
            return Result<ProductResponseDto>.Failure("An error occurred while creating the product");
        }
    }

    public async Task<Result<ProductResponseDto>> UpdateAsync(
        Guid id,
        UpdateProductRequestDto request,
        CancellationToken cancellationToken = default)
    {
        try
        {
            // Check if exists
            var existing = await _productRepository.GetByIdAsync(id, cancellationToken);
            if (existing == null)
            {
                return Result<ProductResponseDto>.Failure($"Product with ID {id} not found");
            }

            // Validate
            var validationResult = await _updateValidator.ValidateAsync(request, cancellationToken);
            if (!validationResult.IsValid)
            {
                var errors = string.Join(", ", validationResult.Errors.Select(e => e.ErrorMessage));
                return Result<ProductResponseDto>.Failure(errors);
            }

            // Update only provided fields
            if (request.Name != null) existing.Name = request.Name;
            if (request.Description != null) existing.Description = request.Description;
            if (request.Price.HasValue) existing.Price = request.Price.Value;
            if (request.Stock.HasValue) existing.Stock = request.Stock.Value;
            if (request.CategoryId.HasValue) existing.CategoryId = request.CategoryId.Value;

            // Save
            var updated = await _productRepository.UpdateAsync(existing, cancellationToken);

            // Map to response
            var dto = _mapper.Map<ProductResponseDto>(updated);

            _logger.LogInformation("Product updated successfully: {ProductId}", id);

            return Result<ProductResponseDto>.Success(dto);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating product {ProductId}", id);
            return Result<ProductResponseDto>.Failure("An error occurred while updating the product");
        }
    }

    public async Task<Result> DeleteAsync(Guid id, CancellationToken cancellationToken = default)
    {
        try
        {
            var exists = await _productRepository.ExistsAsync(id, cancellationToken);
            if (!exists)
            {
                return Result.Failure($"Product with ID {id} not found");
            }

            await _productRepository.DeleteAsync(id, cancellationToken);

            _logger.LogInformation("Product deleted successfully: {ProductId}", id);

            return Result.Success();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting product {ProductId}", id);
            return Result.Failure("An error occurred while deleting the product");
        }
    }
}
```

### 5. Controller

**Location:** `API/Controllers/`

**Requirements:**
- Use ApiController attribute
- Implement proper HTTP status codes
- Use ActionResult<T> for typed responses
- Add XML comments for Swagger
- Implement proper error handling
- Use CancellationToken for all async operations
- Add authorization attributes
- Implement API versioning

**Implementation:**
```csharp
// API/Controllers/ProductsController.cs
[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/[controller]")]
[Produces("application/json")]
public class ProductsController : ControllerBase
{
    private readonly IProductService _productService;
    private readonly ILogger<ProductsController> _logger;

    public ProductsController(IProductService productService, ILogger<ProductsController> logger)
    {
        _productService = productService;
        _logger = logger;
    }

    /// <summary>
    /// Get a product by ID
    /// </summary>
    /// <param name="id">The product ID</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>The product details</returns>
    /// <response code="200">Returns the product</response>
    /// <response code="404">Product not found</response>
    /// <response code="500">Internal server error</response>
    [HttpGet("{id:guid}")]
    [ProducesResponseType(typeof(ApiResponse<ProductResponseDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse), StatusCodes.Status404NotFound)]
    [ProducesResponseType(typeof(ApiResponse), StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<ApiResponse<ProductResponseDto>>> GetById(
        Guid id,
        CancellationToken cancellationToken)
    {
        var result = await _productService.GetByIdAsync(id, cancellationToken);

        if (!result.IsSuccess)
        {
            return NotFound(ApiResponse.Fail(result.Error));
        }

        return Ok(ApiResponse<ProductResponseDto>.Succeed(result.Data));
    }

    /// <summary>
    /// Get paginated list of products
    /// </summary>
    /// <param name="query">Query parameters</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Paginated list of products</returns>
    /// <response code="200">Returns the product list</response>
    /// <response code="400">Invalid query parameters</response>
    /// <response code="500">Internal server error</response>
    [HttpGet]
    [ProducesResponseType(typeof(ApiResponse<PagedResult<ProductListItemDto>>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse), StatusCodes.Status400BadRequest)]
    [ProducesResponseType(typeof(ApiResponse), StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<ApiResponse<PagedResult<ProductListItemDto>>>> GetPaged(
        [FromQuery] ProductQueryDto query,
        CancellationToken cancellationToken)
    {
        var result = await _productService.GetPagedAsync(query, cancellationToken);

        if (!result.IsSuccess)
        {
            return BadRequest(ApiResponse.Fail(result.Error));
        }

        return Ok(ApiResponse<PagedResult<ProductListItemDto>>.Succeed(result.Data));
    }

    /// <summary>
    /// Create a new product
    /// </summary>
    /// <param name="request">Product creation data</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>The created product</returns>
    /// <response code="201">Product created successfully</response>
    /// <response code="400">Invalid request data</response>
    /// <response code="401">Unauthorized</response>
    /// <response code="500">Internal server error</response>
    [HttpPost]
    [Authorize(Roles = "Admin,ProductManager")]
    [ProducesResponseType(typeof(ApiResponse<ProductResponseDto>), StatusCodes.Status201Created)]
    [ProducesResponseType(typeof(ApiResponse), StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(typeof(ApiResponse), StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<ApiResponse<ProductResponseDto>>> Create(
        [FromBody] CreateProductRequestDto request,
        CancellationToken cancellationToken)
    {
        if (!ModelState.IsValid)
        {
            return BadRequest(ApiResponse.Fail("Invalid request data", ModelState));
        }

        var result = await _productService.CreateAsync(request, cancellationToken);

        if (!result.IsSuccess)
        {
            return BadRequest(ApiResponse.Fail(result.Error));
        }

        return CreatedAtAction(
            nameof(GetById),
            new { id = result.Data!.Id },
            ApiResponse<ProductResponseDto>.Succeed(result.Data));
    }

    /// <summary>
    /// Update an existing product
    /// </summary>
    /// <param name="id">The product ID</param>
    /// <param name="request">Product update data</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>The updated product</returns>
    /// <response code="200">Product updated successfully</response>
    /// <response code="400">Invalid request data</response>
    /// <response code="401">Unauthorized</response>
    /// <response code="404">Product not found</response>
    /// <response code="500">Internal server error</response>
    [HttpPut("{id:guid}")]
    [Authorize(Roles = "Admin,ProductManager")]
    [ProducesResponseType(typeof(ApiResponse<ProductResponseDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(ApiResponse), StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(typeof(ApiResponse), StatusCodes.Status404NotFound)]
    [ProducesResponseType(typeof(ApiResponse), StatusCodes.Status500InternalServerError)]
    public async Task<ActionResult<ApiResponse<ProductResponseDto>>> Update(
        Guid id,
        [FromBody] UpdateProductRequestDto request,
        CancellationToken cancellationToken)
    {
        if (!ModelState.IsValid)
        {
            return BadRequest(ApiResponse.Fail("Invalid request data", ModelState));
        }

        var result = await _productService.UpdateAsync(id, request, cancellationToken);

        if (!result.IsSuccess)
        {
            if (result.Error!.Contains("not found"))
            {
                return NotFound(ApiResponse.Fail(result.Error));
            }
            return BadRequest(ApiResponse.Fail(result.Error));
        }

        return Ok(ApiResponse<ProductResponseDto>.Succeed(result.Data));
    }

    /// <summary>
    /// Delete a product
    /// </summary>
    /// <param name="id">The product ID</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>No content</returns>
    /// <response code="204">Product deleted successfully</response>
    /// <response code="401">Unauthorized</response>
    /// <response code="404">Product not found</response>
    /// <response code="500">Internal server error</response>
    [HttpDelete("{id:guid}")]
    [Authorize(Roles = "Admin")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(typeof(ApiResponse), StatusCodes.Status404NotFound)]
    [ProducesResponseType(typeof(ApiResponse), StatusCodes.Status500InternalServerError)]
    public async Task<IActionResult> Delete(Guid id, CancellationToken cancellationToken)
    {
        var result = await _productService.DeleteAsync(id, cancellationToken);

        if (!result.IsSuccess)
        {
            return NotFound(ApiResponse.Fail(result.Error));
        }

        return NoContent();
    }
}
```

### 6. AutoMapper Profile

**Location:** `Application/Mappings/`

```csharp
// Application/Mappings/ProductMappingProfile.cs
public class ProductMappingProfile : Profile
{
    public ProductMappingProfile()
    {
        // Entity to Response DTO
        CreateMap<Product, ProductResponseDto>()
            .ForMember(dest => dest.CategoryName, opt => opt.MapFrom(src => src.Category.Name));

        // Entity to List Item DTO
        CreateMap<Product, ProductListItemDto>()
            .ForMember(dest => dest.CategoryName, opt => opt.MapFrom(src => src.Category.Name))
            .ForMember(dest => dest.IsLowStock, opt => opt.MapFrom(src => src.Stock < 10));

        // Create Request DTO to Entity
        CreateMap<CreateProductRequestDto, Product>()
            .ForMember(dest => dest.Id, opt => opt.Ignore())
            .ForMember(dest => dest.CreatedAt, opt => opt.Ignore())
            .ForMember(dest => dest.UpdatedAt, opt => opt.Ignore())
            .ForMember(dest => dest.IsDeleted, opt => opt.Ignore());
    }
}
```

### 7. Validators (FluentValidation)

**Location:** `Application/Validators/`

```csharp
// Application/Validators/CreateProductRequestValidator.cs
public class CreateProductRequestValidator : AbstractValidator<CreateProductRequestDto>
{
    public CreateProductRequestValidator(IProductRepository productRepository)
    {
        RuleFor(x => x.Name)
            .NotEmpty().WithMessage("Product name is required")
            .Length(3, 200).WithMessage("Name must be between 3 and 200 characters");

        RuleFor(x => x.Description)
            .MaximumLength(2000).WithMessage("Description cannot exceed 2000 characters");

        RuleFor(x => x.Price)
            .GreaterThan(0).WithMessage("Price must be greater than 0")
            .LessThanOrEqualTo(999999.99m).WithMessage("Price cannot exceed 999999.99");

        RuleFor(x => x.Stock)
            .GreaterThanOrEqualTo(0).WithMessage("Stock cannot be negative");

        RuleFor(x => x.CategoryId)
            .NotEmpty().WithMessage("Category is required");
    }
}
```

### 8. Exception Handling Middleware

**Location:** `API/Middleware/`

```csharp
// API/Middleware/ExceptionHandlingMiddleware.cs
public class ExceptionHandlingMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<ExceptionHandlingMiddleware> _logger;

    public ExceptionHandlingMiddleware(RequestDelegate next, ILogger<ExceptionHandlingMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "An unhandled exception occurred");
            await HandleExceptionAsync(context, ex);
        }
    }

    private static Task HandleExceptionAsync(HttpContext context, Exception exception)
    {
        context.Response.ContentType = "application/json";
        context.Response.StatusCode = exception switch
        {
            ArgumentNullException => StatusCodes.Status400BadRequest,
            ArgumentException => StatusCodes.Status400BadRequest,
            UnauthorizedAccessException => StatusCodes.Status401Unauthorized,
            KeyNotFoundException => StatusCodes.Status404NotFound,
            _ => StatusCodes.Status500InternalServerError
        };

        var response = ApiResponse.Fail(
            exception.Message,
            context.Response.StatusCode == StatusCodes.Status500InternalServerError
                ? "An internal server error occurred"
                : exception.Message
        );

        return context.Response.WriteAsJsonAsync(response);
    }
}
```

### 9. Dependency Injection Setup

**Location:** `API/Program.cs` or `API/Startup.cs`

```csharp
// Register services
builder.Services.AddScoped<IProductRepository, ProductRepository>();
builder.Services.AddScoped<IProductService, ProductService>();

// Register validators
builder.Services.AddValidatorsFromAssemblyContaining<CreateProductRequestValidator>();

// Register AutoMapper
builder.Services.AddAutoMapper(typeof(ProductMappingProfile));

// Add DbContext
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// Add caching
builder.Services.AddStackExchangeRedisCache(options =>
{
    options.Configuration = builder.Configuration.GetConnectionString("Redis");
});

// Add authentication
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = builder.Configuration["Jwt:Issuer"],
            ValidAudience = builder.Configuration["Jwt:Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]!))
        };
    });

// Add Swagger
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo { Title = "Products API", Version = "v1" });

    // Add JWT authentication to Swagger
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Description = "JWT Authorization header using the Bearer scheme",
        Name = "Authorization",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.ApiKey,
        Scheme = "Bearer"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });

    // Include XML comments
    var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
    var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
    c.IncludeXmlComments(xmlPath);
});
```

## Technical Requirements

### Code Quality Standards

1. **SOLID Principles**
   - Single Responsibility: Each class has one reason to change
   - Open/Closed: Open for extension, closed for modification
   - Liskov Substitution: Derived classes must be substitutable
   - Interface Segregation: No fat interfaces
   - Dependency Inversion: Depend on abstractions

2. **Clean Code**
   - Methods < 20 lines
   - Classes < 300 lines
   - Meaningful names
   - No magic numbers
   - Proper comments for complex logic only

3. **Error Handling**
   - Use Result pattern for business logic errors
   - Use exceptions for unexpected errors
   - Log all errors with context
   - Return meaningful error messages to clients

4. **Performance**
   - Use async/await throughout
   - Implement proper cancellation token support
   - Use EF Core efficiently (avoid N+1 queries)
   - Implement caching where appropriate
   - Use pagination for lists

5. **Security**
   - Validate all inputs
   - Use parameterized queries (EF Core handles this)
   - Implement proper authentication/authorization
   - Don't expose sensitive data in responses
   - Use HTTPS only

### Database Configuration

```csharp
// Infrastructure/Data/Configurations/ProductConfiguration.cs
public class ProductConfiguration : IEntityTypeConfiguration<Product>
{
    public void Configure(EntityTypeBuilder<Product> builder)
    {
        builder.ToTable("Products");

        builder.HasKey(p => p.Id);

        builder.Property(p => p.Name)
            .IsRequired()
            .HasMaxLength(200);

        builder.Property(p => p.Description)
            .HasMaxLength(2000);

        builder.Property(p => p.Price)
            .HasColumnType("decimal(18,2)")
            .IsRequired();

        builder.Property(p => p.Stock)
            .IsRequired();

        builder.Property(p => p.CreatedAt)
            .IsRequired();

        builder.HasOne(p => p.Category)
            .WithMany()
            .HasForeignKey(p => p.CategoryId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasIndex(p => p.Name);
        builder.HasIndex(p => p.CategoryId);
        builder.HasIndex(p => p.Price);

        builder.HasQueryFilter(p => !p.IsDeleted);
    }
}
```

## Expected Output Structure

```
YourProject/
├── Domain/
│   ├── Entities/
│   │   └── Product.cs
│   └── Repositories/
│       └── IProductRepository.cs
├── Application/
│   ├── DTOs/
│   │   └── Product/
│   │       ├── CreateProductRequestDto.cs
│   │       ├── UpdateProductRequestDto.cs
│   │       ├── ProductResponseDto.cs
│   │       ├── ProductListItemDto.cs
│   │       └── ProductQueryDto.cs
│   ├── Interfaces/
│   │   └── IProductService.cs
│   ├── Services/
│   │   └── ProductService.cs
│   ├── Mappings/
│   │   └── ProductMappingProfile.cs
│   └── Validators/
│       ├── CreateProductRequestValidator.cs
│       └── UpdateProductRequestValidator.cs
├── Infrastructure/
│   ├── Data/
│   │   ├── ApplicationDbContext.cs
│   │   └── Configurations/
│   │       └── ProductConfiguration.cs
│   └── Repositories/
│       └── ProductRepository.cs
└── API/
    ├── Controllers/
    │   └── ProductsController.cs
    └── Middleware/
        └── ExceptionHandlingMiddleware.cs
```

## Quality Checklist

Before completing, verify:

- [ ] All classes follow SOLID principles
- [ ] Async/await used throughout
- [ ] CancellationToken supported in all async methods
- [ ] Proper error handling and logging
- [ ] Input validation implemented
- [ ] AutoMapper configured correctly
- [ ] Dependency injection setup
- [ ] XML comments for Swagger
- [ ] Proper HTTP status codes
- [ ] Authorization implemented where needed
- [ ] No N+1 query issues
- [ ] Indexes created for frequently queried fields
- [ ] Soft delete implemented
- [ ] Audit fields populated
- [ ] Code compiles without errors
- [ ] No compiler warnings
- [ ] Consistent naming conventions
- [ ] No code duplication
```

## Validation Steps

1. **Build the project**
   ```bash
   dotnet build
   ```

2. **Run migrations**
   ```bash
   dotnet ef migrations add AddProductEntity
   dotnet ef database update
   ```

3. **Test API with Swagger**
   - Navigate to `/swagger`
   - Test all endpoints
   - Verify response formats

4. **Verify database**
   - Check tables created
   - Verify indexes
   - Check constraints

---

**Time Estimate:** 4-6 hours for complete feature implementation

**Success Criteria:**
- All code compiles without errors or warnings
- All layers implemented (Entity, DTO, Repository, Service, Controller)
- Proper error handling throughout
- Authorization implemented
- Swagger documentation complete
- Database properly configured
