import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:city_events_explorer/src/presentation/providers/date_filter_provider.dart';
import 'package:city_events_explorer/src/presentation/providers/event_provider.dart';
import 'package:city_events_explorer/src/presentation/providers/favorites_provider.dart';
import 'package:city_events_explorer/src/presentation/widgets/date_range_filter_widget.dart';
import 'package:city_events_explorer/src/presentation/widgets/event_item_widget.dart';
import 'package:city_events_explorer/src/presentation/widgets/event_home_screen_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EventHomeScreen extends ConsumerWidget {
  const EventHomeScreen({super.key});

  void showDateFilterSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF111113),
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.55,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Consumer(
                builder: (context, ref, child) {
                  final dateRange = ref.watch(dateRangeFilterProvider);
                  return DateRangeFilterSheet(
                    startDate: dateRange?.start,
                    endDate: dateRange?.end,
                    onDateRangeSelected: (pickedRange) {
                      ref.read(dateRangeFilterProvider.notifier).state =
                          pickedRange;
                      context.pop();
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Event>> eventsAsync = ref.watch(eventsProvider);
    final favorites = ref.watch(favoritesProvider);
    final favoritesNotifier = ref.watch(favoritesProvider.notifier);

    return Scaffold(
      appBar: EventHomeScreenAppBarWidget(
        onFilterPressed: () => showDateFilterSheet(context),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: eventsAsync.when(
          data: (events) => ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return EventItemWidget(
                event: event,
                isFavorite: favorites.contains(event.id),
                onFavoritePressed: favoritesNotifier.onFavoritePressed,
              );
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, st) {
            return Center(child: Text('Error: $err'));
          },
        ),
      ),
    );
  }
}
