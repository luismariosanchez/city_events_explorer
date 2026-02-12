import 'package:city_events_explorer/src/domain/repositories/favorite_repository.dart';

class GetFavoritesUseCase {
  final FavoritesRepository _repository;
  GetFavoritesUseCase(this._repository);

  Future<List<String>> call() => _repository.getFavorites();
}
