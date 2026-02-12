import 'package:city_events_explorer/src/domain/entities/event.dart';

abstract class EventRepository {
  Future<List<Event>> getEvents();

  Future<List<Event>> getEventsFiltered({
    String? category,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<Event> getEventById(String id);
}
