import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:securezone/screens/sos.dart';
import 'package:securezone/screens/tabs.dart';

class GMapScreen extends StatefulWidget {
  const GMapScreen({super.key});

  @override
  State<GMapScreen> createState() => _GMapScreenState();
}

class _GMapScreenState extends State<GMapScreen> {
  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _pGooglePlex = LatLng(10.0452, 76.3267);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationUpdates();
  }

  LatLng? _currentP = _pGooglePlex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                _cameraToPosition(_currentP!);
              },
              child: Icon(
                Icons.radar_outlined,
                color: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              backgroundColor: knavbartheme,
            ),
            SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              backgroundColor: knavbartheme,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => SOSScreen()));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: Text('SOS',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white)),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: GoogleMap(
        onMapCreated: ((GoogleMapController controller) =>
            _mapController.complete(controller)),
        initialCameraPosition: CameraPosition(target: _pGooglePlex, zoom: 8),
        markers: {
          Marker(
              markerId: MarkerId("_currentLocation"),
              icon: BitmapDescriptor.defaultMarker,
              position: _currentP!),
          Marker(
              infoWindow: InfoWindow(title: "Test"),
              markerId: MarkerId("_sourcelocation"),
              icon: BitmapDescriptor.defaultMarker,
              position: _pGooglePlex),
        },
      ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 14);

    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();

    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();

      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          print(_currentP);
        });
      }
    });
  }
}
