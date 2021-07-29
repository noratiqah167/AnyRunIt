import 'package:anyrunit/custom_bottom_nav_bar.dart';
import 'package:anyrunit/enums.dart';
import 'package:flutter/material.dart';
import 'home_tab.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeTab(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
