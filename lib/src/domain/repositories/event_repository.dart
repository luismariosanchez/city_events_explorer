import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:city_events_explorer/src/domain/entities/event_page.dart';
import 'package:city_events_explorer/src/domain/entities/filter_params.dart';

abstract class EventRepository {
  Future<List<Event>> getEvents();

  Future<List<Event>> getEventsFiltered(FilterParams params);

  Future<Event> getEventById(String id);

  Future<EventPage> getPaginatedEvents(
    FilterParams params,
    int page,
    int limit,
  );
}
