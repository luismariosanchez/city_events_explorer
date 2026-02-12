import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:city_events_explorer/src/domain/repositories/event_repository.dart';

class GetEventByIdUseCase {
  final EventRepository _repository;

  GetEventByIdUseCase(this._repository);

  Future<Event> call(String id) {
    return _repository.getEventById(id);
  }
}
