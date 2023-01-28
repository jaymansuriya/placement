import 'dart:convert';

import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:placementprep/main.dart';
import 'package:placementprep/models/courses/Course.dart';
import 'package:placementprep/resources/auth_methods.dart';
import 'package:placementprep/screens/sidebar/navigation_drawer.dart';
import 'package:placementprep/screens/videos_screens/Widgets/recommended_videos.dart';
import 'package:placementprep/screens/videos_screens/video_list.dart';
import 'package:placementprep/utils/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'Widgets/lodingWidget.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: const NavigationDrawer(),
        body: FutureBuilder(
            future: getCourseApi(),
            builder: (context, snapshot) {
              {
                return DraggableHome(
                  leading: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.barsStaggered,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    "Aptitude",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  headerWidget: headerWidget(context),
                  body: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: GradientText(
                                    'Learn',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    gradientType: GradientType.radial,
                                    gradientDirection: GradientDirection.ttb,
                                    radius: 3,
                                    colors: [
                                      Color(0xff159DFF),
                                      Color(0xff002981),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  " with Video Classes",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          FutureBuilder(
                              future: getCourseApi(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(child: LodingWidget());
                                } else {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const VideoList(
                                                title: "Reasoning",
                                                courseID: '1',
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 20.0,
                                            vertical: 20.0 / 2,
                                          ),
                                          // color: Colors.blueAccent,
                                          height: 160,
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: <Widget>[
                                              // Those are our background
                                              Container(
                                                height: 156,
                                                margin:
                                                    EdgeInsets.only(top: 28),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  color:
                                                      kPrimaryBackgroundColor,
                                                ),
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            22),
                                                  ),
                                                ),
                                              ),
                                              // our product image
                                              Positioned(
                                                top: -12,
                                                right: -2,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  height: 160,
                                                  // image is square but we add extra 20 + 20 padding thats why width is 200
                                                  width: 200,
                                                  child: Image.network(
                                                    courseList[0]
                                                        .courseImage
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              // Product title and price
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: SizedBox(
                                                  height: 136,
                                                  // our image take 200 width, thats why we set out total width - 200
                                                  width: size.width - 220,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Spacer(),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20),
                                                        child: Text(
                                                          courseList[0]
                                                              .courseName
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                      // it use the available space
                                                      Spacer(),
                                                      Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                20 * 1.5,
                                                            // 30 padding
                                                            vertical: 20 /
                                                                4, // 5 top and bottom
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                kSecondaryBackgroundColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(22),
                                                              topRight: Radius
                                                                  .circular(22),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            "Topics : " +
                                                                courseList[0]
                                                                    .topics
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => VideoList(
                                                title: "Quantitative Aptitude",
                                                courseID: '2',
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 20.0,
                                            vertical: 20.0 / 2,
                                          ),
                                          // color: Colors.blueAccent,
                                          height: 160,
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: <Widget>[
                                              // Those are our background
                                              Container(
                                                height: 156,
                                                margin:
                                                    EdgeInsets.only(top: 28),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  color:
                                                      kPrimaryBackgroundColor,
                                                ),
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            22),
                                                  ),
                                                ),
                                              ),
                                              // our product image
                                              Positioned(
                                                top: -20,
                                                right: -2,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  height: 160,
                                                  // image is square but we add extra 20 + 20 padding thats why width is 200
                                                  width: 200,
                                                  child: Image.network(
                                                    courseList[1]
                                                        .courseImage
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              // Product title and price
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: SizedBox(
                                                  height: 136,
                                                  // our image take 200 width, thats why we set out total width - 200
                                                  width: size.width - 205,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Spacer(),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20),
                                                        child: Text(
                                                          courseList[1]
                                                              .courseName
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                      // it use the available space
                                                      Spacer(),
                                                      Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                20 * 1.5,
                                                            // 30 padding
                                                            vertical: 20 /
                                                                4, // 5 top and bottom
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                kSecondaryBackgroundColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(22),
                                                              topRight: Radius
                                                                  .circular(22),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            "Topics : " +
                                                                courseList[1]
                                                                    .topics
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              })
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: WidgetAnimator(
                              atRestEffect: WidgetRestingEffects.wave(),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Recommended Learning",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          RecommendedVideos(),
                        ],
                      ),
                    ),
                  ],
                  fullyStretchable: false,
                  backgroundColor: Colors.white,
                  appBarColor: Colors.deepPurple[400],
                );
              }
            }),
      ),
    );
  }

  List<Course> courseList = [];

  Future<List<Course>> getCourseApi() async {
    final response = await http.get(Uri.parse('${apiURL}courses'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      courseList.clear();
      for (Map i in data) {
        courseList.add(Course.fromJson(i));
      }

      return courseList;
    } else {
      return courseList;
    }
  }

  Widget headerWidget(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: kSecondaryBackgroundColor,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 5),
                  child: Text(
                    "Hello! " +
                        AuthMethods().user.displayName.toString() +
                        "👋",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: kPrimaryBackgroundColor),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: kPrimaryBackgroundColor),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/images/home_pic.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
