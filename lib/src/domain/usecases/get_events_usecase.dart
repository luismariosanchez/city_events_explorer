import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:city_events_explorer/src/domain/entities/filter_params.dart';
import 'package:city_events_explorer/src/domain/repositories/event_repository.dart';

class GetEventsUseCase {
  final EventRepository _repository;

  GetEventsUseCase(this._repository);

  Future<List<Event>> call([FilterParams? filters]) {
    if (filters == null) {
      return _repository.getEvents();
    } else {
      return _repository.getEventsFiltered(
        category: filters.category,
        startDate: filters.startDate,
        endDate: filters.endDate,
      );
    }
  }
}
