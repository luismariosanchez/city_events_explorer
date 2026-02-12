import 'package:city_events_explorer/l10n/app_localizations.dart';
import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:city_events_explorer/src/presentation/providers/event_detail_provider.dart';
import 'package:city_events_explorer/src/presentation/providers/favorites_provider.dart';
import 'package:city_events_explorer/src/presentation/widgets/event_item_info_widget.dart';
import 'package:city_events_explorer/src/presentation/widgets/map_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventDetailScreen extends ConsumerWidget {
  final String eventId;

  const EventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsyncValue = ref.watch(eventDetailProvider(eventId));

    return Scaffold(
      body: eventAsyncValue.when(
        data: (event) => _buildEventDetails(context, ref, event),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildEventDetails(BuildContext context, WidgetRef ref, Event event) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    final favorites = ref.watch(favoritesProvider);
    final favoritesNotifier = ref.read(favoritesProvider.notifier);
    final isFavorite = favorites.contains(event.id);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250.0,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(event.imageUrl),
                  fit: BoxFit.fill,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  event.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => favoritesNotifier.onFavoritePressed(
                        !isFavorite,
                        event.id,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFavorite
                            ? const Color(0xFF6C0F0F)
                            : const Color(0xFF232321),
                        foregroundColor: Colors.white,
                        elevation: 0,
                      ),
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                      ),
                      label: Text(
                        isFavorite
                            ? l10n.removeFromFavorites
                            : l10n.addToFavorites,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  EventItemInfoWidget(
                    description: event.location.name,
                    iconData: Icons.place_outlined,
                    color: Colors.white60,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 8),
                  EventItemInfoWidget(
                    description: event.getStartAndEnDateFormatted(),
                    iconData: Icons.calendar_month_rounded,
                    color: Colors.white60,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 8),
                  EventItemInfoWidget(
                    description: event.category,
                    iconData: Icons.category_outlined,
                    color: Colors.white60,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l10n.aboutTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  MapViewWidget(
                    lat: event.location.lat,
                    lng: event.location.lng,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
