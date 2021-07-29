import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:anyrunit/screens/cust_screen/order/menu.dart';
import 'package:flutter/material.dart';

class GroceriesModel {
  String image;

  GroceriesModel(this.image);
}

List<GroceriesModel> carousels =
    carouselsData.map((item) => GroceriesModel(item['image'])).toList();

var carouselsData = [
  {"image": "assets/groceries_page/eco-slim-river-branch.jpg"},
  {"image": "assets/groceries_page/EconsaveLogo.png"},
  {"image": "assets/groceries_page/segi.jpg"},
  {"image": "assets/groceries_page/99.png"},
];

class Eco extends StatelessWidget {
  var ecoCollection = FirebaseFirestore.instance.collectionGroup('eco');
  String pname;
  double amount;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200,
        child: StreamBuilder(
            stream: ecoCollection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      DocumentSnapshot a = snapshot.data.docs[i];
                      return Container(
                          child: PageView(
                              scrollDirection: Axis.horizontal,
                              children: [
                            Container(
                              height: 200,
                              width: 500,
                              child: GestureDetector(
                                child: Image.network(
                                  a['image'],
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
                            ),
                          ]));
                    });
              }
            }));
  }
}

class Econsave extends StatelessWidget {
  var econsaveCollection =
      FirebaseFirestore.instance.collectionGroup('econsave');
  String pname;
  double amount;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200,
        child: StreamBuilder(
            stream: econsaveCollection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      DocumentSnapshot a = snapshot.data.docs[i];
                      return Container(
                          child: PageView(
                              scrollDirection: Axis.horizontal,
                              children: [
                            Container(
                              height: 200,
                              width: 500,
                              child: GestureDetector(
                                child: Image.network(
                                  a['image'],
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
                            ),
                          ]));
                    });
              }
            }));
  }
}

class Segi extends StatelessWidget {
  var segiCollection = FirebaseFirestore.instance.collectionGroup('segi');
  String pname;
  double amount;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200,
        child: StreamBuilder(
            stream: segiCollection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      DocumentSnapshot a = snapshot.data.docs[i];
                      return Container(
                          child: PageView(
                              scrollDirection: Axis.horizontal,
                              children: [
                            Container(
                              height: 200,
                              width: 500,
                              child: GestureDetector(
                                child: Image.network(
                                  a['image'],
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
                            ),
                          ]));
                    });
              }
            }));
  }
}

class S99 extends StatelessWidget {
  var s99Collection = FirebaseFirestore.instance.collectionGroup('s99');
  String pname;
  double amount;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200,
        child: StreamBuilder(
            stream: s99Collection.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      DocumentSnapshot a = snapshot.data.docs[i];
                      return Container(
                          child: PageView(
                              scrollDirection: Axis.horizontal,
                              children: [
                            Container(
                              height: 200,
                              width: 500,
                              child: GestureDetector(
                                child: Image.network(
                                  a['image'],
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
                            ),
                          ]));
                    });
              }
            }));
  }
}
