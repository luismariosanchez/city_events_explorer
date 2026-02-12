import 'package:city_events_explorer/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TextSearchWidget extends StatelessWidget {
  const TextSearchWidget({super.key, required this.onSearchChanged});
  final void Function(String p1)? onSearchChanged;

  @override
  Widget build(BuildContext context) {
    AppLocalizations? l10n = AppLocalizations.of(context);
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.white54),
          hintText: l10n!.searchHint,
          hintStyle: const TextStyle(color: Colors.white38),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
        onChanged: onSearchChanged,
      ),
    );
  }
}
