import 'dart:async';

import 'package:city_events_explorer/src/domain/entities/filter_params.dart';
import 'package:city_events_explorer/src/domain/repositories/event_repository.dart';
import 'package:city_events_explorer/src/presentation/providers/date_filter_provider.dart';
import 'package:city_events_explorer/src/presentation/providers/repositories_provider.dart';
import 'package:city_events_explorer/src/presentation/providers/search_provider.dart';
import 'package:city_events_explorer/src/presentation/providers/states/event_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _pageSize = 10;

class EventController extends StateNotifier<EventListState> {
  final EventRepository _eventRepository;
  final Ref _ref;
  int _currentPage = 0;

  EventController(this._eventRepository, this._ref)
    : super(const EventListState()) {
    _ref.listen(searchQueryProvider, (previous, next) => fetchFirstPage());
    _ref.listen(dateRangeFilterProvider, (previous, next) => fetchFirstPage());
    fetchFirstPage();
  }

  Future<void> fetchFirstPage() async {
    _currentPage = 0;
    state = const EventListState(isLoadingNextPage: true);
    await _fetchPage(_currentPage);
  }

  Future<void> fetchNextPage() async {
    if (state.isLoadingNextPage || !state.hasMore) return;

    state = state.copyWith(isLoadingNextPage: true);
    _currentPage++;
    await _fetchPage(_currentPage);
  }

  Future<void> _fetchPage(int page) async {
    // Artificial delay to visualize lazy loading
    await Future<dynamic>.delayed(const Duration(seconds: 3));

    final searchQuery = _ref.read(searchQueryProvider);
    final dateRange = _ref.read(dateRangeFilterProvider);
    final filters = FilterParams(
      category: searchQuery,
      startDate: dateRange?.start,
      endDate: dateRange?.end,
    );

    try {
      final eventPage = await _eventRepository.getPaginatedEvents(
        filters,
        page,
        _pageSize,
      );

      final newEvents = page == 0
          ? eventPage.eventList
          : [...state.events, ...eventPage.eventList];

      state = state.copyWith(
        events: newEvents,
        hasMore: eventPage.hasMore,
        isLoadingNextPage: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingNextPage: false, hasMore: false);
    }
  }
}

final eventsProvider =
    StateNotifierProvider.autoDispose<EventController, EventListState>((ref) {
      final eventRepository = ref.watch(eventRepositoryProvider);
      return EventController(eventRepository, ref);
    });
