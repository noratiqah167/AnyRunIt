import 'package:anyrunit/auth/authentication_service.dart';
import 'package:anyrunit/auth/sign_in_screen/sign_in_page.dart';
import 'package:anyrunit/screens/cust_screen/home_screen/home_page.dart';
import 'package:anyrunit/screens/profile_page/profile_screen.dart';
import 'package:anyrunit/screens/rider_screen/constant.dart';
import 'package:anyrunit/screens/rider_screen/orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RHomeTab extends StatefulWidget {
  RHomeTab({Key key}) : super(key: key);

  @override
  _RHomeTabState createState() => _RHomeTabState();
}

class _RHomeTabState extends State<RHomeTab> {
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
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
                SizedBox(height: 10.0),
                FloatingActionButton.extended(
                    backgroundColor: Colors.amber,
                    focusColor: Colors.black,
                    icon: Icon(Icons.padding_outlined),
                    label: Text("CHANGE TO CUSTOMER"),
                    tooltip: 'Show Snackbar',
                    onPressed: () async {
                      {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => HomePage(),
                          ),
                          (route) => false,
                        );
                      }
                    }),
                SizedBox(height: 10.0),
                FloatingActionButton.extended(
                  backgroundColor: Colors.amber,
                  focusColor: Colors.black,
                  heroTag: "logoutbtn",
                  icon: Icon(Icons.logout),
                  label: Text("SIGN OUT"),
                  tooltip: 'Show Snackbar',
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
                ),
              ],
            ),
          ),
        ),
        body: Container(child: Center(child: Logo())));
  }
}
