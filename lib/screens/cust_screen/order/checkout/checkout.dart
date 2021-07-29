import 'package:anyrunit/models/delivery.dart';
import 'package:anyrunit/models/userModel.dart';
import 'package:anyrunit/screens/cust_screen/home_screen/home_page.dart';
import 'package:anyrunit/screens/cust_screen/order/checkout/addmap.dart';
import 'package:anyrunit/screens/cust_screen/order/checkout/paymentmethod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ndialog/ndialog.dart';

List<Marker> myMarker = [];

class CheckOut extends StatefulWidget {
  final String uid;
  final int itemNumber;
  final double total;
  final double price;
  final double subtotal;
  final double charge;
  final String img;
  final String pname;
  final Delivery delivery;
  final double lati;
  final double longi;

  CheckOut(
      {Key key,
      this.itemNumber,
      this.total,
      @required this.uid,
      this.pname,
      this.img,
      this.delivery,
      this.subtotal,
      this.charge,
      this.lati,
      this.longi,
      this.price})
      : super(key: key);
  @override
  _CheckOutState createState() => _CheckOutState(
      uid,
      this.itemNumber,
      this.total,
      this.pname,
      this.img,
      this.subtotal,
      this.charge,
      this.lati,
      this.longi,
      this.price);
}

class _CheckOutState extends State<CheckOut> {
  double lati;
  double longi;
  int _radioValue = 0;
  bool _statusdel = false;
  bool _statuspickup = true;
  GoogleMapController mapController;
  String searchAddr;
  Users user;
  double price;
  TextEditingController usernameController;
  TextEditingController addressController = new TextEditingController();
  TextEditingController numController;
  String _address;
  String custName;
  String custNum;
  String img;
  String pname;
  final String uid;
  int itemNumber;
  double total;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String detail;
  String place;
  String location;
  double screenHeight, screenWidth;
  double lat;
  double long;
  double subtotal;
  double charge;
  _CheckOutState(this.uid, this.itemNumber, this.total, this.pname, this.img,
      this.subtotal, this.charge, this.lati, this.longi, this.price);

  get $itemNumber => itemNumber;
  get $total => total;
  get $subtotal => subtotal;
  get $charge => charge;
  get $pname => pname;
  get $img => img;
  get $lati => lati;
  get $longi => longi;
  get $price => price;

  void inputOrder() {
    formKey.currentState.save();
    formKeyyy.currentState.save();
    DateTime now = new DateTime.now();
    String date = intl.DateFormat('dd-MM-yyyy hh:mm a').format(now);
    final User user = auth.currentUser;
    final uid = user.uid;

    FirebaseFirestore.instance
        .collection('Order')
        .doc(uid)
        .collection('orders')
        .add({
      'Quantity': $itemNumber,
      'Subtotal': $subtotal,
      'Earning': $charge,
      'Total Cust Pay': $total,
      'User location': _address,
      'UserId': uid,
      'Date': date,
      'Time': DateTime.now(),
      'Receiver Name': custName,
      'Receiver Number': custNum,
      'Product name': $pname,
      'Product image': $img,
      "Lat": lat,
      "Long": long,
      "Lati": lati,
      "Longi": longi,
      "Item price": $price,
      "Payment Method": "Cash on Delivery",
    });
  }

