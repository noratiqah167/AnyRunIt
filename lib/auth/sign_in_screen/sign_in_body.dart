import 'package:anyrunit/auth/authentication_service.dart';
import 'package:anyrunit/auth/sign_up_screen/rider_sign_up.dart';
import 'package:anyrunit/constants/rounded_input_field.dart';
import 'package:anyrunit/constants/rounded_password_field.dart';
import 'package:anyrunit/auth/sign_up_screen/sign_up_body.dart';
import 'package:anyrunit/constants/style_constant.dart';
import 'package:anyrunit/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignInBody extends StatefulWidget {
  final Function toggleView;
  SignInBody({this.toggleView});

  @override
  _SignInBodyState createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
        fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.blueAccent);
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(13.0, 60.0, 0.0, 0.0),
                        child: Text('Welcome To',
                            style: TextStyle(
                                fontSize: 50.0, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(14.0, 105.0, 0.0, 0.0),
                        child: Text('AnyRunIt',
                            style: TextStyle(
                                fontSize: 70.0, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(310.0, 98.0, 0.0, 0.0),
                        child: Text('.', style: textStyle),
                      )
                    ],
                  ),
                ),
                Container(
                    padding:
                        EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              InputRound(
                                controller: emailController,
                                deco: InputDecoration(
                                    icon: Icon(
                                      Icons.email,
                                      color: kPrimaryColor,
                                    ),
                                    hintText: "abc@gmail.com",
                                    labelText: 'EMAIL',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey),
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green))),
                              ),
                              SizedBox(height: 20.0),
                              InputPasswordRound(
                                controller: passwordController,
                              ),
                              SizedBox(height: 5.0),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Container(
                          height: 40.0,
                          child: Material(
                            shadowColor: Colors.greenAccent,
                            color: Colors.blue,
                            elevation: 7.0,
                            child: MaterialButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  dynamic result = await _auth.signIn(
                                      emailController.text,
                                      passwordController.text);
                                  if (result == null) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Invalid email/password'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(
                                                    'Email or password is not match'),
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
                                  } else if (result != null) {
                                    var document = await FirebaseFirestore
                                        .instance
                                        .collection('Users')
                                        .doc(result.id)
                                        .get();

                                    if (document != null) {
                                      String role =
                                          document.get('Role').toString();
                                      print(role);
                                      if (role == 'User') {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                AuthenticationWrapper(),
                                          ),
                                          (route) => false,
                                        );
                                      } else if (role == 'Rider') {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                RiderWrapper(),
                                          ),
                                          (route) => false,
                                        );
                                      }

                                      print("Successfully login " + result.id);
                                    }
                                  }
                                }
                              },
                              child: Center(
                                child: Text(
                                  'SIGN IN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    )),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'New User of AnyRunIt ?',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpBody()));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.green,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Register as a Rider ?',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RiderSignUp()));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.green,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
              ],
            )));
  }
}
