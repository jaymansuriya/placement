import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:placementprep/screens/videos_screens/Widgets/topic_list.dart';

class VideoList extends StatefulWidget {
  final String title;
  final String courseID;

  const VideoList({
    Key? key,
    required this.title,
    required this.courseID,
  }) : super(key: key);

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.deepPurple[400],
          title: Text(
            widget.title,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),
          ),
        ),
        body: topicList(
          courseID: widget.courseID,
        ),
      ),
    );
  }
}
