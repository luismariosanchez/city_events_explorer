import 'package:city_events_explorer/src/domain/entities/location.dart';
import '../../domain/entities/event.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String startDate;
  final String endDate;
  final String imageUrl;
  final Map<String, dynamic> location;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.imageUrl,
    required this.location,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    category: json['category'] as String,
    startDate: json['startDate']as String,
    endDate: json['endDate'] as String,
    imageUrl: json['imageUrl'] as String,
    location: json['location'] as Map<String, dynamic>,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category,
    'startDate': startDate,
    'endDate': endDate,
    'imageUrl': imageUrl,
    'location': location,
  };

  Event toDomain() => Event(
    id: id,
    title: title,
    description: description,
    category: category,
    startDate: DateTime.parse(startDate),
    endDate: DateTime.parse(endDate),
    imageUrl: imageUrl,
    location: Location(
      name: location['name'] as String,
      lat: location['lat'] as double,
      lng: location['lng'] as double,
    ),
  );
}
