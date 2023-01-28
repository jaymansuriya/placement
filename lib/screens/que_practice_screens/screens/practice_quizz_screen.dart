import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:placementprep/models/practice_questions/PracticeQuestion.dart';
import 'package:placementprep/screens/que_practice_screens/Widgets/practice_option_widget.dart';
import 'package:placementprep/utils/colors.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../main.dart';
import '../../navpages/route_page.dart';

class PracticeQuizScreen extends StatefulWidget {
  final String topicName;
  final String icon;
  final String courseID;
  final String chapterID;

  const PracticeQuizScreen(
      {Key? key,
      required this.topicName,
      required this.icon,
      required this.courseID,
      required this.chapterID})
      : super(key: key);

  @override
  _PracticeQuizScreenState createState() => _PracticeQuizScreenState();
}

class _PracticeQuizScreenState extends State<PracticeQuizScreen>
    with AutomaticKeepAliveClientMixin {
  int score = 0;
  bool isLocked = false;
  int indexOfRemove = 0;
  bool ishide = false;
  int questionNumber = 1;
  PageController? _controller;
  late Future resultGetData;
  void getData() {
    setState(() {
      resultGetData = getPracticeQuestionApi();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    getPracticeQuestionApi();
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final question = practiceQuestionList;
    return WillPopScope(
      onWillPop: () async {
        remove();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                remove();
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: kPrimaryBackgroundColor,
              ),
            ),
            backgroundColor: kSecondaryBackgroundColor,
            title: TextScroll(
              widget.topicName,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kPrimaryBackgroundColor,
                  fontSize: 20),
              mode: TextScrollMode.bouncing,
              velocity: Velocity(pixelsPerSecond: Offset(10, 0)),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Hero(
                  tag: widget.icon,
                  child: Image.network(
                    widget.icon,
                    height: 10,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          body: Container(
              color: kSecondaryBackgroundColor,
              child: FutureBuilder(
                  future: resultGetData,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: kPrimaryBackgroundColor,
                          size: 50,
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 20, bottom: 30),
                        child: PageView.builder(
                          controller: _controller!,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: practiceQuestionList.length,
                          itemBuilder: (context, index) {
                            final question = practiceQuestionList[index];
                            var _image = NetworkImage(
                                practiceQuestionList[index]
                                    .solutionImageUrl
                                    .toString());
                            indexOfRemove = index;
                            return Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: ListView(
                                controller: _scrollController,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 20, top: 25, bottom: 5),
                                    width: double.infinity,
                                    child: Text(
                                      "Question ${index + 1}/${practiceQuestionList.length}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Divider(
                                      color: kPrimaryBackgroundColor,
                                      thickness: 1.5,
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 20,
                                        bottom: 40),
                                    margin: EdgeInsets.only(
                                        top: 30,
                                        left: 20,
                                        bottom: 20,
                                        right: 20),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromRGBO(107, 82, 200, 0.5),
                                          offset: Offset(1.0, 5.0), //(x,y)
                                          blurRadius: 10.0,
                                        ),
                                      ],
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromRGBO(107, 82, 200, .7),
                                          Color.fromRGBO(107, 82, 200, .9),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      question.question.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  PracticeOptionWidget(
                                    question: question,
                                    onClickedOption: (option) {
                                      if (question.isLocked ?? false) {
                                        return;
                                      } else {
                                        setState(() {
                                          question.isLocked = true;
                                          question.selectedOption = option;
                                        });
                                        isLocked = question.isLocked;
                                        if (parseBool(question
                                            .selectedOption!.isCorrect
                                            .toString())) {
                                          score++;
                                        } else {
                                          setState(() {
                                            Future.delayed(Duration(seconds: 1),
                                                () {
                                              question.isLocked = false;
                                            });
                                          });
                                        }
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ishide
                                          ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  ishide = !ishide;
                                                });
                                              },
                                              child: Container(
                                                width: 140,
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 12,
                                                    bottom: 12),
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromRGBO(
                                                          75, 93, 86, 0.5),
                                                      offset: Offset(
                                                          1.0, 5.0), //(x,y)
                                                      blurRadius: 10.0,
                                                    ),
                                                  ],
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.black
                                                          .withOpacity(.4),
                                                      Colors.black
                                                          .withOpacity(0.7)
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        "Hide Answer",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                    Icon(
                                                        Icons
                                                            .arrow_drop_up_rounded,
                                                        color: Colors.white,
                                                        size: 20)
                                                  ],
                                                ),
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                question.isLocked = true;

                                                _image
                                                    .resolve(
                                                        ImageConfiguration())
                                                    .addListener(
                                                  ImageStreamListener(
                                                    (info, call) {
                                                      print(
                                                          'Networkimage is fully loaded and saved');

                                                      // do something
                                                      SchedulerBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) {
                                                        _scrollController.animateTo(
                                                            _scrollController
                                                                .position
                                                                .maxScrollExtent,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    1200),
                                                            curve: Curves
                                                                .fastOutSlowIn);
                                                      });
                                                    },
                                                  ),
                                                );

                                                setState(() {
                                                  ishide = !ishide;
                                                });
                                              },
                                              child: Container(
                                                width: 140,
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 12,
                                                    bottom: 12),
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromRGBO(
                                                          44, 154, 109, 0.5),
                                                      offset: Offset(
                                                          1.0, 5.0), //(x,y)
                                                      blurRadius: 10.0,
                                                    ),
                                                  ],
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromRGBO(
                                                          44, 154, 109, 0.5),
                                                      Color.fromRGBO(
                                                          44, 154, 109, 0.9),
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        "Show Answer",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                    Icon(
                                                        Icons
                                                            .arrow_drop_down_rounded,
                                                        color: Colors.white,
                                                        size: 20)
                                                  ],
                                                ),
                                              ),
                                            ),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (ishide = true) {
                                                ishide = false;
                                              }
                                            });
                                            if (questionNumber <
                                                practiceQuestionList.length) {
                                              _controller!.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 250),
                                                  curve: Curves.easeInExpo);
                                              setState(() {
                                                questionNumber++;
                                                Future.delayed(
                                                    Duration(seconds: 1), () {
                                                  question.isLocked = false;
                                                });
                                              });
                                            } else {
                                              setState(() {
                                                Future.delayed(
                                                    Duration(seconds: 1), () {
                                                  question.isLocked = false;
                                                });
                                              });
                                              // Navigator.pushReplacement(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         RoutePage(
                                              //       currentIndex: 2,
                                              //     ),
                                              //   ),
                                              // );
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const RoutePage(
                                                                  currentIndex:
                                                                      2)),
                                                      (route) => false);
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 20, bottom: 20),
                                            padding: EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromRGBO(
                                                        107, 82, 200, 0.5),
                                                    offset: Offset(
                                                        1.0, 5.0), //(x,y)
                                                    blurRadius: 10.0,
                                                  ),
                                                ],
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color.fromRGBO(
                                                        107, 82, 200, .7),
                                                    Color.fromRGBO(
                                                        107, 82, 200, .9),
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Center(
                                                child: Text(
                                              index + 1 <
                                                      practiceQuestionList
                                                          .length
                                                  ? "Next"
                                                  : "Finish!",
                                              style: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 1,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            )),
                                          ))
                                    ],
                                  ),
                                  AnimatedOpacity(
                                    opacity: ishide ? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 500),
                                    child: Visibility(
                                      visible: ishide,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 30,
                                            left: 20,
                                            right: 10,
                                            bottom: 20),
                                        child: Container(
                                          child: Image.network(
                                              practiceQuestionList[index]
                                                  .solutionImageUrl
                                                  .toString()),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: _image)),
                                        ),
                                      ),
                                      // Image.network(_image.toString())),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  })),
        ),
      ),
    );
  }

  remove() {
    setState(() {
      practiceQuestionList[indexOfRemove].isLocked = false;
    });
    Navigator.pop(context);
  }

  List<PracticeQuestion> practiceQuestionList = [];

  Future<List<PracticeQuestion>> getPracticeQuestionApi() async {
    final response = await http.get(Uri.parse(
        "${apiURL}practiceQuestion/questionByCourseID/${widget.courseID}/questionByChapterID/${widget.chapterID}"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      practiceQuestionList.clear();
      for (Map i in data) {
        practiceQuestionList.add(PracticeQuestion.fromJson(i));
      }
      return practiceQuestionList;
    } else {
      return practiceQuestionList;
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
