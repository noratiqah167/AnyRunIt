import 'package:anyrunit/screens/rider_screen/rhome_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

TextStyle style = TextStyle(fontFamily: 'Oswald', fontSize: 20.0);

class Direction extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String custAddress;
  final double lati;
  final double longi;
  final double latii;
  final double longii;
  Direction(
      {Key key,
      this.latitude,
      this.longitude,
      this.custAddress,
      this.lati,
      this.longi,
      this.latii,
      this.longii})
      : super(key: key);

  @override
  _DirectionState createState() => _DirectionState(
      this.latitude,
      this.longitude,
      this.custAddress,
      this.lati,
      this.longi,
      this.latii,
      this.longii);
}

class _DirectionState extends State<Direction> {
  bool isReady = false;
  Position position;
  double latitude;
  double longitude;
  String custAddress;
  double lati;
  double longi;
  double latii;
  double longii;
  _DirectionState(this.latitude, this.longitude, this.custAddress, this.lati,
      this.longi, this.latii, this.longii);
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  GoogleMapController mapController;
  Set<Marker> markers = {};
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(4.1975, 101.2593),
    zoom: 9.4746,
  );

  // BitmapDescriptor stallIcon;
  // BitmapDescriptor riderIcon;
  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.pink,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyB9Pmn7HWmxm9XfVjxsntEKa9MNM5I7CKY",
      PointLatLng(latii, longii),
      PointLatLng(lati, longi),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }

  @override
  void initState() {
    _getPolyline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
    //         'assets/images/detination_map_marker.png')
    //     .then((s) {
    //   stallIcon = s;
    // });
    // BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
    //         'assets/images/driving_pin.png')
    //     .then((r) {
    //   riderIcon = r;
    // });
    //cust
    String _custAddress = ('$custAddress');
    String startCoordinatesString = '($latitude, $longitude)';
    LatLng _initialcameraposition = LatLng(latitude, longitude);
    // cust Location Marker
    Marker startMarker = Marker(
      markerId: MarkerId(startCoordinatesString),
      position: _initialcameraposition,
      infoWindow: InfoWindow(
          title: 'Customer at $_custAddress', snippet: startCoordinatesString),
      icon: BitmapDescriptor.defaultMarker,
    );

    //kedai
    String stallCoordinate = '($lati, $longi)';
    LatLng stallcameraposition = LatLng(lati, longi);
    // kedai Location Marker
    Marker stallMarker = Marker(
      markerId: MarkerId(stallCoordinate),
      position: stallcameraposition,
      infoWindow: InfoWindow(title: 'Buy at ', snippet: stallCoordinate),
      icon: BitmapDescriptor.defaultMarker,
    );

    //rider
    String riderCoordinate = '($latii, $longii)';
    LatLng ridercameraposition = LatLng(latii, longii);
    // rider Location Marker
    Marker riderMarker = Marker(
      markerId: MarkerId(riderCoordinate),
      position: ridercameraposition,
      infoWindow: InfoWindow(title: 'Rider from', snippet: riderCoordinate),
      icon: BitmapDescriptor.defaultMarker,
    );

    // Adding the markers to the list
    markers.add(startMarker);
    markers.add(stallMarker);
    markers.add(riderMarker);

    return Scaffold(
      appBar: AppBar(
        title: Text('CUSTOMER DIRECTION'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  builder: (context) => new AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          title: new Text(
                            'THANK YOU FOR DELIVERING',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RHomeTab()));
                              },
                            ),
                          ]),
                  context: context);
            },
            icon: Icon(
              Icons.done_all_rounded,
            ),
            color: Colors.black,
          ),
        ],
        backgroundColor: Colors.grey,
      ),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            markers: Set<Marker>.from(markers),
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            polylines: Set<Polyline>.of(polylines.values),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
          ),
        ),
        SizedBox(
          height: 25.0,
        )
      ]),
    );
  }
}
