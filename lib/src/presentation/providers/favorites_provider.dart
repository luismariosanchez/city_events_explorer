import 'package:city_events_explorer/src/domain/usecases/change_favorite_state_usecase.dart';
import 'package:city_events_explorer/src/domain/usecases/get_favorites_usecase.dart';
import 'package:city_events_explorer/src/presentation/providers/repositories_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesController extends StateNotifier<List<String>> {
  final GetFavoritesUseCase _getFavorites;
  final ChangeFavoriteStateUseCase _changeFavoriteState;

  FavoritesController(this._getFavorites, this._changeFavoriteState)
      : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final ids = await _getFavorites();
    state = ids;
  }

  Future<void> onFavoritePressed(bool newState, String id) async {
    await _changeFavoriteState(newState, id);
    if (newState) {
      if (!state.contains(id)) {
        state = [...state, id];
      }
    } else {
      state = state.where((i) => i != id).toList();
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesController, List<String>>((ref) {
  final getFavs = ref.watch(getFavoritesUseCaseProvider);
  final changeFav = ref.watch(changeFavoriteStateUseCaseProvider);
  return FavoritesController(getFavs, changeFav);
});