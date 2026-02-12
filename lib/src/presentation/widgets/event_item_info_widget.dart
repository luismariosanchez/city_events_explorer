import 'package:flutter/material.dart';

class EventItemInfoWidget extends StatelessWidget {
  const EventItemInfoWidget({
    super.key,
    required this.iconData,
    required this.description,
  });

  final IconData iconData;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, color: Colors.white38),
        const SizedBox(width: 5),
        Text(description, style: const TextStyle(color: Colors.white38)),
      ],
    );
  }
}
