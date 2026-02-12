import 'package:city_events_explorer/src/domain/entities/event.dart';
import 'package:city_events_explorer/src/presentation/providers/repositories_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventDetailProvider = FutureProvider.autoDispose.family<Event, String>((
  ref,
  id,
) {
  final getEventById = ref.watch(getEventByIdUseCaseProvider);
  return getEventById(id);
});
