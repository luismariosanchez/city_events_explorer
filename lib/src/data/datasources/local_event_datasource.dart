import 'dart:convert';
import 'package:city_events_explorer/src/data/models/event_model.dart';
import 'package:flutter/services.dart';

class LocalEventDataSource {
  final String path;

  LocalEventDataSource({this.path = 'assets/data/events.json'});

  Future<List<EventModel>> loadEvents() async {
    final String jsonString = await rootBundle.loadString(path);
    final List<dynamic> decoded = json.decode(jsonString) as List<dynamic>;

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(
          (Map<String, dynamic> event) =>
              EventModel.fromJson(Map<String, dynamic>.from(event)),
        )
        .toList();
  }
}
