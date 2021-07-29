import 'package:anyrunit/constants/style_constant.dart';
import 'package:flutter/material.dart';

class InputPasswordRound extends StatefulWidget {
  final ValueChanged<String> onchanged;
  final ValueChanged<String> deco;
  final TextEditingController controller;
  final ValueChanged<String> validator;

  const InputPasswordRound({
    this.validator,
    this.onchanged,
    this.deco,
    this.controller,
    Key key,
  }) : super(key: key);

  @override
  _InputPasswordRoundState createState() => _InputPasswordRoundState();
}

class _InputPasswordRoundState extends State<InputPasswordRound> {
  bool hide = true;
  IconData icon = Icons.visibility_off;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 9,
              spreadRadius: 1,
            )
          ]),
      child: TextFormField(
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        onChanged: widget.onchanged,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: hide,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          hintText: "xxxxxxxx",
          labelText: 'PASSWORD',
          labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                hide = !hide;
                if (icon == Icons.visibility) {
                  icon = Icons.visibility_off;
                } else {
                  icon = Icons.visibility;
                }
              });
            },
            child: Icon(
              icon,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

// TextField(
//                       controller: passwordController,
//                       decoration: InputDecoration(
//                           labelText: 'PASSWORD',
//                           labelStyle: TextStyle(
//                               fontFamily: 'Montserrat',
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blueGrey),
//                           focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.green))),
//                       obscureText: true,
//                     ),