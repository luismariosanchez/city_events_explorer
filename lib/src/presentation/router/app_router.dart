import 'package:city_events_explorer/src/presentation/screens/event_detail_screen.dart';
import 'package:city_events_explorer/src/presentation/screens/event_home_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const EventHomeScreen(),
      routes: [
        GoRoute(
          path: 'event/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return EventDetailScreen(eventId: id);
          },
        ),
      ],
    ),
  ],
);
