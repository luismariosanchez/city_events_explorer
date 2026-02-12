import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:city_events_explorer/src/presentation/widgets/event_item_image_widget.dart';
import 'package:city_events_explorer/src/presentation/widgets/event_item_more_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({
    super.key,
    required this.event,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  final Event event;
  final bool isFavorite;
  final Future<void> Function(bool, String) onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/event/${event.id}');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF232321),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EventItemImageWidget(
              event: event,
              isFavorite: isFavorite,
              onFavoritePressed: onFavoritePressed,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(event.description),
                  const SizedBox(height: 5),
                  EventItemMoreInfoWidget(event: event),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}