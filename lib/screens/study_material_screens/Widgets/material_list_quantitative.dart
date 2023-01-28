import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:placementprep/main.dart';
import 'package:placementprep/models/chapters/Chapter.dart';
import 'package:placementprep/screens/study_material_screens/pdf_viewer_page.dart';
import 'package:placementprep/utils/colors.dart';

class MaterialListQuantitative extends StatefulWidget {
  MaterialListQuantitative({Key? key}) : super(key: key) {}

  @override
  State<MaterialListQuantitative> createState() =>
      _MaterialListQuantitativeState();
}

class _MaterialListQuantitativeState extends State<MaterialListQuantitative> {
  @override
  Widget build(BuildContext context) {
    // double deviceW = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
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
            return ListView.builder(
              itemCount: chapterList.length,
              itemBuilder: (BuildContext context, int index) {
                int chNum = index + 1;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFViewerPage(
                          pdfURL: chapterList[index].materialUrl.toString(),
                          topicName: chapterList[index].chapterName.toString(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    margin:
                        EdgeInsets.only(top: 5, bottom: 15, right: 5, left: 5),
                    width: size.width - 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                            blurStyle: BlurStyle.inner,
                            color: Color.fromRGBO(107, 82, 200, .3),
                            blurRadius: 2,
                            spreadRadius: 1,
                            offset: Offset(1, 2)),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Chapter : $chNum   \n",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF393939),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                chapterList[index].chapterName.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF393939),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Image.network(
                          chapterList[index].chapterImage.toString(),
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        });
  }

  List<Chapter> chapterList = [];

  Future<List<Chapter>> getChapterApi() async {
    final response =
        await http.get(Uri.parse('${apiURL}chapters/chaptersByCourseID/2'));
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
}
