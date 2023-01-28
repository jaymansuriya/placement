import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:placementprep/screens/quiz_screens/screens/quizz_screen.dart';
import 'package:placementprep/utils/colors.dart';

class QuizList extends StatelessWidget {
  const QuizList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> difficulty = [
      "Easy",
      "Medium",
      "Hard",
    ];

    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: difficulty.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
        // color: Colors.blueAccent,
        height: 130,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: 156,
              margin: EdgeInsets.only(top: 28),
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
                    Color.fromRGBO(107, 82, 200, 1.0),
                    Color.fromRGBO(107, 82, 200, .4),
                  ],
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border:
                        Border.all(color: kPrimaryBackgroundColor, width: 0.1)),
              ),
            ),
            // our product image
            Positioned(
              right: -15,
              top: 50,
              child: InkWell(
                onTap: () {
                  AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          dialogType: DialogType.INFO_REVERSED,
                          body: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: Image.asset("assets/images/rule.png",
                                        scale: 2)),
                                Text(
                                  "1) This test contains 30 Questions.",
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 5),
                                const Text(
                                  "2) You have to complete the test in 45 minutes, after that test will be automatically submitted.",
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 5),
                                const Text(
                                  "3) You can visit a question only once and you can select only a single option and you will be redirect to next question so be careful while selecting answer.  ",
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 5),
                                const Text(
                                  "4) Once you start the test you can not quit it.",
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                const Center(
                                  child: Text(
                                    "Are you sure you want to start the test?",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizScreen(
                                  difficulty: difficulty[index],
                                ),
                              ),
                            );
                          },
                          btnCancelColor: Colors.redAccent.shade400)
                      .show();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 40,
                  // image is square but we add extra 20 + 20 padding thats why width is 200
                  width: 150,

                  child: Center(
                    child: Text(
                      "Start",
                      style: TextStyle(
                          color: kPrimaryBackgroundColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
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
                      padding: EdgeInsets.only(left: 20, top: 15),
                      child: Text(
                        difficulty[index],
                        style: TextStyle(fontSize: 18),
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
                      child: Text("Total Questions : 30",
                          style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
