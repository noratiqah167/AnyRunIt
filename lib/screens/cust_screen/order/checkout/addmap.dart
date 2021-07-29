import 'package:anyrunit/models/delivery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ndialog/ndialog.dart';

class AddMap extends StatefulWidget {
  @override
  _AddMapState createState() => _AddMapState();
}

class _AddMapState extends State<AddMap> {
  GoogleMapController mapController;
  String searchAdd;
  double screenHeight, screenWidth;
  double dis = 0;
  Set<Marker> markers = Set();
  String _address = "No location selected";
  Delivery _delivery;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Flexible(
            flex: 7,
            child: GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition:
                  CameraPosition(target: LatLng(3.8909, 101.3766), zoom: 10.0),
              mapType: MapType.normal,
              markers: markers.toSet(),
              onTap: (newLatLng) {
                _loadAdd(newLatLng);
              },
            ),
          ),
          Positioned(
            top: 30,
            right: 15,
            left: 15,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Address',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 15,
                    top: 15,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: searchnavigate,
                    iconSize: 30,
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    searchAdd = val;
                  });
                },
              ),
            ),
          ),
          Divider(
            height: 5,
          ),
          Container(
              width: screenWidth,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text("Place to deliver",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Container(
                      width: screenWidth / 1.2,
                      child: Divider(),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Column(
                              children: [
                                Container(height: 70, child: Text(_address)),
                              ],
                            ),
                          ),
                          Container(
                              height: 50,
                              child: VerticalDivider(color: Colors.grey)),
                          Expanded(
                              flex: 4,
                              child: Container(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context, _delivery);
                                      },
                                      child: Text("Save"))))
                        ],
                      ),
                    ),
                  ],
                ),
              ))
        ],
      )),
    );
  }

  searchnavigate() {
    locationFromAddress(searchAdd).then((result) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(result[0].latitude, result[0].longitude),
        zoom: 20,
      )));
    });
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _loadAdd(LatLng newLatLng) async {
    MarkerId markerId1 = MarkerId("12");
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Searching address"), title: Text("Locating..."));
    progressDialog.show();
    List<Placemark> newPlace =
        await placemarkFromCoordinates(newLatLng.latitude, newLatLng.longitude);

    // this is all you need
    Placemark placeMark = newPlace[0];
    String name = placeMark.name.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    _address = name +
        "," +
        subLocality +
        ",\n" +
        locality +
        "," +
        postalCode +
        ",\n" +
        administrativeArea +
        "," +
        country;
    markers.clear();
    markers.add(Marker(
      markerId: markerId1,
      position: LatLng(newLatLng.latitude, newLatLng.longitude),
      infoWindow: InfoWindow(
        title: 'Address',
        snippet: _address,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    ));
    // dis = calculateDistance(newLatLng.latitude, newLatLng.longitude);
    _delivery = Delivery(_address, newLatLng);
    setState(() {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(newLatLng.latitude, newLatLng.longitude),
            zoom: 12,
          ),
        ),
      );
    });
    progressDialog.dismiss();
  }
}
