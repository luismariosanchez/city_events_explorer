import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:flutter/foundation.dart';

@immutable
class EventPage {
  final List<Event> eventList;
  final bool hasMore;

  const EventPage({required this.eventList, required this.hasMore});
}
