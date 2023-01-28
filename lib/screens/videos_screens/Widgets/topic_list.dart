import 'dart:convert';

import 'package:auto_animated/auto_animated.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:placementprep/main.dart';
import 'package:placementprep/models/chapters/Chapter.dart';
import 'package:placementprep/screens/videos_screens/ytplayer.dart';
import 'package:placementprep/utils/colors.dart';

late String courseId;

class topicList extends StatefulWidget {
  final String courseID;

  topicList({Key? key, required this.courseID}) : super(key: key) {
    courseId = courseID;
  }

  @override
  State<topicList> createState() => _topicListState();
}

class _topicListState extends State<topicList> {
  @override
  void initState() {
    getChapterApi();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const options = LiveOptions(
      // Start animation after (default zero)
      delay: Duration(milliseconds: 10),

      // Show each item through (default 250)
      showItemInterval: Duration(milliseconds: 10),

      // Animation duration (default 250)
      showItemDuration: Duration(milliseconds: 100),

      // Animations starts at 0.05 visible
      // item fraction in sight (default 0.025)
      visibleFraction: 0.05,

      // Repeat the animation of the appearance
      // when scrolling in the opposite direction (default false)
      // To get the effect as in a showcase for ListView, set true
      reAnimateOnVisibility: false,
    );

    return FutureBuilder<List<Chapter>>(
      future: getChapterApi(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: kPrimaryBackgroundColor,
              size: 50,
            ),
          );
        } else {
          return Container(
            color: Colors.white,
            child: LiveList.options(
              options: options,

              // Like ListView.builder, but also includes animation property
              itemBuilder: buildAnimatedItem,
              scrollDirection: Axis.vertical,

              // Other properties correspond to the
              // `ListView.builder` / `ListView.separated` widget
              itemCount: snapshot.data!.length,
            ),
          );
        }
      },
    );
  }
}

List<Chapter> chapterList = [];

Future<List<Chapter>> getChapterApi() async {
  final response = await http
      .get(Uri.parse('${apiURL}chapters/chaptersByCourseID/$courseId'));
  var data = jsonDecode(response.body.toString());

  if (response.statusCode == 200) {
    chapterList.clear();
    for (Map i in data) {
      chapterList.add(Chapter.fromJson(i));
    }

    return chapterList;
  } else {
    return chapterList;
  }
}

Widget buildAnimatedItem(
  BuildContext context,
  int index,
  Animation<double> animation,
) =>
    // For example wrap with fade transition
    FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      // And slide transition
      child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          child: FutureBuilder<List<Chapter>>(
            future: getChapterApi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: kPrimaryBackgroundColor,
                    size: 50,
                  ),
                );
              } else {
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0 / 2,
                  ),
                  // color: Colors.blueAccent,
                  height: 130,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      // Those are our background
                      Container(
                        height: 156,
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: kPrimaryBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(107, 82, 200, 0.5),
                              //(x,y)
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(107, 82, 200, .0),
                              Color.fromRGBO(107, 82, 200, 1.0),
                            ],
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                  color: kPrimaryBackgroundColor, width: 0.1)),
                        ),
                      ),
                      // our product image
                      Positioned(
                        right: -15,
                        top: 45,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 50,
                          // image is square but we add extra 20 + 20 padding thats why width is 200
                          width: 200,
                          child: InkWell(
                            onTap: () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.INFO_REVERSED,
                                body: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "These lectures are available in Gujarati Language.",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "English/Hindi lecture will be available soon!",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                    ],
                                  ),
                                ),
                                btnOkOnPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => YtPlayer(
                                        url: chapterList[index]
                                            .videoUrl
                                            .toString(),
                                        topicName: chapterList[index]
                                            .chapterName
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                              ).show();
                            },
                            child: Image.asset(
                              "assets/images/play.png",
                            ),
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
                          width: MediaQuery.of(context).size.width - 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  chapterList[index].chapterName.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              // it use the available space
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20 * 1.5, // 30 padding
                                  vertical: 20 / 4, // 5 top and bottom
                                ),
                                decoration: BoxDecoration(
                                  color: kSecondaryBackgroundColor,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(22),
                                    topRight: Radius.circular(22),
                                  ),
                                ),
                                child: Text(
                                    chapterList[index].videoDuration.toString(),
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          )),
    );
