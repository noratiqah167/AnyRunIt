import 'package:anyrunit/auth/authentication_service.dart';
import 'package:anyrunit/screens/cust_screen/order/checkout/cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  final String pname;
  final double lati;
  final double longi;
  final double amount;
  final String img;
  Menu({Key key, this.pname, this.amount, this.img, this.lati, this.longi})
      : super(key: key);
  @override
  _MenuState createState() =>
      _MenuState(this.pname, this.amount, this.img, this.lati, this.longi);
}

class _MenuState extends State<Menu> {
  final AuthenticationService _auth = AuthenticationService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String pname;
  String detail;
  double amount;
  String img;
  int itemNumber = 1;
  double lati;
  double longi;
  User user;
  _MenuState(this.pname, this.amount, this.img, this.lati, this.longi);

  void initState() {
    super.initState();
    initUser();
    _increase();
    _decrease();
  }

  void _increase() {
    setState(() {
      itemNumber++;
    });
  }

  void _decrease() {
    setState(() {
      if (itemNumber > 1) {
        itemNumber--;
      }
    });
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
    //print(user.uid);
  }

  void inputData() {
    final User user = auth.currentUser;
    final uid = user.uid;
    double subtotal = (amount * itemNumber);
    FirebaseFirestore.instance
        .collection('cart')
        .doc(uid)
        .collection('carts')
        .add({
      'Quantity': itemNumber,
      'Subtotal': subtotal,
      'Product Name': pname,
      'Product image': img,
    });
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = double.parse((amount * itemNumber).toStringAsFixed(2));
    print('Total Amount $subtotal');
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Container(
          child: ListView(
            children: [
              Container(
                height: height / 3,
                width: width,
                child: Stack(
                  children: [
                    Center(
                      child: Image.network('$img', fit: BoxFit.fill),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              color: Colors.black,
                              onPressed: () {
                                //back
                                Navigator.pop(context, false);
                              }),
                          Text(
                            'Menu Details',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "$pname",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      "RM $amount ",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.remove_circle),
                                        onPressed: () {
                                          _decrease();
                                        }),
                                    Text(
                                      "$itemNumber",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.add_circle),
                                        onPressed: () {
                                          _increase();
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Ratings:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.blue,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.blue,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.blue,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.blue,
                              ),
                              Icon(
                                Icons.star_half,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Subtotal : RM $subtotal",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 60.0,
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlineButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartWithItem(
                            amount: amount,
                            itemNumber: itemNumber,
                            pname: pname,
                            img: img,
                            lati: lati,
                            longi: longi,
                          ),
                        ),
                        (route) => true,
                      );
                    },
                    color: Colors.green,
                    highlightColor: Colors.amber,
                    child: Text(
                      "CHECKOUT",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                GestureDetector(
                  behavior: HitTestBehavior.deferToChild,
                  onTap: () {
                    inputData();
                    print('Add to cart');
                    showDialog(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Added to cart"),
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
                  },
                  child: Row(
                    children: [
                      Text(
                        "Add to Cart",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
