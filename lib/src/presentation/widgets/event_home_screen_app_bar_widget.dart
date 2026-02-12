import 'package:city_events_explorer/src/presentation/widgets/filter_button_widget.dart';
import 'package:city_events_explorer/src/presentation/widgets/text_search_widget.dart';
import 'package:flutter/material.dart';

class EventHomeScreenAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback? onFilterPressed;
  const EventHomeScreenAppBarWidget({this.onFilterPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      title: const TextSearchWidget(),
      actions: [
        FilterButtonWidget(onFilterPressed: onFilterPressed),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
