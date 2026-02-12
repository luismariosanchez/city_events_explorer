abstract class FavoritesRepository {
  Future<List<String>> getFavorites();

  Future<void> addFavorite(String eventId);

  Future<void> removeFavorite(String eventId);
}
