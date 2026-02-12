import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:city_events_explorer/src/presentation/providers/event_provider.dart';
import 'package:city_events_explorer/src/presentation/widgets/event_item_widget.dart';
import 'package:city_events_explorer/src/presentation/widgets/event_home_screen_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventHomeScreen extends ConsumerWidget {
  const EventHomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Event>> eventsAsync = ref.watch(eventsProvider);
    return Scaffold(
      appBar: const EventHomeScreenAppBarWidget(),
      body: eventsAsync.when(
        data: (events) => ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return EventItemWidget(event: event);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) {
          return Center(child: Text('Error: $err'));
        },
      ),
    );
  }
}
