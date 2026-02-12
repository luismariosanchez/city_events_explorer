import 'package:city_events_explorer/src/data/repositories/event_repository_impl.dart';
import 'package:city_events_explorer/src/data/repositories/favorites_repository_impl.dart';
import 'package:city_events_explorer/src/domain/usecases/get_events_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:city_events_explorer/src/data/datasources/local_event_datasource.dart';
import 'package:city_events_explorer/src/domain/repositories/event_repository.dart';
import 'package:city_events_explorer/src/domain/repositories/favorite_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Provider<SharedPreferences>
sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be provided with a concrete implementation.',
  );
});

final Provider<LocalEventDataSource> localEventDataSourceProvider =
    Provider<LocalEventDataSource>((Ref ref) {
      return LocalEventDataSource();
    });

final Provider<EventRepository> eventRepositoryProvider =
    Provider<EventRepository>((Ref ref) {
      final LocalEventDataSource dataSource = ref.read(
        localEventDataSourceProvider,
      );
      return EventRepositoryImpl(dataSource: dataSource);
    });

final Provider<FavoritesRepository> favoritesRepositoryProvider =
    Provider<FavoritesRepository>((ref) {
      final prefs = ref.read(sharedPreferencesProvider);
      return FavoritesRepositoryImpl(sharedPreferences: prefs);
    });

final getEventsUseCaseProvider = Provider<GetEventsUseCase>((ref) {
  final repo = ref.watch(eventRepositoryProvider);
  return GetEventsUseCase(repo);
});
