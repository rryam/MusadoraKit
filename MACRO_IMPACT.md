# CatalogEndpoint Macro Impact Analysis

## Overview

The `@CatalogEndpoint` macro dramatically reduces boilerplate code in MusadoraKit by automatically generating catalog endpoint methods for music item types.

## Before and After Comparison

### Album Endpoints
- **Before**: 147 lines of code (CatalogAlbum.swift)
- **After**: 2 lines of code  
- **Reduction**: 98.6% less code

### Song Endpoints  
- **Before**: 236 lines of code (includes ISRC methods)
- **After**: 2 lines of code
- **Reduction**: 99.2% less code

### Artist Endpoints
- **Before**: 118 lines of code
- **After**: 2 lines of code  
- **Reduction**: 98.3% less code

## What the Macro Generates

### For All Types
- Single item fetch (4 overloads)
- Multiple items fetch (2 overloads)
- Private implementation methods

### For Album & Song Types
- UPC-based fetch methods (4 additional methods)

### For Song Type Only  
- ISRC-based fetch methods (4 additional methods)

## Benefits

1. **Consistency**: All endpoints follow the same pattern automatically
2. **Maintainability**: Changes to the pattern only need to be made once
3. **Type Safety**: Compile-time checking for resource types
4. **Documentation**: Auto-generated comprehensive documentation
5. **Backward Compatibility**: Exact same API surface maintained

## Usage Example

```swift
// Old way - 147 lines
public extension MCatalog {
  static func album(id: MusicItemID, fetch properties: AlbumProperties) async throws -> Album {
    try await album(with: id, fetch: properties)
  }
  // ... 7 more public methods
  // ... 4 private implementation methods
}

// New way - 2 lines
@CatalogEndpoint(resource: Album.self)
public extension MCatalog {}
```

## Potential for Other Macros

This same approach could be applied to:
- Library endpoints
- Search endpoints  
- Request builders
- Response decoders
- Error handling patterns

## Migration Strategy

1. Add macro alongside existing code
2. Verify generated code matches existing implementation
3. Remove old implementation
4. No breaking changes for consumers