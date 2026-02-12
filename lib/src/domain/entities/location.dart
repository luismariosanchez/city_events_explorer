import 'package:flutter/foundation.dart';

@immutable
class Location {
  final String name;
  final double lat;
  final double lng;

  const Location(this.name, this.lat, this.lng);
}
