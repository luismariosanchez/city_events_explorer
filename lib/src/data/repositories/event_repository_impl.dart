import 'package:city_events_explorer/src/data/datasources/local_event_datasource.dart';
import 'package:city_events_explorer/src/domain/entities/event.dart';
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
  Future<List<Event>> getEventsFiltered({
    String? category,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final allEvents = await getEvents();
    return allEvents.where((event) {
      final matchesCategory = category == null || event.category == category;
      final matchesStart =
          startDate == null || event.startDate.isAfter(startDate);
      final matchesEnd = endDate == null || event.endDate.isBefore(endDate);
      return matchesCategory && matchesStart && matchesEnd;
    }).toList();
  }
}
