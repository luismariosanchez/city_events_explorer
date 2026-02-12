// test/domain/usecases/favorites_usecase_test.dart
import 'package:city_events_explorer/src/domain/repositories/favorite_repository.dart';
import 'package:city_events_explorer/src/domain/usecases/change_favorite_state_usecase.dart';
import 'package:city_events_explorer/src/domain/usecases/get_favorites_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  late GetFavoritesUseCase getFavoritesUseCase;
  late ChangeFavoriteStateUseCase changeFavoriteStateUseCase;
  late MockFavoritesRepository mockRepository;

  setUp(() {
    mockRepository = MockFavoritesRepository();
    getFavoritesUseCase = GetFavoritesUseCase(mockRepository);
    changeFavoriteStateUseCase = ChangeFavoriteStateUseCase(mockRepository);
  });

  group('GetFavoritesUseCase', () {
    test('should return list of favorite event IDs from repository', () async {
      const expectedIds = ['event-1', 'event-2', 'event-3'];
      when(
        () => mockRepository.getFavorites(),
      ).thenAnswer((_) async => expectedIds);

      final result = await getFavoritesUseCase();

      expect(result, expectedIds);
      verify(() => mockRepository.getFavorites()).called(1);
    });

    test('should return empty list when no favorites exist', () async {
      when(() => mockRepository.getFavorites()).thenAnswer((_) async => []);

      final result = await getFavoritesUseCase();

      expect(result, isEmpty);
      verify(() => mockRepository.getFavorites()).called(1);
    });

    test('should throw exception when repository fails', () async {
      when(
        () => mockRepository.getFavorites(),
      ).thenThrow(Exception('Database error'));

      expect(() => getFavoritesUseCase(), throwsException);
      verify(() => mockRepository.getFavorites()).called(1);
    });
  });

  group('ChangeFavoriteStateUseCase', () {
    const eventId = 'event-123';

    test('should add favorite when isFavorite is true', () async {
      when(() => mockRepository.addFavorite(any())).thenAnswer((_) async => {});

      await changeFavoriteStateUseCase(true, eventId);

      verify(() => mockRepository.addFavorite(eventId)).called(1);
      verifyNever(() => mockRepository.removeFavorite(any()));
    });

    test('should remove favorite when isFavorite is false', () async {
      when(
        () => mockRepository.removeFavorite(any()),
      ).thenAnswer((_) async => {});

      await changeFavoriteStateUseCase(false, eventId);

      verify(() => mockRepository.removeFavorite(eventId)).called(1);
      verifyNever(() => mockRepository.addFavorite(any()));
    });

    test('should handle repository errors when adding favorite', () async {
      when(
        () => mockRepository.addFavorite(any()),
      ).thenThrow(Exception('Storage full'));

      expect(() => changeFavoriteStateUseCase(true, eventId), throwsException);
    });

    test('should handle repository errors when removing favorite', () async {
      when(
        () => mockRepository.removeFavorite(any()),
      ).thenThrow(Exception('Item not found'));

      expect(() => changeFavoriteStateUseCase(false, eventId), throwsException);
    });
  });
}
