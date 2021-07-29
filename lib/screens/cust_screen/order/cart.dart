import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final String uid;

  Cart({Key key, @required this.uid}) : super(key: key);

  @override
  _CartState createState() => _CartState(uid);
}

class _CartState extends State<Cart> {
  var cartCollection = FirebaseFirestore.instance.collection('cart');
  final String uid;
  _CartState(this.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Align(
            alignment: Alignment.center,
            child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.blue,
                onPressed: () {
                  //back
                  Navigator.pop(context, false);
                }),
          ),
          title: Center(
            child: Text(
              'YOUR CART',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue),
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: cartCollection.doc(uid).collection('carts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.network(ds['Product image'].toString()),
                      title: Text(
                        ds['Product Name'].toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        "RM " +
                            ds['Subtotal'].toString() +
                            "  (" +
                            ds['Quantity'].toString() +
                            ")",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red[600],
                          ),
                          onPressed: () {
                            showDialog(
                                builder: (context) => new AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        title: new Text(
                                          'Delete from your cart?',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Yes"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              cartCollection
                                                  .doc(uid)
                                                  .collection('carts')
                                                  .doc(ds.id)
                                                  .delete();
                                              print('Delete cart');
                                              showDialog(
                                                context: context,
                                                barrierDismissible:
                                                    false, // user must tap button!
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        "A cart is deleted"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text('OK'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          TextButton(
                                              child: Text("No"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              }),
                                        ]),
                                context: context);
                          }),
                      onLongPress: () {
                        showDialog(
                            builder: (context) => new AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    title: new Text(
                                      'Delete from your cart?',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("Yes"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          cartCollection
                                              .doc(uid)
                                              .collection('carts')
                                              .doc(ds.id)
                                              .delete();
                                          print('Delete cart');
                                          showDialog(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title:
                                                    Text("A cart is deleted"),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('OK'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      TextButton(
                                          child: Text("No"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          }),
                                    ]),
                            context: context);
                      },
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return CircularProgressIndicator();
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
