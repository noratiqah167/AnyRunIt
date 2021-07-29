import 'package:anyrunit/auth/authentication_service.dart';
import 'package:anyrunit/auth/sign_in_screen/sign_in_page.dart';
import 'package:anyrunit/models/chome_model.dart';
import 'package:anyrunit/screens/cust_screen/f&b_screen/f&b_page.dart';
import 'package:anyrunit/screens/cust_screen/order/cart.dart';
import 'package:anyrunit/screens/cust_screen/groceries_screen/groceries_page.dart';
import 'package:anyrunit/screens/cust_screen/others_screen/others_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeTab extends StatefulWidget {
  final appTitle = "AnyRunIt Project";

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String uid;
  String email;
  User user;
  // Future<User> _user = FirebaseAuth.instance.currentUser();
  User _user = FirebaseAuth.instance.currentUser;
  final AuthenticationService _auth = AuthenticationService();

  int _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
                text: "AnyRunIt",
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: " Project",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black))
                ]),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add_shopping_cart),
              color: Colors.black,
              onPressed: () {
                //panggil dari db depends on currwenrt user
                FutureBuilder<User>(
                  initialData: FirebaseAuth.instance.currentUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      User user = snapshot.data;
                      return Cart(uid: user.uid);
                    } else
                      return null;
                  },
                );
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => FutureBuilder<User>(
                        initialData: FirebaseAuth.instance.currentUser,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            User user = snapshot.data;
                            return Cart(uid: user.uid);
                          } else
                            return null;
                        },
                      ),
                    ),
                    (Route<dynamic> route) => true);
              },
            ),
            IconButton(
                onPressed: () async {
                  {
                    //register .. send data  to authservices
                    dynamic result = await _auth.signOut();

                    if (result == null) {
                      showDialog(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Sucessfully Logout"),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('Please login!'),
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
                                          SignInPage(),
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
                            title: Text('Fail to logout'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('Something happen'),
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
                icon: Icon(
                  Icons.logout_outlined,
                  color: Colors.black,
                )),
          ],
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  height: 250,
                  width: 600,
                  child: Swiper(
                    onIndexChanged: (index) {
                      {
                        _current = index;
                      }
                      ;
                    },
                    autoplay: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: AssetImage(
                                listavailable[index].image,
                              ),
                              fit: BoxFit.cover),
                        ),
                      );
                    },
                    itemCount: listavailable.length,
                    viewportFraction: 1,
                    scale: 0.9,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "LIST SERVICE BY AnyRuNIt",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: Text('FOOD & BEVERAGE'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FnbPage()));
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  child: Text('GROCERIES'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GroceriesPage()));
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  child: Text('OTHERS NECCESSITY'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OthersPage()));
                  },
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ));
  }
}
