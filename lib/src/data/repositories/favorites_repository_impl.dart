import 'package:city_events_explorer/src/domain/repositories/favorite_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  static const _keyFavorites = 'favorite_event_ids';
  final SharedPreferences sharedPreferences;

  FavoritesRepositoryImpl({required this.sharedPreferences});

  @override
  Future<List<String>> getFavorites() async {
    final ids = sharedPreferences.getStringList(_keyFavorites);
    return ids ?? [];
  }

  @override
  Future<void> addFavorite(String eventId) async {
    final List<String> ids = await getFavorites();
    if (!ids.contains(eventId)) {
      ids.add(eventId);
      await sharedPreferences.setStringList(_keyFavorites, ids);
    }
  }

  @override
  Future<void> removeFavorite(String eventId) async {
    final List<String> ids = await getFavorites();
    if (ids.contains(eventId)) {
      ids.remove(eventId);
      await sharedPreferences.setStringList(_keyFavorites, ids);
    }
  }
}
