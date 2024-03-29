import 'package:flutter/material.dart';
import 'package:flutter_dart_complete_guide/great_place_app/models/place_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapScreen({
    super.key,
    this.initialLocation = const PlaceLocation(
      latitude: 13.7189819,
      longitude: 100.8639551,
      address: 'NA',
    ),
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  void initState() {
    if (!widget.isSelecting) {
      _pickedLocation = LatLng(
        widget.initialLocation.latitude,
        widget.initialLocation.longitude,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 15,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: {
          if (_pickedLocation != null)
            Marker(
              markerId: MarkerId('M1'),
              position: _pickedLocation!,
            ),
        },
      ),
    );
  }
}
