import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:placementprep/screens/quiz_screens/Widgets/quiz_list.dart';
import 'package:placementprep/utils/colors.dart';

import '../sidebar/navigation_drawer.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: const NavigationDrawer(),
        body: Builder(builder: (context) {
          return DraggableHome(
            leading: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Align(
                  alignment: Alignment.center,
                  child: FaIcon(
                    FontAwesomeIcons.barsStaggered,
                    color: Colors.white,
                  )),
            ),
            title: const Text(
              "Aptitude",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 20),
            ),
            headerWidget: headerWidget(context),
            body: [
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Let's give a test !",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              QuizList(),
            ],
            fullyStretchable: false,
            backgroundColor: Colors.white,
            appBarColor: Colors.deepPurple[400],
          );
        }),
      ),
    );
  }
}

Widget headerWidget(BuildContext context) {
  return SafeArea(
    child: Container(
      color: kSecondaryBackgroundColor,
      // child: Center(
      //   child: Text(
      //     "Learn \nWith us",
      //     style: Theme.of(context)
      //         .textTheme
      //         .headline2!
      //         .copyWith(color: Colors.white70),
      //   ),
      // ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Check your skills..",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: kPrimaryBackgroundColor),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                child: SvgPicture.asset(
                  "assets/images/quiz.svg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
