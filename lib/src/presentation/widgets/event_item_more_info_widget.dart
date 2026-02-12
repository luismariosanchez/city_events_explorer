import 'package:city_events_explorer/src/domain/entities/event.dart';
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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.place_outlined, color: Colors.white38),
            const SizedBox(width: 5),
            Text(
              event.location.name,
              style: const TextStyle(color: Colors.white38),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_month_rounded, color: Colors.white38),
            const SizedBox(width: 5),
            Text(
              _getStartAndEnDateFormatted(),
              style: const TextStyle(color: Colors.white38),
            ),
          ],
        ),
      ],
    );
  }
}
