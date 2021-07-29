import 'package:anyrunit/auth/authentication_service.dart';
import 'package:anyrunit/auth/sign_in_screen/sign_in_page.dart';
import 'package:anyrunit/constants/rounded_input_field.dart';
import 'package:anyrunit/constants/rounded_password_field.dart';
import 'package:anyrunit/constants/style_constant.dart';
import 'package:anyrunit/main.dart';
import 'package:anyrunit/models/delivery.dart';
import 'package:anyrunit/screens/cust_screen/order/checkout/addmap.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ndialog/ndialog.dart';

class SignUpBody extends StatefulWidget {
  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();
  String _address;
  String lat;
  String long;
  bool dataFilled = false;

  @override
  Widget build(BuildContext context) {
    final header = Container(
      padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: Text('AnyRunIt',
          style: TextStyle(fontSize: 70.0, fontWeight: FontWeight.bold)),
    );

    final header2 = Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
            child: Text(
              'Sign up',
              style: TextStyle(fontSize: 70.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(260.0, 3.0, 0.0, 0.0),
            child: Text(
              '.',
              style: TextStyle(
                  fontSize: 80.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
          )
        ],
      ),
    );

    final usernameField = InputRound(
      controller: usernameController,
      deco: InputDecoration(
        icon: Icon(
          Icons.person,
          color: kPrimaryColor,
        ),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        hintText: "Noratiqah",
        labelText: "USERNAME",
        labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey),
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
    );

    final emailField = InputRound(
      controller: emailController,
      deco: InputDecoration(
          icon: Icon(
            Icons.email,
            color: kPrimaryColor,
          ),
          hintText: "abc@gmail.com",
          labelText: 'EMAIL',
          labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green))),
    );

    final passwordField = InputPasswordRound(
      controller: passwordController,
    );

    final numField = InputRound(
      controller: numController,
      deco: InputDecoration(
          icon: Icon(
            Icons.phone,
            color: kPrimaryColor,
          ),
          hintText: "0123456789",
          labelText: 'PHONE NUMBER',
          labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green))),
    );

    final addressField = Row(
      children: [
        Expanded(
            flex: 6,
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(children: [
                        Icon(
                          Icons.add_road_outlined,
                          color: kPrimaryColor,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "ADDRESS DETAIL",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                              fontSize: 16),
                        )
                      ]),
                      TextField(
                        controller: addressController,
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Please write your full address",
                            labelText: "ADDRESS",
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        keyboardType: TextInputType.multiline,
                        minLines: 4, //Normal textInputField will be displayed
                        maxLines:
                            6, // when user presses enter it will adapt to it
                        cursorColor: Colors.blue,
                      ),
                      TextField(
                        controller: latController,
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Please write your address latitude",
                            labelText: "LATITUDE",
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        keyboardType: TextInputType.multiline,
                        minLines: 2, //Normal textInputField will be displayed
                        maxLines:
                            4, // when user presses enter it will adapt to it
                        cursorColor: Colors.blue,
                      ),
                      TextField(
                        controller: longController,
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Please write your address longitude",
                            labelText: "LONGITUDE",
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        keyboardType: TextInputType.multiline,
                        minLines: 2, //Normal textInputField will be displayed
                        maxLines:
                            4, // when user presses enter it will adapt to it
                        cursorColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            )),
        Container(height: 120, child: VerticalDivider(color: Colors.grey)),
        Expanded(
            flex: 4,
            child: Column(
              children: [
                Container(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () => {_getUserCurrentLoc(), lat, long},
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
                      Delivery _del = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddMap(),
                        ),
                      );
                      setState(() {
                        addressController.text = _del.address;
                        latController.text = _del.latlng.latitude.toString();
                        longController.text = _del.latlng.longitude.toString();
                        _address = addressController.text;
                        lat = latController.text;
                        long = longController.text;
                      });
                    },
                    child: Text("Map"),
                  ),
                ),
              ],
            )),
      ],
    );

    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          usernameField,
          numField,
          emailField,
          passwordField,
          Divider(),
          addressField,
        ],
      ),
    );

    final registerButton = Material(
      borderRadius: BorderRadius.circular(20.0),
      shadowColor: Colors.greenAccent,
      color: Colors.blue,
      elevation: 7.0,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          'SIGN UP AS CUSTOMER',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat'),
        ),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            //register .. send data  to authservices
            dynamic result = await _auth.signUp(
              usernameController.text,
              numController.text,
              emailController.text,
              passwordController.text,
              addressController.text,
              latController.text,
              longController.text,
            );

            if (result != null) {
              showDialog(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("You've successfully registered"),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Thank You for registering with us'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OK'),
                        onPressed: () async {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AuthenticationWrapper(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('The email is invalid'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Use other email account'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          }
        },
      ),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        registerButton,
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Already have an account?",
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInPage()));
              },
              child: Text(
                "Sign In",
                style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(36),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                header,
                header2,
                fields,
                SizedBox(height: 40.0),
                Padding(
                  padding: EdgeInsets.only(bottom: 200),
                  child: bottom,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
    latController.text = pos.latitude.toString();
    longController.text = pos.longitude.toString();
    _address = addressController.text;
    lat = latController.text;
    long = longController.text;
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
