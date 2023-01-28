import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:placementprep/screens/login_screens/login_screen.dart';
import 'package:placementprep/utils/colors.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  Widget ic = const Icon(
    Icons.keyboard_backspace_sharp,
    color: kPrimaryBackgroundColor,
    size: 30,
  );
  final pages = [
    Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Center(
              child: Image.asset(
                "assets/images/1.gif",
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "A learning app \nfor college students",
                    style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF3A342D),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Divider(color: Colors.black38),
                  Text(
                    "Covers Logical Reasoning and \nQuantitative Aptitude.",
                    style: TextStyle(
                        color: Color(0xFFA1B6CC),
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
    Builder(builder: (context) {
      return Container(
        color: Color.fromRGBO(20, 20, 20, 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Center(
                child: Image.asset(
                  "assets/images/2.png",
                  width: MediaQuery.of(context).size.width * 0.88,
                  fit: BoxFit.cover,
                  //width: 400.0,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Learn from Topic-wise Videos",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Divider(color: Colors.black38),
                    Text(
                      "Grasp concepts easily and \nbecome a happy learner!",
                      style: TextStyle(
                          color: Color(0xFFA1B6CC),
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }),
    LoginScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LiquidSwipe(
          pages: pages,
          onPageChangeCallback: pageChangeCallback,
          slideIconWidget: ic,
          positionSlideIcon: 0.7,
          enableLoop: false,
          fullTransitionValue: 600,
          enableSideReveal: true,
          waveType: WaveType.liquidReveal,
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      if (lpage == pages.length - 1) {
        ic = Container();
      } else {
        ic = Icon(
          Icons.keyboard_backspace_sharp,
          color: kPrimaryBackgroundColor,
          size: 30,
        );
      }
    });
  }
}
