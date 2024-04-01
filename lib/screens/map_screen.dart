import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
          options: const MapOptions(
              initialCenter: LatLng(10.0452, 76.3267),
              initialZoom: 13,
              interactionOptions:  InteractionOptions(
                  flags: ~InteractiveFlag.doubleTapZoom)),
          children: [
            openStreetMapTileLater,
            const MarkerLayer(markers: [
              Marker(
                point: LatLng(10.0452, 76.3267),
                width: 60,
                height: 60,
                alignment: Alignment.centerLeft,
                child: Icon(Icons.location_on,size: 60,color: Colors.red,)
              )
            ])
          ]);
  }
}

TileLayer get openStreetMapTileLater => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
