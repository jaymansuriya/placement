import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:placementprep/screens/navpages/practice_page.dart';
import 'package:placementprep/screens/navpages/quiz_page.dart';
import 'package:placementprep/screens/navpages/study_material_page.dart';
import 'package:placementprep/screens/videos_screens/home_video_page.dart';
import 'package:placementprep/utils/colors.dart';

class RoutePage extends StatefulWidget {
  final int currentIndex;
  const RoutePage({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  late int currentIndex = widget.currentIndex;
  List<Widget> pages = [
    VideoPage(),
    StudyMaterialPage(),
    PracticePage(),
    QuizPage(),
  ];
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: CustomNavigationBar(
          iconSize: 30.0,
          selectedColor: kPrimaryBackgroundColor,
          strokeColor: Color(0x30040307),
          unSelectedColor: Color(0xffacacac),
          backgroundColor: Colors.white,
          borderRadius: Radius.circular(20.0),
          items: [
            CustomNavigationBarItem(
              icon: Icon(CupertinoIcons.play_circle_fill),
              title: Text(
                "Let's Study",
                style: TextStyle(fontSize: 10),
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(CupertinoIcons.book_fill),
              title: Text(
                "Material",
                style: TextStyle(fontSize: 10),
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(Icons.flash_on_rounded),
              title: Text(
                "Practice",
                style: TextStyle(fontSize: 10),
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(CupertinoIcons.textformat_abc),
              title: Text(
                "Quiz",
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
