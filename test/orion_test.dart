import 'dart:convert';

import 'package:laravel_orion/laravel_orion.dart';
import 'package:test/test.dart';


void main() {
  test('Builder can add any number of filters', () {
    // Given something
    var builder = OrionSearchQueryBuilder();

    // When something happens
    builder
      ..addFilter(
        "created_at",
        Field.isGreaterThanOrEqualTo(DateTime(2020, 1, 1)),
      )
      ..addFilter('meta.source_id', Field.isIn([1, 2, 3]), "or");

    // Assert We get something
    var expectedQuery = jsonDecode("""
    {
    "filters" : [
        {"field" : "created_at", "operator" : ">=", "value" : "2020-01-01"},
        {"type" : "or", "field" : "meta.source_id", "operator" : "in", "value" : [1,2,3]}
    ]
}
    """);
    expect(jsonDecode(builder.build()), expectedQuery);
  });

  test('Builder can add any number of scopes', () {
    // Given something
    var builder = OrionSearchQueryBuilder();

    // When something happens
    builder
      ..addScope("active")
      ..addScope(
        "whereCategory",
        ["my-category"],
      );

    // Assert We get something
    var expectedQuery = jsonDecode("""
    {
    "scopes" : [
        {"name" : "active"},
        {"name" : "whereCategory", "parameters" : ["my-category"]}
    ]
}
    """);
    expect(jsonDecode(builder.build()), expectedQuery);
  });

  test('Builder can add keyword', () {
    // Given something
    var builder = OrionSearchQueryBuilder();

    // When something happens
    builder..withKeyword("Example post");

    // Assert We get something
    var expectedQuery = jsonDecode("""
    {
    "search" : {
        "value" : "Example post"
    }
}
    """);
    expect(jsonDecode(builder.build()), expectedQuery);
  });

  test('Builder can add any number of sortBy Field', () {
    // Given something
    var builder = OrionSearchQueryBuilder();

    // When something happens
    builder
      ..sortByAsc("name")
      ..sortByDesc("meta.priority");

    // Assert We get something
    var expectedQuery = jsonDecode("""
    {
     "sort" : [
        {"field" : "name", "direction" : "asc"},
        {"field" : "meta.priority", "direction" : "desc"}
    ]
}
    """);
    expect(jsonDecode(builder.build()), expectedQuery);
  });

  test('Builder can add scopes, filters, keyword and sort fields', () {
    // Given something
    var builder = OrionSearchQueryBuilder();

    // When something happens
    builder
      ..addScope("active")
      ..addScope("whereCategory", ["my-category"])
      ..addFilter(
          "created_at", Field.isGreaterThanOrEqualTo(DateTime(2020, 1, 1)))
      ..addFilter("meta.source_id", Field.isIn([1, 2, 3]), "or")
      ..withKeyword("Example post")
      ..sortByAsc("name")
      ..sortByDesc("meta.priority");

    // Assert We get something
    var expectedQuery = jsonDecode("""
 {
    "scopes" : [
        {"name" : "active"},
        {"name" : "whereCategory", "parameters" : ["my-category"]}
    ],
    "filters" : [
        {"field" : "created_at", "operator" : ">=", "value" : "2020-01-01"},
        {"type" : "or", "field" : "meta.source_id", "operator" : "in", "value" : [1,2,3]}
    ],
    "search" : {
        "value" : "Example post"
    },
    "sort" : [
        {"field" : "name", "direction" : "asc"},
        {"field" : "meta.priority", "direction" : "desc"}
    ]
}
    """);
    expect(jsonDecode(builder.build()), expectedQuery);
  });
}
