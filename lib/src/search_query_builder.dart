import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:laravel_orion/laravel_orion.dart';

class OrionSearchQueryBuilder {
  List<Map<String, dynamic>> filters = [];
  List<Map<String, dynamic>> scopes = [];
  List<Map<String, dynamic>> sortFields = [];
  String? keyword;

  void withKeyword(String keyword) => this.keyword = keyword;

  String build() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        if (filters.isNotEmpty) "filters": filters,
        if (scopes.isNotEmpty) "scopes": scopes,
        if (keyword != null) "search": {"value": keyword},
        if (sortFields.isNotEmpty) "sort": sortFields,
      };

  void addFilter(
    String fieldName,
    Field field, [
    String? type,
  ]) =>
      filters.add({
        "field": fieldName,
        "operator": field.operator,
        "value": formatValue(field.value),
        if (type != null) "type": type
      });

  void addScope(String name, [List<String>? parameters]) => scopes.add({
        "name": name,
        if (parameters != null) "parameters": parameters,
      });

  void _sortBy(String name, String direction) => sortFields.add({
        "field": name,
        "direction": direction,
      });

  void sortByAsc(String name) => _sortBy(name, 'asc');

  void sortByDesc(String name) => _sortBy(name, 'desc');

  dynamic formatValue(value) {
    if (value is DateTime) {
      return DateFormat("y-MM-dd").format(value);
    }

    return value;
  }
}
