import 'package:flutter/material.dart';

class MapViewWidget extends StatelessWidget {
  const MapViewWidget({required this.lat, required this.lng, super.key});
  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    final staticMapUrl =
        'https://atlas.p3k.io/map/img'
        '?latitude=$lat&longitude=$lng'
        '&zoom=14&width=600&height=300&basemap=streets';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Location Preview', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.network(
            staticMapUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              return progress == null
                  ? child
                  : const Center(
                      heightFactor: 4,
                      child: CircularProgressIndicator(),
                    );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                color: Colors.grey.shade800,
                child: const Center(
                  child: Icon(
                    Icons.map_outlined,
                    size: 48,
                    color: Colors.white54,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
