import 'package:flutter/foundation.dart';
import 'package:city_events_explorer/src/domain/entities/location.dart';

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

  const Event(
    this.id,
    this.title,
    this.description,
    this.category,
    this.startDate,
    this.endDate,
    this.imageUrl,
    this.location,
  );
}
