import 'package:anyrunit/constants/mybutton.dart';
import 'package:anyrunit/constants/mytextformField.dart';
import 'package:anyrunit/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Users user;
  TextEditingController usernameController;
  TextEditingController addressController;
  TextEditingController numController;
  TextEditingController latController;
  TextEditingController longController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  String userUid;

  void vaildation() async {
    if (usernameController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(" Name Is Empty "),
        ),
      );
    } else if (usernameController.text.length < 5) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(" Name Must Be 6 "),
        ),
      );
    } else if (numController.text.length < 10 ||
        numController.text.length > 11) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(" Phone number must be 10 or 11 digit "),
        ),
      );
    } else if (addressController.text.length < 5) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(" Address Must Be 5 character and above "),
        ),
      );
    } else if (latController.text.isEmpty || longController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(" Latitude and Longitude must in point number "),
        ),
      );
    } else {
      userDetailUpdate();
    }
  }

  void userDetailUpdate() async {
    FirebaseFirestore.instance.collection("Users").doc(userUid).update({
      "Name": usernameController.text,
      "Phone Number": numController.text,
      "Address": addressController.text
    });
    setState(() {
      edit = false;
    });
  }

  void getUserUid() {
    User myUser = FirebaseAuth.instance.currentUser;
    userUid = myUser.uid;
  }

  bool edit = false;

  Widget _buildSingleContainer(
      {Color color, String startText, String endText}) {
    return Card(
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: edit == true ? color : Colors.white,
          borderRadius: edit == false
              ? BorderRadius.circular(30)
              : BorderRadius.circular(0),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startText,
              style: TextStyle(fontSize: 17, color: Colors.black45),
            ),
            Expanded(
              child: Text(
                endText,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //view
  Widget _buildContainerPart() {
    usernameController = TextEditingController(text: user.name);
    addressController = TextEditingController(text: user.address);
    numController = TextEditingController(text: user.phoneNum);
    latController = TextEditingController(text: (user.latt).toString());
    longController = TextEditingController(text: (user.longg).toString());

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSingleContainer(
            endText: user.name,
            startText: "Name",
          ),
          _buildSingleContainer(
            endText: user.phoneNum,
            startText: "Number",
          ),
          _buildSingleContainer(
            endText: user.email,
            startText: "Email",
          ),
          _buildSingleContainer(
            endText: user.address,
            startText: "Address",
          ),
          _buildSingleContainer(
            endText: user.latt + "," + user.longg,
            startText: "Lat & Long",
          ),
        ],
      ),
    );
  }

  //edit
  Widget _buildTextFormFliedPart() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyTextFormField(
            name: "UserName",
            controller: usernameController,
          ),
          MyTextFormField(
            name: "Number",
            controller: numController,
          ),
          _buildSingleContainer(
            color: Colors.grey[300],
            endText: user.email,
            startText: "Email",
          ),
          MyTextFormField(
            name: "Address",
            controller: addressController,
          ),
          MyTextFormField(
            name: "Lat",
            controller: latController,
          ),
          MyTextFormField(
            name: "Long",
            controller: longController,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getUserUid();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        key: _scaffoldKey,
        backgroundColor: Color(0xfff8f8f8),
        appBar: AppBar(
          title: Text("PROFILE DETAIL"),
          leading: edit == true
              ? IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.redAccent,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      edit = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black45,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                ),
          backgroundColor: Colors.white,
          actions: [
            edit == false
                ? IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                  )
                : IconButton(
                    icon: Icon(
                      Icons.check,
                      size: 30,
                      color: Color(0xff746bc9),
                    ),
                    onPressed: () {
                      vaildation();
                    },
                  ),
          ],
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("Users").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var myDoc = snapshot.data.docs;
                  myDoc.forEach((checkDocs) {
                    if (checkDocs.data()["UserId"] == userUid) {
                      user = Users(
                        name: checkDocs.data()["Name"],
                        phoneNum: checkDocs.data()["Phone Number"],
                        email: checkDocs.data()["Email"],
                        password: checkDocs.data()["Password"],
                        address: checkDocs.data()["Address"],
                        latt: checkDocs.data()["Latt"],
                        longg: checkDocs.data()["Longg"],
                      );
                    }
                  });
                  return Container(
                    height: 603,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          children: [
                            edit == true ? Text("EDIT PROFILE") : Container(),
                          ],
                        ),
                        Container(
                          height: 500,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  child: edit == true
                                      ? _buildTextFormFliedPart()
                                      : _buildContainerPart(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: edit == false
                                ? MyButton(
                                    name: "Edit Profile",
                                    onPressed: () {
                                      setState(() {
                                        edit = true;
                                      });
                                    },
                                  )
                                : Container(),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ));
  }
}
