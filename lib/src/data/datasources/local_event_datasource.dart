import 'dart:convert';
import 'package:city_events_explorer/src/data/models/event_model.dart';
import 'package:flutter/services.dart';

class LocalEventDataSource {
  final String path;

  LocalEventDataSource({this.path = 'assets/data/events.json'});

  Future<List<EventModel>> loadEvents() async {
    final String jsonString = await rootBundle.loadString(path);
    final List<Map<String, dynamic>> decoded =
        json.decode(jsonString) as List<Map<String, dynamic>>;
    return decoded
        .map((Map<String, dynamic> event) => EventModel.fromJson(event))
        .toList();
  }
}
