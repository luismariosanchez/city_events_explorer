import 'package:flutter/material.dart';

class EventItemInfoWidget extends StatelessWidget {
  const EventItemInfoWidget({
    super.key,
    required this.iconData,
    required this.description,
    this.color = Colors.white38,
    this.fontSize = 14,
  });

  final IconData iconData;
  final String description;

  final Color color;

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, color: color),
        const SizedBox(width: 5),
        Text(
          description,
          style: TextStyle(color: color, fontSize: fontSize),
        ),
      ],
    );
  }
}
