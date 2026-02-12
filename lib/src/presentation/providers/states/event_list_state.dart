import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:flutter/foundation.dart';

@immutable
class EventListState {
  final List<Event> events;
  final bool hasMore;
  final bool isLoadingNextPage;

  const EventListState({
    this.events = const [],
    this.hasMore = true,
    this.isLoadingNextPage = false,
  });

  EventListState copyWith({
    List<Event>? events,
    bool? hasMore,
    bool? isLoadingNextPage,
  }) {
    return EventListState(
      events: events ?? this.events,
      hasMore: hasMore ?? this.hasMore,
      isLoadingNextPage: isLoadingNextPage ?? this.isLoadingNextPage,
    );
  }
}
