
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? _googleMapController;
  final Location _location = Location();
  LatLng? _previousLocation;
  LatLng _myCurrentLocation = const LatLng(0, 0);
  final Set<Polyline> _polyLines = {};
  final List<LatLng> _polylineCoordinates = [];

  Marker? _marker;

  @override
  void initState() {
    super.initState();
    _initMap();
    _startLocationUpdate();
  }

  Future<void> _initMap() async {
    final locationData = await _location.getLocation();
    setState(() {
      _myCurrentLocation = LatLng(locationData.latitude!, locationData.longitude!);
      _googleMapController?.animateCamera(CameraUpdate.newLatLng(_myCurrentLocation));
      _marker = Marker(
        markerId: const MarkerId('MyCurrentLocation'),
        position: _myCurrentLocation,
      );
    });
  }

  void _startLocationUpdate() {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      final locationData = await _location.getLocation();
      setState(() {
        _previousLocation = _myCurrentLocation;
        _myCurrentLocation = LatLng(locationData.latitude!, locationData.longitude!);
        _updateMap();
      });
    });
  }

  void _updateMap() {
    setState(() {
      _marker = Marker(
        markerId: const MarkerId('currentLocation'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: _myCurrentLocation,

        infoWindow: InfoWindow(
          title: 'My Current Location',
          snippet: '${_myCurrentLocation.latitude}, ${_myCurrentLocation.longitude}',
        ),
      );

      if(_previousLocation?.latitude != 0.0){
        _polylineCoordinates.add(_previousLocation!);
      }

      _polylineCoordinates.add(_myCurrentLocation);
      if (_previousLocation?.longitude != 0.0 && _myCurrentLocation.latitude != 0.0) {
        _polyLines.add(
          Polyline(
            polylineId: const PolylineId('polyline'),
            color: Colors.amber,
            width: 5,
            points: _polylineCoordinates,
          ),
        );
      }
    });

    _googleMapController?.animateCamera(CameraUpdate.newLatLng(_myCurrentLocation));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-Time Location Tracker'),

      ),
      body: GoogleMap(
        compassEnabled:true,
        onMapCreated: (controller) {
          _googleMapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _myCurrentLocation,
          zoom: 15,
          bearing: 30,
          tilt: 10,
        ),
        markers: _marker != null ? <Marker>{_marker!} : <Marker>{},
        polylines: _polyLines,
      ),
    );
  }
}