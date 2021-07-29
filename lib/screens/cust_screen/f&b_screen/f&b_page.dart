import 'package:anyrunit/screens/cust_screen/f&b_screen/f&b_tab.dart';
import 'package:anyrunit/screens/profile_page/profile_page.dart';
import 'package:flutter/material.dart';

class FnbPage extends StatefulWidget {
  @override
  _FnbPageState createState() => _FnbPageState();
}

class _FnbPageState extends State<FnbPage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  "FOOD & BEVERAGE",
                  style: TextStyle(fontSize: 50, fontFamily: "Samantha"),
                ),
                IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                    }),
              ],
            ),
          ),
          BannerWidgetArea(),
          Container(
            color: Colors.blue,
            child: Column(children: [
              SizedBox(height: 20),
              Text("MOST POPULAR FOR SECRET RECIPE"),
              sr(),
              Text("MOST POPULAR FOR TEALIVE"),
              tealive(),
              Text("MOST POPULAR FOR KFC"),
              kfc(),
              Text("MOST POPULAR FOR MARRY BROWN"),
              mb(),

              // List<>,
            ]),
          )
        ],
      ),
    ));
  }
}

var bannerItems = ["Secret Recipe", "Tealive", "KFC", "Marrybrown"];
var bannerImage = [
  "assets/f&b_page/sr.jpg",
  "assets/f&b_page/tealive.jpg",
  "assets/f&b_page/kfc.jpg",
  "assets/f&b_page/mb.png"
];

class BannerWidgetArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    PageController controller =
        PageController(viewportFraction: 0.8, initialPage: 1);

    List<Widget> banners = new List<Widget>();

    for (int x = 0; x < bannerItems.length; x++) {
      var bannerView = Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 5.0,
                          spreadRadius: 1.0)
                    ]),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: Image.asset(
                  bannerImage[x],
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black])),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      bannerItems[x],
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                    Text(
                      "Just for view",
                      style: TextStyle(fontSize: 12.0, color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
      banners.add(bannerView);
    }

    return Container(
      width: screenWidth,
      height: screenWidth * 9 / 16,
      child: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: banners,
      ),
    );
  }
}
