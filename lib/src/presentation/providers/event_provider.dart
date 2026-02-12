import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:city_events_explorer/src/domain/entities/filter_params.dart';
import 'package:city_events_explorer/src/domain/usecases/get_events_usecase.dart';
import 'package:city_events_explorer/src/presentation/providers/repositories_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventController extends StateNotifier<AsyncValue<List<Event>>> {
  final GetEventsUseCase _getEvents;

  EventController(this._getEvents) : super(const AsyncValue.loading()) {
    loadEvents();
  }

  Future<void> loadEvents([FilterParams? filters]) async {
    try {
      state = const AsyncValue.loading();
      final events = await _getEvents(filters);
      state = AsyncValue.data(events);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh([FilterParams? filters]) => loadEvents(filters);
}

final StateNotifierProvider<EventController, AsyncValue<List<Event>>>
eventsProvider =
    StateNotifierProvider<EventController, AsyncValue<List<Event>>>((Ref ref) {
      final GetEventsUseCase useCase = ref.watch(getEventsUseCaseProvider);
      return EventController(useCase);
    });
