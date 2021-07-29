import 'package:anyrunit/screens/cust_screen/feedback_screen/feedback_page.dart';
import 'package:anyrunit/screens/cust_screen/home_screen/home_page.dart';
import 'package:anyrunit/screens/profile_page/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(0.5),
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icon/home.svg",
                  color: MenuState.home == selectedMenu
                      ? Colors.black
                      : inActiveIconColor,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.people_alt_outlined,
                  color: MenuState.profile == selectedMenu
                      ? Colors.pink
                      : inActiveIconColor,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileView()));
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icon/feedback.svg",
                  color: MenuState.feedback == selectedMenu
                      ? Colors.blue
                      : inActiveIconColor,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FeedbackPage()));
                },
              ),
            ],
          )),
    );
  }
}
