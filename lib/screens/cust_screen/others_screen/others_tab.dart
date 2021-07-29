import 'package:anyrunit/screens/cust_screen/order/menu.dart';
import 'package:anyrunit/screens/profile_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:anyrunit/constants/color_constant.dart';
import 'package:anyrunit/constants/style_constant.dart';
import 'package:anyrunit/models/others_model.dart';

class OthersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mBackgroundColor,

      // Setting up Custom Bottom Navigation Bar

      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios_outlined),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Text(
                    "OTHER NECESSITY",
                    style: TextStyle(fontSize: 40, fontFamily: "Samantha"),
                  ),
                  IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      })
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 24, bottom: 12),
              child: Text(
                'Choice In Your Hand!',
                style: mTitleStyle,
              ),
            ),
            Container(
              height: 181,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 16),
                itemCount: travlogs.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 16),
                    width: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage(travlogs[index].image),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: SvgPicture.asset(
                                  'assets/icon/travlog_bottom_gradient.svg'),
                            ),
                            Positioned(
                              bottom: 8,
                              left: 8,
                              child: Text(
                                '  ' + travlogs[index].name,
                                style: mTravlogTitleStyle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Menu(),
                        ),
                      );
                    },
                    child: Column(children: [
                      Text("WATSONS"),
                      Watsons(),
                      Text("MR DIY"),
                      Diy(),
                      Text("MY ONE SHOP"),
                      Myoneshop(),
                    ]))),
          ])),
    );
  }
}
