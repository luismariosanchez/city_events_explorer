import 'package:city_events_explorer/l10n/app_localizations.dart';
import 'package:city_events_explorer/src/presentation/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextSearchWidget extends ConsumerWidget {
  const TextSearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations? l10n = AppLocalizations.of(context);
    final searchNotifier = ref.read(searchQueryProvider.notifier);
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xFF232321),
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
        onChanged: searchNotifier.updateSearchQuery,
      ),
    );
  }
}
