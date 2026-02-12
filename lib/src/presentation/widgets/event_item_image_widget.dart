import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:flutter/material.dart';

class EventItemImageWidget extends StatelessWidget {
  const EventItemImageWidget({
    super.key,
    required this.event,
    required this.isFavorite,
    this.onFavoritePressed,
  });

  final Event event;
  final bool isFavorite;
  final VoidCallback? onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    IconData favoriteIcon = isFavorite ? Icons.favorite : Icons.favorite_border;
    Color favoriteColor = isFavorite ? Colors.red : Colors.white;

    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(event.imageUrl),
          fit: BoxFit.fill,
        ),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          padding: const EdgeInsets.all(0),
          icon: Icon(favoriteIcon, color: favoriteColor),
          onPressed: onFavoritePressed,
        ),
      ),
    );
  }
}
