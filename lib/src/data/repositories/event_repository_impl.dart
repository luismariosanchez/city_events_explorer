import 'package:city_events_explorer/src/data/datasources/local_event_datasource.dart';
import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:city_events_explorer/src/domain/entities/event_page.dart';
import 'package:city_events_explorer/src/domain/entities/filter_params.dart';
import 'package:city_events_explorer/src/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final LocalEventDataSource dataSource;

  EventRepositoryImpl({required this.dataSource});

  @override
  Future<List<Event>> getEvents() async {
    final models = await dataSource.loadEvents();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Event>> getEventsFiltered(FilterParams params) async {
    final allEvents = await getEvents();

    return allEvents.where((event) {
      final matchesCategory =
          params.category == null ||
          params.category!.isEmpty ||
          event.category.toLowerCase().contains(params.category!.toLowerCase());

      final matchesStart =
          params.startDate == null ||
          !event.startDate.isBefore(params.startDate!);

      final matchesEnd =
          params.endDate == null || !event.endDate.isAfter(params.endDate!);
      return matchesCategory && matchesStart && matchesEnd;
    }).toList();
  }

  @override
  Future<Event> getEventById(String id) async {
    final allEvents = await getEvents();
    return allEvents.firstWhere((event) => event.id == id);
  }

  @override
  Future<EventPage> getPaginatedEvents(
    FilterParams params,
    int page,
    int limit,
  ) async {
    final filteredEvents = await getEventsFiltered(params);

    final startIndex = page * limit;
    final endIndex = startIndex + limit;

    final eventList = filteredEvents.sublist(
      startIndex,
      endIndex > filteredEvents.length ? filteredEvents.length : endIndex,
    );

    final hasMore = endIndex < filteredEvents.length;

    return EventPage(eventList: eventList, hasMore: hasMore);
  }
}
