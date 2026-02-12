import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:city_events_explorer/src/presentation/widgets/event_item_info_widget.dart';
import 'package:flutter/material.dart';

class EventItemMoreInfoWidget extends StatelessWidget {
  const EventItemMoreInfoWidget({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EventItemInfoWidget(
          description: event.location.name,
          iconData: Icons.place_outlined,
        ),
        const SizedBox(height: 5),
        EventItemInfoWidget(
          description: event.getStartAndEnDateFormatted(),
          iconData: Icons.calendar_month_rounded,
        ),
        const SizedBox(height: 5),
        EventItemInfoWidget(
          description: event.category,
          iconData: Icons.category_outlined,
        ),
      ],
    );
  }
}
