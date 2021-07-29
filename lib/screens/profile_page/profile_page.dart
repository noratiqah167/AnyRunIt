import 'package:anyrunit/custom_bottom_nav_bar.dart';
import 'package:anyrunit/enums.dart';
import 'package:anyrunit/screens/profile_page/profile_screen.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileView(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
