import 'package:anyrunit/screens/cust_screen/order/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OthersModel {
  String name;
  String content;
  String place;
  String image;

  OthersModel(
      this.name,
      // this.content, this.place,
      this.image);
}

List<OthersModel> travlogs = travlogsData
    .map((item) => OthersModel(item['name'], item['image']))
    .toList();

var travlogsData = [
  {"name": "\"WATSON!\"", "image": "assets/others_page/watson.png"},
  {"name": "\"Mr DIY!\"", "image": "assets/others_page/diy.png"},
  {"name": "\"MY ONE SHOP!\"", "image": "assets/others_page/myoneshop.jpg"},
];

class Watsons extends StatelessWidget {
  var watsonCollection = FirebaseFirestore.instance.collectionGroup('watsons');
  String pname;
  double amount;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200,
        child: StreamBuilder(
            stream: watsonCollection.snapshots(),
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

class Diy extends StatelessWidget {
  var diyCollection = FirebaseFirestore.instance.collectionGroup('diy');
  String pname;
  double amount;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200,
        child: StreamBuilder(
            stream: diyCollection.snapshots(),
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

class Myoneshop extends StatelessWidget {
  var oneshopCollection =
      FirebaseFirestore.instance.collectionGroup('myoneshop');
  String pname;
  double amount;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200,
        child: StreamBuilder(
            stream: oneshopCollection.snapshots(),
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
