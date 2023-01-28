import 'dart:convert';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:placementprep/main.dart';
import 'package:placementprep/models/chapters/Chapter.dart';
import 'package:placementprep/screens/que_practice_screens/screens/practice_quizz_screen.dart';
import 'package:placementprep/screens/videos_screens/Widgets/topic_list.dart';
import 'package:placementprep/utils/colors.dart';
import 'package:text_scroll/text_scroll.dart';

class topicListPracticeReasoning extends StatefulWidget {
  const topicListPracticeReasoning({Key? key}) : super(key: key);

  @override
  State<topicListPracticeReasoning> createState() =>
      _topicListPracticeReasoningState();
}

// ignore: camel_case_types
class _topicListPracticeReasoningState
    extends State<topicListPracticeReasoning> {
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
            return LiveGrid.options(
              options: options,

              // Like GridView.builder, but also includes animation property
              itemBuilder: buildAnimatedItem,

              // Other properties correspond to the `ListView.builder` / `ListView.separated` widget
              itemCount: snapshot.data!.length,
              //itemCount: chapterList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 13,
                mainAxisSpacing: 0,
              ),
            );
          }
        });
  }

  List<Chapter> chapterList = [];
}

Future<List<Chapter>> getChapterApi() async {
  final response =
      await http.get(Uri.parse('${apiURL}chapters/chaptersByCourseID/1'));
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
        //Paste you Widget
        child: FutureBuilder<List<Chapter>>(
            future: getChapterApi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print(chapterList[index].chapterName.toString());
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: kPrimaryBackgroundColor,
                    size: 50,
                  ),
                );
              } else {
                return Container(
                  // padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(bottom: 15, left: 5, right: 5),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: Offset(.0, 2.0),
                        blurRadius: 4,
                      ),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.grey.shade50,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticeQuizScreen(
                            topicName:
                                chapterList[index].chapterName.toString(),
                            icon: chapterList[index].chapterImage.toString(),
                            courseID: '1',
                            chapterID: chapterList[index].chapterId.toString(),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Hero(
                          tag: chapterList[index].chapterImage.toString(),
                          child: Image.network(
                            chapterList[index].chapterImage.toString(),
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: TextScroll(
                            chapterList[index].chapterName.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13),
                            textAlign: TextAlign.center,
                            mode: TextScrollMode.bouncing,
                            velocity: Velocity(pixelsPerSecond: Offset(10, 0)),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
