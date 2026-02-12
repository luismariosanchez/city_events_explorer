import 'package:flutter/foundation.dart';
import 'package:city_events_explorer/src/domain/entities/location.dart';
import 'package:intl/intl.dart';

@immutable
class Event {
  final String id;
  final String title;
  final String description;
  final String category;
  final DateTime startDate;
  final DateTime endDate;
  final String imageUrl;
  final Location location;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.imageUrl,
    required this.location,
  });

  String getStartAndEnDateFormatted() {
    final dateFormatter = DateFormat('dd MMM yyyy, HH:mm');
    final String start = dateFormatter.format(startDate);
    final String end = dateFormatter.format(endDate);
    return '$start - $end';
  }
}
