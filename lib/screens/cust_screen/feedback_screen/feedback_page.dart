import 'package:anyrunit/custom_bottom_nav_bar.dart';
import 'package:anyrunit/enums.dart';
import 'package:anyrunit/screens/cust_screen/feedback_screen/feedback_tab.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FEEDBACK"),
      ),
      body: FeedbackTab(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.feedback),
    );
  }
}
