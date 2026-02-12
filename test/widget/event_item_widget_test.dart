import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:city_events_explorer/src/domain/entities/location.dart';
import 'package:city_events_explorer/src/presentation/widgets/event_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  final testEvent = Event(
    id: '1',
    title: 'Test Event Title',
    description: 'Test event description that should be visible.',
    category: 'Test',
    startDate: DateTime(2024, 1, 1),
    endDate: DateTime(2024, 1, 2),
    imageUrl: 'https://picsum.photos/seed/test/600/300',
    location: const Location(name: 'Test Location', lat: 0, lng: 0),
  );

  testWidgets('EventItemWidget should display event title and description', (
    WidgetTester tester,
  ) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EventItemWidget(
              event: testEvent,
              isFavorite: false,
              onFavoritePressed: (isFavorite, id) async {},
            ),
          ),
        ),
      );

      expect(find.text('Test Event Title'), findsOneWidget);
      expect(
        find.text('Test event description that should be visible.'),
        findsOneWidget,
      );
      expect(find.byType(GestureDetector), findsNWidgets(2));
    });
  });
}
