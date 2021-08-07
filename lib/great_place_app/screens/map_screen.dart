import 'package:flutter/material.dart';
import 'package:flutter_dart_complete_guide/great_place_app/models/place_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool? isSelecting;

  const MapScreen({
    Key? key,
    this.initialLocation = const PlaceLocation(
      latitude: 13.7189819,
      longitude: 100.8639551,
    ),
    this.isSelecting = false,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 15,
        ),
      ),
    );
  }
}
