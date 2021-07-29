import 'dart:math';
import 'package:anyrunit/screens/profile_page/profile_screen.dart';
import 'package:anyrunit/screens/rider_screen/direction.dart';
import 'package:anyrunit/screens/rider_screen/rhome_tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class ROrders extends StatefulWidget {
  @override
  _ROrdersState createState() => _ROrdersState();
}

class _ROrdersState extends State<ROrders> {
  var orderCollection = FirebaseFirestore.instance.collectionGroup('orders');
  double screenHeight, screenWidth;
  //current place of rider
  double lat;
  double long;
  //place of stall
  double lati;
  double longi;
  //cust
  double latt;
  double longg;
  //rc
  double a;
  //rs
  double b;
  //total distance
  double totalDistance;
  double etaHour;
  double etaMin;

  get $lati => lati;
  get $longi => longi;
  get $latt => latt;
  get $longg => longg;

  double calrc(latt, longg) {
    var lat2 = lat;
    var lon2 = long;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - latt) * p) / 2 +
        c(latt * p) * c(lat2 * p) * (1 - c((lon2 - longg) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double calrs(lati, longi) {
    var lat2 = lat;
    var lon2 = long;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lati) * p) / 2 +
        c(lati * p) * c(lat2 * p) * (1 - c((lon2 - longi) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    _getUserCurrentLoc();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("LIST ORDER"),
          backgroundColor: Colors.grey,
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.grey,
          ),
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(height: 100.0),
                FloatingActionButton.extended(
                    backgroundColor: Colors.amber,
                    focusColor: Colors.black,
                    icon: Icon(Icons.home),
                    heroTag: "homebtn",
                    label: Text("Home"),
                    tooltip: 'Show Snackbar',
                    onPressed: () async {
                      {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => RHomeTab(),
                          ),
                          (route) => false,
                        );
                      }
                    }),
                SizedBox(height: 10.0),
                FloatingActionButton.extended(
                    backgroundColor: Colors.amber,
                    focusColor: Colors.black,
                    heroTag: "OrderListbtn",
                    icon: Icon(Icons.list_alt_rounded),
                    label: Text("See Order"),
                    tooltip: 'Show Snackbar',
                    onPressed: () async {
                      {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => ROrders(),
                          ),
                          (route) => true,
                        );
                      }
                    }),
                SizedBox(height: 10.0),
                FloatingActionButton.extended(
                    backgroundColor: Colors.amber,
                    focusColor: Colors.black,
                    heroTag: "EditProfilebtn",
                    icon: Icon(Icons.person),
                    label: Text("Profile"),
                    tooltip: 'Show Snackbar',
                    onPressed: () async {
                      {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            // builder: (BuildContext context) => RiderProfile(),
                            // builder: (BuildContext context) => ProfileScreen(),
                            builder: (BuildContext context) => ProfileView(),
                          ),
                          (route) => true,
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
        body: StreamBuilder(
            stream: orderCollection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      DocumentSnapshot ds = snapshot.data.docs[i];
                      return Container(
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              spreadRadius: 2.0,
                              blurRadius: 5.0),
                        ]),
                        margin: EdgeInsets.all(4.0),
                        child: ListTile(
                          leading: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {},
                            child:
                                SvgPicture.asset("assets/icon/Group 355.svg"),
                          ),
                          title: Text(ds.data()['Product name'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black54)),
                          subtitle: Text(
                            "Earning RM" + ds.data()['Earning'].toString(),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.keyboard_arrow_right,
                                  color: Colors.black, size: 30.0),
                              onPressed: () async {
                                a = calrc(ds.data()['Lat'], ds.data()['Long']);
                                b = calrs(
                                    ds.data()['Lati'], ds.data()['Longi']);
                                totalDistance = a + b;
                                // tambah 0.25 sbb ikot sstandard traffic
                                etaHour = (totalDistance / 90)
                                    // + 0.25
                                    ;
                                etaMin = etaHour * 60;
                                showDialog(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("CUSTOMER DETAIL"),
                                      content: SingleChildScrollView(
                                          child: ListBody(children: <Widget>[
                                        SizedBox(height: 10),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 5, 20, 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 6,
                                                child: Column(
                                                  children: [
                                                    Text("Customer Location :"),
                                                    Container(
                                                        height: 30,
                                                        child: VerticalDivider(
                                                            color:
                                                                Colors.grey)),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                        height: 70,
                                                        child: Text(ds.data()[
                                                            "User location"])),
                                                    Container(
                                                        height: 30,
                                                        child: VerticalDivider(
                                                            color:
                                                                Colors.grey)),
                                                    Text("Delivery distance :" +
                                                        totalDistance
                                                            .toStringAsFixed(
                                                                2) +
                                                        "km"),
                                                    Text("Rider to stall :" +
                                                        b.toStringAsFixed(2) +
                                                        "km"),
                                                    Text("Rider to customer :" +
                                                        a.toStringAsFixed(2) +
                                                        "km"),
                                                    Container(
                                                        height: 30,
                                                        child: VerticalDivider(
                                                            color:
                                                                Colors.grey)),
                                                    Text(
                                                        "Estimation Time Arrival (ETA)= "),
                                                    Text("In hour:" +
                                                        etaHour.toStringAsFixed(
                                                            2) +
                                                        "hour, "),
                                                    Text("In minute:" +
                                                        etaMin.toStringAsFixed(
                                                            2) +
                                                        "min"),
                                                    // Text("Earnings: RM " +
                                                    //     ds.data()["Quantity"]
                                                    //         .toString())
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible:
                                                        false, // user must tap button!
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "ORDER DETAIL"),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: ListBody(
                                                            children: <Widget>[
                                                              //cust name
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    "assets/icon/profile.svg",
                                                                    color: Colors
                                                                        .black,
                                                                    height: 24,
                                                                    width: 24,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 18,
                                                                  ),
                                                                  Text(
                                                                    "CUSTOMER DETAILS",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            18),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                      size.height *
                                                                          0.01),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      "Customer Name: "),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(""),
                                                                  Expanded(
                                                                    child: Text(
                                                                      ds.data()[
                                                                          "Receiver Name"],
                                                                      maxLines:
                                                                          5,
                                                                      textDirection:
                                                                          TextDirection
                                                                              .ltr,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                      size.height *
                                                                          0.01),
                                                              //cust num
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      "Customer Number: "),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(""),
                                                                  Expanded(
                                                                    child: Text(
                                                                      ds
                                                                          .data()[
                                                                              "Receiver Number"]
                                                                          .toString(),
                                                                      maxLines:
                                                                          5,
                                                                      textDirection:
                                                                          TextDirection
                                                                              .ltr,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                      size.height *
                                                                          0.03),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    "assets/icon/Icon map-food.svg",
                                                                    color: Colors
                                                                        .black,
                                                                    height: 21,
                                                                    width: 21,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 18,
                                                                  ),
                                                                  Text(
                                                                    "ITEMS ORDERED",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            18),
                                                                  )
                                                                ],
                                                              ), //product name
                                                              SizedBox(
                                                                  height:
                                                                      size.height *
                                                                          0.01),

                                                              Row(
                                                                children: [
                                                                  Text(""),
                                                                  Expanded(
                                                                    child: Text(
                                                                      ds.data()[
                                                                          "Product name"],
                                                                      maxLines:
                                                                          5,
                                                                      textDirection:
                                                                          TextDirection
                                                                              .ltr,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                      size.height *
                                                                          0.01),
                                                              //qty to buy
                                                              Row(
                                                                children: [
                                                                  Text("To buy: " +
                                                                      ds
                                                                          .data()[
                                                                              "Quantity"]
                                                                          .toString() +
                                                                      " x RM " +
                                                                      ds
                                                                          .data()[
                                                                              "Item price"]
                                                                          .toString()),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                      size.height *
                                                                          0.01),
                                                              //image
                                                              Row(
                                                                children: [
                                                                  Center(
                                                                      child: Container(
                                                                          child: SingleChildScrollView(
                                                                    child: Image
                                                                        .network(
                                                                      ds.data()[
                                                                          'Product image'],
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      width:
                                                                          200,
                                                                    ),
                                                                  )))
                                                                ],
                                                              ),
                                                              //payment
                                                              SizedBox(
                                                                  height:
                                                                      size.height *
                                                                          0.03),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "PAYMENT SUMMARY",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 12,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Subtotal",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    "RM " +
                                                                        ds
                                                                            .data()["Subtotal"]
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 12,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Earning",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    "RM " +
                                                                        ds
                                                                            .data()["Earning"]
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 12,
                                                              ),
                                                              SvgPicture.asset(
                                                                "assets/icon/Path 73.svg",
                                                                width: 398,
                                                              ),
                                                              SizedBox(
                                                                height: 12,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Total",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    "RM " +
                                                                        ds
                                                                            .data()["Total Cust Pay"]
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 12,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Payment Type: COD",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),

                                                              //
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Visibility(
                                                              child:
                                                                  FloatingActionButton
                                                                      .extended(
                                                                onPressed: () {
                                                                  Navigator
                                                                      .pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            // MapView()
                                                                            // MapPage()
                                                                            Direction(
                                                                              latitude: ds.data()['Lat'],
                                                                              longitude: ds.data()['Long'],
                                                                              custAddress: ds.data()['User location'],
                                                                              lati: ds.data()['Lati'],
                                                                              longi: ds.data()['Longi'],
                                                                              latii: lat,
                                                                              longii: long,
                                                                            )),
                                                                    (Route<dynamic>
                                                                            route) =>
                                                                        false,
                                                                  );
                                                                },
                                                                icon: Icon(Icons
                                                                    .check),
                                                                label: Text(
                                                                    "TAKE ORDER"),
                                                                backgroundColor:
                                                                    Colors
                                                                        .lightGreen,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.01),
                                                          Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child:
                                                                FloatingActionButton
                                                                    .extended(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                ROrders()));
                                                              },
                                                              icon: Icon(Icons
                                                                  .warning),
                                                              label: Text(
                                                                  "TAKE ANOTHER ORDER"),
                                                              backgroundColor:
                                                                  Colors
                                                                      .redAccent,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child:
                                                    Text("SEE ORDER DETAIL"))),
                                      ])),
                                      actions: <Widget>[
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: TextButton(
                                            child: Text('Back'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }),
                        ),
                      );
                    });
              }
            }));
  }

  _getUserCurrentLoc() async {
    await _determinePosition().then((value) => {_getPlace(value)});
    setState(
      () {},
    );
  }

  void _getPlace(Position pos) async {
    await placemarkFromCoordinates(pos.latitude, pos.longitude);
    lat = pos.latitude;
    long = pos.longitude;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
