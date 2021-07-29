import 'package:anyrunit/screens/cust_screen/order/cart.dart';
import 'package:anyrunit/screens/cust_screen/order/checkout/checkout.dart';
import 'package:anyrunit/screens/cust_screen/home_screen/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartWithItem extends StatefulWidget {
  final String pname;
  final double amount;
  final int itemNumber;
  final double lati;
  final double longi;
  final String img;
  CartWithItem(
      {Key key,
      this.amount,
      this.itemNumber,
      this.pname,
      this.img,
      this.lati,
      this.longi})
      : super(key: key);
  @override
  _CartWithItemState createState() => _CartWithItemState(this.amount,
      this.itemNumber, this.pname, this.img, this.lati, this.longi);
}

class _CartWithItemState extends State<CartWithItem> {
  String pname;
  double amount;
  int itemNumber;
  double lati;
  double longi;
  final String img;
  _CartWithItemState(this.amount, this.itemNumber, this.pname, this.img,
      this.lati, this.longi);

  void _increase() {
    setState(() {
      itemNumber++;
    });
  }

  void _decrease() {
    setState(() {
      if (itemNumber > 0) {
        itemNumber--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    double subtotal = double.parse((amount * itemNumber).toStringAsFixed(2));
    double charge = double.parse((subtotal * 0.2).toStringAsFixed(2));
    double total = double.parse((subtotal + charge).toStringAsFixed(2));
    print('Total Amount $subtotal');
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: Align(
          alignment: Alignment.center,
          child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context, false);
              }),
        ),
        title: Center(
          child: Text(
            'Order Summary',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 10),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: Offset(2, 2),
                  )
                ]),
                alignment: Alignment.center,
                width: width,
                height: 100.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            "$img",
                            width: 180.00,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$pname",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              Text(
                                "RM $amount",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.add,
                              color: Colors.blue,
                            ),
                            onTap: () {
                              _increase();
                            },
                          ),
                          Text(
                            "$itemNumber",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.remove,
                              color: Colors.blue,
                            ),
                            onTap: () {
                              _decrease();
                              if (itemNumber == 0)
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Cart(
                                            uid: '',
                                          )),
                                  // context,
                                  // MaterialPageRoute(
                                  //     builder: (context) => CartView()),
                                );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              //summary
              Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Summary",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //harga barang
                            Text("Subtotal"),
                            Text("RM $subtotal"),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        //upah
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Charge"),
                            Text("RM $charge"),
                          ],
                        ),
                        // SizedBox(
                        //   height: 10.0,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text("Shipping"),
                        //     Text("Free"),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10.0,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text("Have a coupn"),
                        //     GestureDetector(
                        //         onTap: () {
                        //           print("Add Cupon");
                        //         },
                        //         child: Text(
                        //           "ADD",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.blue),
                        //         )),
                        //   ],
                        // ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Divider(
                          color: Colors.black26,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Total ",
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
                                        fontSize: 15.0, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            //total cust bayar
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
                          minWidth: 200.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          child: RaisedButton(
                            elevation: 5.0,
                            hoverColor: Colors.green,
                            color: Colors.blue,
                            child: Text(
                              "CHECKOUT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              FutureBuilder<User>(
                                initialData: FirebaseAuth.instance.currentUser,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    User user = snapshot.data;
                                    return CheckOut(uid: user.uid);
                                  } else
                                    return null;
                                },
                              );

                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => FutureBuilder<User>(
                                      initialData:
                                          FirebaseAuth.instance.currentUser,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          User user = snapshot.data;
                                          return CheckOut(
                                            price: amount,
                                            uid: user.uid,
                                            itemNumber: itemNumber,
                                            total: total,
                                            pname: pname,
                                            img: img,
                                            charge: charge,
                                            subtotal: subtotal,
                                            lati: lati,
                                            longi: longi,
                                          );
                                        } else
                                          return null;
                                      },
                                    ),
                                  ),
                                  (Route<dynamic> route) => true);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ButtonTheme(
                          height: 50.0,
                          minWidth: 200.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          child: RaisedButton(
                            elevation: 5.0,
                            hoverColor: Colors.green,
                            color: Colors.blue,
                            child: Text(
                              "HOME",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                                (route) => false,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
