import 'package:city_events_explorer/src/domain/repositories/favorite_repository.dart';

class ChangeFavoriteStateUseCase {
  final FavoritesRepository _repository;
  ChangeFavoriteStateUseCase(this._repository);

  Future<void> call(bool newFavoriteState, String id) async {
    if (newFavoriteState) {
      await _repository.addFavorite(id);
    } else {
      await _repository.removeFavorite(id);
    }
  }
}
