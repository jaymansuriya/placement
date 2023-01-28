import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:placementprep/screens/navpages/route_page.dart';
import 'package:placementprep/utils/colors.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int totalQue;

  const ResultScreen(this.score, {Key? key, required this.totalQue})
      : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.score >= 23) ...[
                      Container(
                        width: double.infinity,
                        child: Text(
                          "You are doing amazing! 👏",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kPrimaryBackgroundColor,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ] else if (widget.score >= 15 && widget.score < 23) ...[
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "You are doing good, but practice more! 👍",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kPrimaryBackgroundColor,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ] else ...[
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "You need to improve a lot, have you watched video lectures! 🤔 ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kPrimaryBackgroundColor,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    SizedBox(
                      height: 30,
                    ),
                    if (widget.score >= 23) ...[
                      Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/placement-preparation-46e5f.appspot.com/o/Image%20used%20in%20app%2FResult%2Fgood1.jpeg?alt=media&token=4e882c0d-4c15-42be-b467-b4ba32e5dad5",
                        height: 180,
                      ),
                    ] else if (widget.score >= 15 && widget.score < 23) ...[
                      Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/placement-preparation-46e5f.appspot.com/o/Image%20used%20in%20app%2FResult%2Fmed1.jpeg?alt=media&token=426ddf4c-5738-4c30-a57a-71f5519b0ca8",
                        height: 180,
                      ),
                    ] else ...[
                      Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/placement-preparation-46e5f.appspot.com/o/Image%20used%20in%20app%2FResult%2Fpoor1.jpeg?alt=media&token=411422de-ffdb-4109-9cdc-6ec2b1623b91",
                          height: 180),
                    ],
                    SizedBox(
                      height: 45.0,
                    ),
                    const Center(
                      child: Text(
                        "Your Score",
                        style: TextStyle(
                            color: kPrimaryBackgroundColor, fontSize: 28.0),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.score}/30",
                          style: TextStyle(
                            color: kPrimaryBackgroundColor,
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => RoutePage(
                        //         currentIndex: 3,
                        //       ),
                        //     ));
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RoutePage(currentIndex: 3)),
                            (route) => false);
                      },
                      child: Container(
                        width: 140,
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 12, bottom: 12),
                        decoration: BoxDecoration(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.houseChimney,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              "Home",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
