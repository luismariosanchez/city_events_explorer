import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:city_events_explorer/src/presentation/widgets/event_item_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventItemMoreInfoWidget extends StatelessWidget {
  const EventItemMoreInfoWidget({super.key, required this.event});

  final Event event;

  String _getStartAndEnDateFormatted() {
    final dateFormatter = DateFormat('dd MMM yyyy, HH:mm');
    final String start = dateFormatter.format(event.startDate);
    final String end = dateFormatter.format(event.endDate);
    return '$start - $end';
  }

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
          description: _getStartAndEnDateFormatted(),
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
