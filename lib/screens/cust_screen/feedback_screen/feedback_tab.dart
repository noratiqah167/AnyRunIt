import 'package:anyrunit/screens/cust_screen/home_screen/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' as intl;

class FeedbackTab extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController t1 = TextEditingController();
  String message;
  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLMail() async {
    const url =
        'mailto:noratiqahabdullah167@gmail.com?subject=AnyRunItApp&body=Your sugestions%20or Feedback..';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void inputFeedback() {
    DateTime now = new DateTime.now();
    String date = intl.DateFormat('dd-MM-yyyy hh:mm a').format(now);
    final User user = auth.currentUser;
    final uid = user.uid;

    FirebaseFirestore.instance
        .collection('Feedback')
        .doc(uid)
        .collection('feedbacks')
        .add({
      'UserId': uid,
      'Date': date,
      'Time': DateTime.now(),
      'Feedback': message,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 13),
            child: Text(
              "Leave us a message, and we'll get in contact with you as soon as possible. ",
              style: TextStyle(
                fontSize: 17.5,
                height: 1.3,
                fontFamily: 'RobotoSlab',
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: (val) {
                if (val != null || val.length > 0) message = val;
              },
              textAlign: TextAlign.start,
              controller: t1,
              decoration: InputDecoration(
                fillColor: Color(0xffe6e6e6),
                filled: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                hintText: 'Your message',
                hintStyle: TextStyle(
                  color: Colors.blueGrey,
                  fontFamily: 'RobotoSlab',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(17),
                  ),
                  borderSide: BorderSide(color: Colors.grey[400]),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(17),
                  ),
                  borderSide: BorderSide(color: Colors.grey[400]),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(17),
                  ),
                  borderSide: BorderSide(color: Colors.grey[400]),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Card(
            color: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
              onTap: () {
                t1.clear();
                inputFeedback();
                showDialog(
                    builder: (context) => new AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            title: new Text(
                              'THANK YOU FOR YOUR FEEDBACK',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                },
                                // onPressed: () {
                                //   Navigator.pop(context);
                                // }
                              ),
                            ]),
                    context: context);
              },
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: Icon(
                      Icons.send,
                      color: Colors.white,
                    )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    // Emoji(),
                    Center(
                        child: Text(
                      "Send",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'RobotoSlab'),
                    )),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
                left: 21,
                right: 21,
                bottom: MediaQuery.of(context).size.height * 0.034),
            child: Text(
              "Alternatively, you can also report bugs and errors on following platforms",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'RobotoSlab',
                color: Colors.blueGrey[600],
                fontSize: 17,
                height: 1.3,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => launchUrl("https://github.com/noratiqah167"),
                child: Icon(
                  FontAwesomeIcons.github,
                  color: Colors.black,
                  size: 35,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.06,
              ),
              GestureDetector(
                onTap: () => launchUrl("https://wa.me/60135355720"),
                child: Icon(FontAwesomeIcons.whatsapp,
                    color: Colors.green, size: 35),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.06,
              ),
              GestureDetector(
                onTap: () => _launchURLMail(),
                child: Icon(FontAwesomeIcons.at,
                    color: Color(0xff1DA1F2), size: 35),
              ),
            ],
          ),
          SizedBox(height: 150.0),
        ],
      ),
    ));
  }
}
