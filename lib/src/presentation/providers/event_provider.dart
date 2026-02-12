import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:city_events_explorer/src/domain/entities/filter_params.dart';
import 'package:city_events_explorer/src/domain/usecases/get_events_usecase.dart';
import 'package:city_events_explorer/src/presentation/providers/date_filter_provider.dart';
import 'package:city_events_explorer/src/presentation/providers/repositories_provider.dart';
import 'package:city_events_explorer/src/presentation/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventController extends StateNotifier<AsyncValue<List<Event>>> {
  final GetEventsUseCase _getEvents;
  final Ref _ref;

  EventController(this._getEvents, this._ref)
    : super(const AsyncValue.loading()) {
    _ref.listen<String>(searchQueryProvider, (previous, next) {
      fetchEvents();
    });
    _ref.listen<DateTimeRange?>(dateRangeFilterProvider, (previous, next) {
      fetchEvents();
    });
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    state = const AsyncValue.loading();
    final searchQuery = _ref.read(searchQueryProvider);
    final dateRange = _ref.read(dateRangeFilterProvider);
    final filters = FilterParams(
      category: searchQuery,
      startDate: dateRange?.start,
      endDate: dateRange?.end,
    );

    try {
      final events = await _getEvents(filters);
      state = AsyncValue.data(events);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await fetchEvents();
  }
}

final eventsProvider =
    StateNotifierProvider.autoDispose<EventController, AsyncValue<List<Event>>>(
      (Ref ref) {
        final getEvents = ref.watch(getEventsUseCaseProvider);
        return EventController(getEvents, ref);
      },
    );
