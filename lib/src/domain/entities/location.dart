import 'package:flutter/foundation.dart';

@immutable
class Location {
  final String name;
  final double lat;
  final double lng;

  const Location({required this.name, required this.lat, required this.lng});
}
