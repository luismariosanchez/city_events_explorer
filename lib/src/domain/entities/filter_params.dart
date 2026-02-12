import 'package:flutter/foundation.dart';

@immutable
class FilterParams {
  final String? category;
  final DateTime? startDate;
  final DateTime? endDate;

  const FilterParams({this.category, this.startDate, this.endDate});
}
