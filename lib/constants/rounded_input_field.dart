import 'package:anyrunit/constants/input_container.dart';
import "package:flutter/material.dart";

class InputRound extends StatelessWidget {
  final IconData icon;
  final ValueChanged<String> onchanged;
  final ValueChanged<String> validator;
  final InputDecoration deco;
  final TextEditingController controller;
  final TextInputType keyboardType;
  const InputRound({
    Key key,
    this.icon,
    this.onchanged,
    this.validator,
    this.deco,
    this.controller,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextFormField(
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        keyboardType: keyboardType,
        controller: controller,
        cursorColor: Colors.blue,
        onChanged: onchanged,
        validator: validator,
        decoration: deco,
      ),
    );
  }
}
