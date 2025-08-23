import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:weather_project/provider/mapprovider.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final MapController _mapController = MapController();
  LatLng? _selectedLocation;
  double _currentZoom = 13.0; // Track zoom level separately

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: height * 0.85,
          width: width * 0.77,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(51.5, -0.09),
              initialZoom: 13,
              onMapEvent: (MapEvent mapEvent) {
                // Update current zoom when map zoom changes
                if (mapEvent is MapEventMove) {
                  setState(() {
                    _currentZoom = _mapController.camera.zoom;
                  });
                }
              },
              onTap: (tapPosition, point) {
                setState(() {
                  _selectedLocation = point;
                });

                if (point.latitude.isFinite && point.longitude.isFinite) {
                  context.read<MapProvider>().newlocation(
                        point.latitude,
                        point.longitude,
                      );
                }

                // No map movement - just place marker where clicked
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.yourapp', // REQUIRED
              ),
              if (_selectedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _selectedLocation!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),

        /// TOP LEFT LAT/LONG + CITY TILE
        Positioned(
          top: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_selectedLocation != null)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Lat: ${_selectedLocation!.latitude.toStringAsFixed(4)}, '
                    'Lng: ${_selectedLocation!.longitude.toStringAsFixed(4)}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 8),
              Consumer<MapProvider>(
                builder: (context, mapProvider, child) {
                  return Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      mapProvider.city ?? "No city selected",
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        /// TOP RIGHT SAVE BUTTON
        Positioned(
          top: 10,
          right: 10,
          child: InkWell(
            onTap: () {
              context.read<MapProvider>().savecity();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                   Color.fromRGBO(40, 60, 73, 1),
                   Color.fromRGBO(35, 46, 58, 1),
                   Color.fromRGBO(11, 8, 9, 1)
                ]),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}