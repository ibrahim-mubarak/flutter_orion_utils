# orion

Utilities for Laravel Orion

## Getting Started

Example for
https://tailflow.github.io/laravel-orion-docs/v2.x/guide/search.html

```dart

    var builder = OrionSearchQueryBuilder();

    builder
      ..addScope("active")
      ..addScope("whereCategory", ["my-category"])
      ..addFilter(
          "created_at", Field.isGreaterThanOrEqualTo(DateTime(2020, 1, 1)))
      ..addFilter("meta.source_id", Field.isIn([1, 2, 3]), "or")
      ..withKeyword("Example post")
      ..sortByAsc("name")
      ..sortByDesc("meta.priority");
```