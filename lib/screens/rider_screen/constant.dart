import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
              left: 98,
              top: 164,
              child: SvgPicture.asset("assets/icon/Group 12.svg")),
          Positioned(
              left: 124,
              top: 192,
              child: SvgPicture.asset("assets/icon/Group 7.svg")),
          Positioned(
              left: 153.7,
              top: 251.5,
              child: SvgPicture.asset(
                "assets/icon/Group 8.svg",
                height: 54,
                width: 148,
              )),
          Positioned(
              left: 138,
              top: 257,
              child: SvgPicture.asset(
                "assets/icon/Group 9.svg",
                height: 40,
                width: 120,
              )),
          Positioned(
              left: 184,
              top: 81,
              child: SvgPicture.asset("assets/icon/Sandwich_100px.svg")),
          Positioned(
              left: 44.81,
              top: 128.06,
              child: SvgPicture.asset("assets/icon/Kawaii Soda_100px.svg")),
          Positioned(
              left: 297,
              top: 140,
              child: SvgPicture.asset("assets/icon/Salad_100px.svg")),
          Positioned(
              left: 34,
              top: 267,
              child: SvgPicture.asset("assets/icon/Cookie_100px.svg")),
          Positioned(
              left: 332,
              top: 267.02,
              child: SvgPicture.asset("assets/icon/Popcorn_100px.svg")),
          Positioned(
              left: 50,
              top: 505,
              child:
                  SvgPicture.asset("assets/icon/Kawaii Ice Cream_100px.svg")),
          Positioned(
              right: 30,
              top: 495,
              child: SvgPicture.asset(
                "assets/icon/Kawaii Pizza_100px.svg",
              )),
          Positioned(
              left: 29,
              top: 639,
              child: SvgPicture.asset("assets/icon/Steak Hot_100px.svg")),
          Positioned(
              left: 269,
              top: 692,
              child: SvgPicture.asset(
                  "assets/icon/Kawaii French Fries_100px.svg")),
          Positioned(
            left: 70,
            top: 389,
            child: Text(
              "Welcome to AnyRunit",
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
