import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchNotifier extends StateNotifier<String> {
  SearchNotifier() : super('');

  Timer? _debounceTimer;

  void updateSearchQuery(String query) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      state = query;
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

final searchQueryProvider =
    StateNotifierProvider.autoDispose<SearchNotifier, String>(
      (ref) => SearchNotifier(),
    );
