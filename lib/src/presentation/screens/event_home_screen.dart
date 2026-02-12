import 'package:city_events_explorer/src/presentation/providers/date_filter_provider.dart';
import 'package:city_events_explorer/src/presentation/providers/event_provider.dart';
import 'package:city_events_explorer/src/presentation/providers/favorites_provider.dart';
import 'package:city_events_explorer/src/presentation/providers/states/event_list_state.dart';
import 'package:city_events_explorer/src/presentation/widgets/date_range_filter_widget.dart';
import 'package:city_events_explorer/src/presentation/widgets/event_item_widget.dart';
import 'package:city_events_explorer/src/presentation/widgets/event_home_screen_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EventHomeScreen extends ConsumerStatefulWidget {
  const EventHomeScreen({super.key});

  @override
  ConsumerState<EventHomeScreen> createState() => _EventHomeScreenState();
}

class _EventHomeScreenState extends ConsumerState<EventHomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(eventsProvider.notifier).fetchNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _showDateFilterSheet() {
    showModalBottomSheet<dynamic>(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer(
          builder: (context, ref, child) {
            final dateRange = ref.watch(dateRangeFilterProvider);
            return DateRangeFilterSheet(
              startDate: dateRange?.start,
              endDate: dateRange?.end,
              onDateRangeSelected: (pickedRange) {
                ref.read(dateRangeFilterProvider.notifier).state = pickedRange;
                context.pop();
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final EventListState eventState = ref.watch(eventsProvider);
    final favorites = ref.watch(favoritesProvider);
    final favoritesNotifier = ref.watch(favoritesProvider.notifier);

    if (eventState.events.isEmpty && eventState.isLoadingNextPage) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: EventHomeScreenAppBarWidget(
        onFilterPressed: _showDateFilterSheet,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: eventState.events.length + (eventState.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == eventState.events.length) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final event = eventState.events[index];
            return EventItemWidget(
              event: event,
              isFavorite: favorites.contains(event.id),
              onFavoritePressed: favoritesNotifier.onFavoritePressed,
            );
          },
        ),
      ),
    );
  }
}
