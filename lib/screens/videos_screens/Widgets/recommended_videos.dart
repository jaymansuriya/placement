import 'package:auto_animated/auto_animated.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:placementprep/screens/videos_screens/ytplayer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RecommendedVideos extends StatefulWidget {
  const RecommendedVideos({Key? key}) : super(key: key);

  @override
  State<RecommendedVideos> createState() => _RecommendedVideosState();
}

class _RecommendedVideosState extends State<RecommendedVideos> {
  @override
  void initState() {
    for (var i = 0; i < chlistYTUrl.length; i++) {
      String temp = chlistYTUrl[i];
      ytThumbnail.add(getYoutubeThumbnail(temp));
    }

    super.initState();
  }

  String getYoutubeThumbnail(String videoUrl) {
    String? id = YoutubePlayer.convertUrlToId(videoUrl);

    return 'https://img.youtube.com/vi/$id/0.jpg';
  }

  @override
  Widget build(BuildContext context) {
    const options = LiveOptions(
      // Start animation after (default zero)
      delay: Duration(milliseconds: 0),

      // Show each item through (default 250)
      showItemInterval: Duration(milliseconds: 00),

      // Animation duration (default 250)
      showItemDuration: Duration(milliseconds: 0),

      // Animations starts at 0.05 visible
      // item fraction in sight (default 0.025)
      visibleFraction: 0.05,

      // Repeat the animation of the appearance
      // when scrolling in the opposite direction (default false)
      // To get the effect as in a showcase for ListView, set true
      reAnimateOnVisibility: false,
    );
    return SizedBox(
      height: 240,
      child: LiveList.options(
        options: options,

        // Like ListView.builder, but also includes animation property
        itemBuilder: buildAnimatedItem,
        scrollDirection: Axis.horizontal,

        // Other properties correspond to the
        // `ListView.builder` / `ListView.separated` widget
        itemCount: chlist.length,
      ),
    );
  }
}

List<String> chlist = [
  "Average",
  "Blood Relation",
  "Coding & Decoding",
  "Number Series",
  "Time & Work",
  "Problems on Train"
];

List<String> chlistYTUrl = [
  "https://youtu.be/77rPSRoOMuY",
  "https://youtu.be/U7AbXdibAhA",
  "https://youtu.be/x2017lYQI2I",
  "https://youtu.be/fgirTwUjHfM",
  "https://youtu.be/KXUjTEiPa_U",
  "https://youtu.be/5GjZiRu_3Rc",
];
List<String> ytThumbnail = [];

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
        // Paste you Widget
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
                              url: chlistYTUrl[index],
                              topicName: chlist[index],
                            )));
              },
            ).show();
          },
          child: SizedBox(
            width: 300,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 15.0, top: 25.0, bottom: 10.0, right: 10),
              child: Container(
                  height: 500.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3.0,
                            color: Colors.grey.withOpacity(0.3),
                            offset: Offset(1, 1),
                            spreadRadius: 3.0)
                      ]),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              height: 150.0,
                              width: 300.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.0),
                                      topRight: Radius.circular(12.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(ytThumbnail[index]),
                                      fit: BoxFit.cover)),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Opacity(
                                  opacity: 0.8,
                                  child: Image.asset(
                                    "assets/images/play.png",
                                    scale: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            chlist[index],
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ])),
            ),
          ),
        ),
      ),
    );
