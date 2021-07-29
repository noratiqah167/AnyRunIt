import 'package:anyrunit/screens/cust_screen/order/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class sr extends StatelessWidget {
  var srCollection = FirebaseFirestore.instance.collectionGroup('sr');
  String pname;
  double amount;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: screenHeight / 4,
        width: screenWidth,
        child: StreamBuilder(
            stream: srCollection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      DocumentSnapshot a = snapshot.data.docs[i];
                      return Container(
                        // height: screenHeight / 5,
                        // width: screenWidth/5,
                        height: 200,
                        width: 500,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 2.0,
                                  blurRadius: 5.0),
                            ]),
                        margin: EdgeInsets.all(5.0),
                        child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: [
                              Row(mainAxisSize: MainAxisSize.max, children: [
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  child: Image.network(
                                    a['image'],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Menu(
                                                pname: a['name'],
                                                amount: a['price'],
                                                img: a['image'].toString(),
                                                lati: a['Lati'],
                                                longi: a['Longi'],
                                              )),
                                    );
                                  },
                                ),
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(a["name"]),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0, bottom: 2.0),
                                          child: Text(
                                            "Price per item: ${a["price"].toString()}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                            ]),
                      );
                    });
              }
            }));
  }
}

class tealive extends StatelessWidget {
  var tealiveCollection = FirebaseFirestore.instance.collectionGroup('tealive');
  String pname;
  double amount;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: screenHeight / 4,
        width: screenWidth,
        child: StreamBuilder(
            stream: tealiveCollection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      DocumentSnapshot a = snapshot.data.docs[i];
                      return Container(
                        height: 300,
                        width: 500,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 2.0,
                                  blurRadius: 5.0),
                            ]),
                        margin: EdgeInsets.all(5.0),
                        child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: [
                              Row(mainAxisSize: MainAxisSize.max, children: [
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  child: Image.network(
                                    a['image'],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Menu(
                                                pname: a['name'],
                                                amount: a['price'],
                                                img: a['image'].toString(),
                                                lati: a['Lati'],
                                                longi: a['Longi'],
                                              )),
                                    );
                                  },
                                ),
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(a["name"]),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0, bottom: 2.0),
                                          child: Text(
                                            "Price per item: ${a["price"].toString()}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                            ]),
                      );
                    });
              }
            }));
  }
}

class kfc extends StatelessWidget {
  var kfcCollection = FirebaseFirestore.instance.collectionGroup('kfc');
  String pname;
  double amount;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: screenHeight / 4,
        width: screenWidth,
        child: StreamBuilder(
            stream: kfcCollection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      DocumentSnapshot a = snapshot.data.docs[i];
                      return Container(
                        height: 200,
                        width: 500,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 2.0,
                                  blurRadius: 5.0),
                            ]),
                        margin: EdgeInsets.all(5.0),
                        child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: [
                              Row(mainAxisSize: MainAxisSize.max, children: [
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  child: Image.network(
                                    a['image'],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Menu(
                                                pname: a['name'],
                                                amount: a['price'],
                                                img: a['image'].toString(),
                                                lati: a['Lati'],
                                                longi: a['Longi'],
                                              )),
                                    );
                                  },
                                ),
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(a["name"]),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0, bottom: 2.0),
                                          child: Text(
                                            "Price per item: ${a["price"].toString()}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                            ]),
                      );
                    });
              }
            }));
  }
}

class mb extends StatelessWidget {
  var mbCollection = FirebaseFirestore.instance.collectionGroup('mb');
  String pname;
  double amount;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: screenHeight / 4,
        width: screenWidth,
        child: StreamBuilder(
            stream: mbCollection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      DocumentSnapshot a = snapshot.data.docs[i];
                      return Container(
                        height: 200,
                        width: 500,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 2.0,
                                  blurRadius: 5.0),
                            ]),
                        margin: EdgeInsets.all(5.0),
                        child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: [
                              Row(mainAxisSize: MainAxisSize.max, children: [
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  child: Image.network(
                                    a['image'],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Menu(
                                                pname: a['name'],
                                                amount: a['price'],
                                                img: a['image'].toString(),
                                                lati: a['Lati'],
                                                longi: a['Longi'],
                                              )),
                                    );
                                  },
                                ),
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(a["name"]),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0, bottom: 2.0),
                                          child: Text(
                                            "Price per item: ${a["price"].toString()}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                            ]),
                      );
                    });
              }
            }));
  }
}
