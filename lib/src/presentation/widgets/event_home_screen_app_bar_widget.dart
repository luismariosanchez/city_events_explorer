import 'package:city_events_explorer/src/presentation/widgets/filter_button_widget.dart';
import 'package:city_events_explorer/src/presentation/widgets/text_search_widget.dart';
import 'package:flutter/material.dart';

class EventHomeScreenAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final void Function(String)? onSearchChanged;
  final VoidCallback? onFilterPressed;
  const EventHomeScreenAppBarWidget({
    this.onSearchChanged,
    this.onFilterPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      title: TextSearchWidget(onSearchChanged: onSearchChanged),
      actions: [
        FilterButtonWidget(onFilterPressed: onFilterPressed),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
