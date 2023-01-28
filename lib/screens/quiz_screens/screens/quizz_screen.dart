import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:placementprep/main.dart';
import 'package:placementprep/models/test_questions/TestQuestion.dart';
import 'package:placementprep/screens/navpages/route_page.dart';
import 'package:placementprep/screens/quiz_screens/Widgets/optionwidget.dart';
import 'package:placementprep/screens/quiz_screens/screens/result_screen.dart';
import 'package:placementprep/utils/colors.dart';
import 'package:slide_countdown/slide_countdown.dart';

class QuizScreen extends StatefulWidget {
  final String difficulty;
  const QuizScreen({Key? key, required this.difficulty}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with AutomaticKeepAliveClientMixin {
  int score = 0;
  bool isLocked = false;
  int questionNumber = 1;
  late Future resultGetData;

  void getData() {
    setState(() {
      resultGetData = getTestQuestionApi();
    });
  }

  PageController? _controller;

  static const defaultDuration = Duration(minutes: 45);

  @override
  void initState() {
    // TODO: implement initState
    getData();
    getTestQuestionApi();
    super.initState();

    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            color: Colors.white,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    "assets/images/top3.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Opacity(
                  opacity: 1.0,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      "assets/images/bottom.png",
                      scale: 1.1,
                    ),
                  ),
                ),
                FutureBuilder(
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
                                left: 5, right: 5, top: 100, bottom: 50),
                            child: PageView.builder(
                              controller: _controller,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: testQuestionList.length,
                              itemBuilder: (context, index) {
                                final question = testQuestionList[index];
                                int totalQuestion = testQuestionList.length;
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(.25),
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 20, bottom: 5),
                                          width: double.infinity,
                                          child: Text(
                                            "Question ${index + 1}/${testQuestionList.length}",
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20),
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
                                                color: Color.fromRGBO(
                                                    107, 82, 200, 0.5),
                                                offset:
                                                    Offset(1.0, 5.0), //(x,y)
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
                                                BorderRadius.circular(20),
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
                                        OptionWidget(
                                          question: question,
                                          onClickedOption: (option) {
                                            if (question.isLocked) {
                                              return;
                                            } else {
                                              setState(() {
                                                question.isLocked = true;
                                                question.selectedOption =
                                                    option;
                                              });
                                              isLocked = question.isLocked;
                                              if (parseBool(question
                                                  .selectedOption!.isCorrect
                                                  .toString())) {
                                                score++;
                                              }

                                              if (questionNumber <
                                                  testQuestionList.length) {
                                                Future.delayed(
                                                    Duration(milliseconds: 150),
                                                    () {
                                                  _controller!.nextPage(
                                                      duration: const Duration(
                                                          milliseconds: 250),
                                                      curve: Curves.easeInExpo);
                                                });

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
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ResultScreen(
                                                      score,
                                                      totalQue: totalQuestion,
                                                    ),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ));
                      }
                    }),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SlideCountdownSeparated(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      duration: defaultDuration,
                      width: 80,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                      textStyle: TextStyle(
                          color: kPrimaryBackgroundColor,
                          fontSize: 30,
                          letterSpacing: 10),
                      onDone: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultScreen(
                                      score,
                                      totalQue: testQuestionList.length,
                                    )));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        showExitPopup();
                      },
                      child: Icon(
                        Icons.exit_to_app_outlined,
                        color: kPrimaryBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.WARNING,
          body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Are you sure you want to quit the test?",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const RoutePage(
            //       currentIndex: 3,
            //     ),
            //   ),
            // );
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const RoutePage(currentIndex: 3)),
                (route) => false);
            true;
          },
        ).show() ??
        false;
  }

  List<TestQuestion> testQuestionList = [];

  Future<List<TestQuestion>> getTestQuestionApi() async {
    final response = await http.get(Uri.parse(
        '${apiURL}testQuestion/questionsByDifficulty/${widget.difficulty.toLowerCase()}'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      testQuestionList.clear();
      for (Map i in data) {
        testQuestionList.add(TestQuestion.fromJson(i));
      }

      return testQuestionList;
    } else {
      return testQuestionList;
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

bool parseBool(String boolean) {
  if (boolean.toLowerCase() == 'true') {
    return true;
  } else if (boolean.toLowerCase() == 'false') {
    return false;
  }

  throw '"$boolean" can not be parsed to boolean.';
}