  final formKey = GlobalKey<FormState>();
  final formKeyy = GlobalKey<FormState>();
  final formKeyyy = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final now = new DateTime.now();
    String today = DateFormat('hh:mm a').format(now);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: Align(
            alignment: Alignment.center,
            child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.black,
                onPressed: () {
                  //back
                  Navigator.pop(context, false);
                }),
          ),
          title: Center(
            child: Text(
              'Check Out',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            child: Stack(children: [
          Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.account_circle),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Contact info',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //name
                    Row(
                      children: [
                        Expanded(flex: 3, child: Text('RECEIVER NAME:')),
                        Container(
                            height: 20,
                            child: VerticalDivider(color: Colors.pink)),
                        Expanded(
                          flex: 7,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("Users")
                                  .where("UserId", isEqualTo: uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                } else {
                                  custName = snapshot.data.docs.first['Name'];
                                  return Container(
                                      child: Form(
                                    key: formKey,
                                    child: TextFormField(
                                      initialValue: custName,
                                      onSaved: (newValue) =>
                                          custName = newValue,
                                    ),
                                  ));
                                }
                              }),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //cust phone number
                    Row(
                      children: [
                        Expanded(flex: 3, child: Text('RECEIVER PHONE NUMBER')),
                        Container(
                            height: 20,
                            child: VerticalDivider(color: Colors.grey)),
                        Expanded(
                          flex: 7,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("Users")
                                  .where("UserId", isEqualTo: uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                } else {
                                  custNum =
                                      snapshot.data.docs.first["Phone Number"];
                                  return Container(
                                      child: Form(
                                    key: formKeyyy,
                                    child: TextFormField(
                                      initialValue: custNum,
                                      onSaved: (newValue) => custNum = newValue,
                                    ),
                                  ));
                                }
                              }),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Column(
                          children: [
                            Text(
                              "RECEIVER ADDRESS",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "REGISTERED ADDRESS",
                                    maxLines: 2,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                new Radio(
                                  value: 0,
                                  groupValue: _radioValue,
                                  onChanged: (int value) {
                                    _handleRadioValueChange(value);
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    "NEW ADDRESS",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                new Radio(
                                  value: 1,
                                  groupValue: _radioValue,
                                  onChanged: (int value) {
                                    _handleRadioValueChange(value);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //location

                    Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                    Visibility(
                      visible: _statuspickup,
                      child: Container(
                        margin: EdgeInsets.all(2),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: Column(
                            children: [
                              Text(
                                "ADDRESS",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                width: 300,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("Users")
                                        .where("UserId", isEqualTo: uid)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return CircularProgressIndicator();
                                      } else {
                                        _address =
                                            snapshot.data.docs.first['Address'];
                                        lat = double.parse(
                                            (snapshot.data.docs.first['Latt']));
                                        long = double.parse((snapshot
                                            .data.docs.first['Longg']));
                                        return Container(
                                            child: Form(
                                                key: formKeyy,
                                                child: Text(_address)));
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _statusdel,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Text(
                                "ADDRESS",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 6,
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: addressController,
                                            style: TextStyle(fontSize: 14),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText:
                                                    'Please choose address'),
                                            keyboardType:
                                                TextInputType.multiline,
                                            minLines:
                                                4, //Normal textInputField will be displayed
                                            maxLines:
                                                4, // when user presses enter it will adapt to it
                                          ),
                                        ],
                                      )),
                                  Container(
                                      height: 120,
                                      child:
                                          VerticalDivider(color: Colors.grey)),
                                  Expanded(
                                      flex: 4,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 150,
                                            child: ElevatedButton(
                                              onPressed: () => {
                                                _getUserCurrentLoc(),
                                                lat = lat,
                                                long = long
                                              },
                                              child: Text("Current"),
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.grey,
                                            height: 2,
                                          ),
                                          Container(
                                            width: 150,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                Delivery _del =
                                                    await Navigator.of(context)
                                                        .push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddMap(),
                                                  ),
                                                );
                                                print(_address);
                                                setState(() {
                                                  addressController.text =
                                                      _del.address;

                                                  _address =
                                                      addressController.text;

                                                  lat = _del.latlng.latitude;
                                                  long = _del.latlng.longitude;
                                                });
                                              },
                                              child: Text("Map"),
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    // Payment
                    PaymentMethod(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //place order & save to db
                    Container(
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Summary",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            Row(
                              // textDirection: TextDirection.ltr,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                      "Total to pay for  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    CircleAvatar(
                                      radius: 13,
                                      backgroundColor: Colors.blue,
                                      child: Text(
                                        "$itemNumber",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      "  quantity  = ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "RM $total",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            ButtonTheme(
                              height: 50.0,
                              minWidth: 100.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              child: RaisedButton(
                                elevation: 5.0,
                                padding: EdgeInsets.symmetric(horizontal: 60),
                                hoverColor: Colors.green,
                                color: Colors.blue,
                                child: Text(
                                  "Place Order",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  // print(_delivery.address);
                                  inputOrder();
                                  print('Order placed');
                                  showDialog(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Thank you for your order"),
                                        actions: <Widget>[
                                          Center(
                                            child: Icon(Icons.check_circle,
                                                color: Colors.blue,
                                                size: height / 5),
                                          ),
                                          Center(
                                            child: ButtonTheme(
                                              height: 50.0,
                                              minWidth: 100.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: BorderSide(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              child: RaisedButton(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 60),
                                                elevation: 5.0,
                                                hoverColor: Colors.green,
                                                color: Colors.blue,
                                                child: Text(
                                                  "OK",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onPressed: () {
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage()),
                                                    (route) => false,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ])));
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          _statusdel = false;
          _statuspickup = true;
          break;
        case 1:
          _statusdel = true;
          _statuspickup = false;
          break;
      }
      return _address;
    });
  }

  _getUserCurrentLoc() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Searching address"), title: Text("Locating..."));
    progressDialog.show();
    await _determinePosition().then((value) => {_getPlace(value)});
    setState(
      () {
        return _address;
      },
    );
    progressDialog.dismiss();
  }

  void _getPlace(Position pos) async {
    List<Placemark> newPlace =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);

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
    addressController.text = _address;
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

orderConfirmation(context) {
  var screenSize = MediaQuery.of(context).size;
  var height = screenSize.height;
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    transitionDuration: Duration(milliseconds: 600),
    barrierLabel: MaterialLocalizations.of(context).dialogLabel,
    barrierColor: Colors.black.withOpacity(0.5),
    pageBuilder: (context, _, __) {
      return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.6,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 3.0,
                      spreadRadius: 3.0),
                ],
              ),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        verticalDirection: VerticalDirection.down,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Icon(Icons.check_circle,
                              color: Colors.blue, size: height / 5),
                          Text(
                            "Thank you for your order",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          ButtonTheme(
                            height: 50.0,
                            minWidth: 100.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(horizontal: 60),
                              elevation: 5.0,
                              hoverColor: Colors.green,
                              color: Colors.blue,
                              child: Text(
                                "Track Your Order",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                (route) => false,
                              );
                            },
                            child: Text(
                              "Order Somthing else",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
    // transitionBuilder: (context, animation, secondaryAnimation, child) {
    //   return SlideTransition(
    //     position: CurvedAnimation(
    //       parent: animation,
    //       curve: Curves.easeOutCirc,
    //     ).drive(Tween<Offset>(
    //       begin: Offset(0, 2),
    //       end: Offset(0, .4),
    //     )),
    //     child: child,
    //   );
    // },
  );
}
