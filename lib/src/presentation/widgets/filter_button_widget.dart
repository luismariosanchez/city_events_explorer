import 'package:flutter/material.dart';

class FilterButtonWidget extends StatelessWidget {
  const FilterButtonWidget({super.key, required this.onFilterPressed});

  final VoidCallback? onFilterPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF232321),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        icon: const Icon(Icons.filter_list, color: Colors.white),
        onPressed: onFilterPressed,
      ),
    );
  }
}
