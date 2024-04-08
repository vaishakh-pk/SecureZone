import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:securezone/screens/emergency_contacts_screen.dart';
import 'package:securezone/screens/sos.dart';
import 'package:securezone/screens/tabs.dart';
import 'package:securezone/services/DBServices.dart';
import 'package:securezone/widgets/new_report.dart';
import 'package:securezone/widgets/news_overlay.dart';

class GMapScreen extends StatefulWidget {
  GMapScreen({super.key, this.filter});

  String? filter = "All";

  @override
  State<GMapScreen> createState() => _GMapScreenState();
}

class _GMapScreenState extends State<GMapScreen> {
  Location _locationController = new Location();

  List<Marker> markers = [];

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _pGooglePlex = LatLng(10.0452, 76.3267);

  List<Map<String, String>> reports = [];

  BitmapDescriptor theftMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor naturalMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor accidentMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor greyMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor redMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor testMarker = BitmapDescriptor.defaultMarker;
  String? emergencyCall;
  Map<String, BitmapDescriptor> markerMap = {};

  @override
  void initState() {
    super.initState();
    // Initialize markerMap with default values
    markerMap = {
      "Theft": BitmapDescriptor.defaultMarker,
      "Natural Disaster": BitmapDescriptor.defaultMarker,
      "Accident prone area": BitmapDescriptor.defaultMarker,
      "Other": BitmapDescriptor.defaultMarker,
      "Murder": BitmapDescriptor.defaultMarker,
      "Assault": BitmapDescriptor.defaultMarker,
      "Pickpocketing": BitmapDescriptor.defaultMarker,
    };
    // Call methods to add custom markers for all report types
    addMarkers();
    getLocationUpdates();
    fetchReports();
    fetchContacts();
    widget.filter = "All";

     Set<Circle> circles = Set.from([
            Circle(
              circleId: CircleId("MyLoc"),
              center: _currentP!,
              radius: 4000,
            )
          ]);
  }



  void addMarkers() async {
    // Load custom markers
    BitmapDescriptor theftMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(200, 200)),
      "images/theft.png",
    );
    BitmapDescriptor naturalMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(200, 200)),
      "images/natural.png",
    );
    BitmapDescriptor accidentMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(200, 200)),
      "images/accident.png",
    );
    BitmapDescriptor greyMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(200, 200)),
      "images/grey.png",
    );
    BitmapDescriptor redMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(200, 200)),
      "images/red.png",
    );
    // Update markerMap with custom markers
    setState(() {
      markerMap = {
        "Theft": theftMarker,
        "Natural Disaster": naturalMarker,
        "Accident prone area": accidentMarker,
        "Other": greyMarker,
        "Murder": redMarker,
        "Assault": redMarker,
        "Pickpocketing": theftMarker,
      };
    });
  }

  void _openAddReportOverlay(Map<String, String> report) {
    showModalBottomSheet(
        useSafeArea: true,
        useRootNavigator: true,
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (ctx) {
          return NewsOverlay(report: report);
        });
  }

  void fetchContacts() async {
    setState(() async {
      emergencyCall = await DBFunctions.fetchCallContacts();
    });
  }

  Future<void> fetchReports() async {
    // Call the fetchAllReports method from DBFunctions
    if (widget.filter == "All") {
      List<Map<String, String>> fetchedReports =
          await DBFunctions.fetchAllReports();
      setState(() {
        reports = fetchedReports;
      });
    } else if (widget.filter == "Accident") {
      List<Map<String, String>> fetchedReports =
          await DBFunctions.fetchAccidentReports();
      setState(() {
        reports = fetchedReports;
      });
    } else if (widget.filter == "Natural") {
      List<Map<String, String>> fetchedReports =
          await DBFunctions.fetchNaturalReports();
      setState(() {
        reports = fetchedReports;
      });
    } else if (widget.filter == "Theft") {
      List<Map<String, String>> fetchedReports =
          await DBFunctions.fetchTheftReports();
      setState(() {
        reports = fetchedReports;
      });
    } else if (widget.filter == "Murder") {
      List<Map<String, String>> fetchedReports =
          await DBFunctions.fetchMurderReports();
      setState(() {
        reports = fetchedReports;
      });
    } else {
      List<Map<String, String>> fetchedReports =
          await DBFunctions.fetchAllReports();
      setState(() {
        reports = fetchedReports;
      });
    }
    // Update the state with the fetched reports
  }

  LatLng? _currentP = _pGooglePlex;
  Set<Circle> circles = {};

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
              onPressed: () async {
                fetchContacts();
                if (emergencyCall == null) {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmergencyContactScreen()),
                  );
                  if (result == true) {
                    fetchContacts();
                  }
                } else {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => SOSScreen()));
                }
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
        mapType: MapType.normal,
        onMapCreated: ((GoogleMapController controller) =>
            _mapController.complete(controller)),
        initialCameraPosition: CameraPosition(target: _pGooglePlex, zoom: 12.5),
        circles: circles,
        markers: {
          Marker(
              markerId: MarkerId("_currentLocation"),
              icon: BitmapDescriptor.defaultMarker,
              position: _currentP!),
          // Marker(
          //     infoWindow: InfoWindow(title: "Test"),
          //     markerId: MarkerId("_sourcelocation"),
          //     icon: BitmapDescriptor.defaultMarker,
          //     position: _pGooglePlex),
          for (var report in reports)
            if (report['lattitude'] != null && report['longitude'] != null)
              Marker(
                  infoWindow: InfoWindow(
                      onTap: () {
                        if (report["type"] != "Accident prone area" &&
                            report["type"] != "Natural Disaster") {
                          _openAddReportOverlay(report);
                        }
                      },
                      title: report["title"]),
                  markerId: MarkerId(report['title']!),
                  icon: markerMap[report["type"]!]!,
                  position: LatLng(double.parse(report['lattitude']!),
                      double.parse(report['longitude']!))),
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
          DBFunctions.currentLat = _currentP!.latitude;
          DBFunctions.currentLong = _currentP!.longitude;

          circles = Set.from([
            Circle(
              circleId: CircleId("MyLoc"),
              center: _currentP!,
              radius: 1000,
              fillColor: Color.fromARGB(60, 72, 133, 213),
              strokeWidth: 0
            )
          ]);
        });
      }
    });
  }
}
