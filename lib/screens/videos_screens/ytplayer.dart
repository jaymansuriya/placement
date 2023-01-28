import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:placementprep/utils/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtPlayer extends StatefulWidget {
  final String url;
  final String topicName;
  const YtPlayer({Key? key, required this.url, required this.topicName})
      : super(key: key);

  @override
  State<YtPlayer> createState() => _YtPlayerState();
}

class _YtPlayerState extends State<YtPlayer> {
  late YoutubePlayerController _controller;
  late String _videoId;

  void runYoutubePlayer() {
    _controller = YoutubePlayerController(
      initialVideoId: _videoId,
      flags: YoutubePlayerFlags(
        enableCaption: false,
        isLive: false,
        autoPlay: true,
      ),
    );
  }

  @override
  void initState() {
    _videoId = YoutubePlayer.convertUrlToId(widget.url)!;
    runYoutubePlayer();
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  var navContent;
  excludeBottomNavigationBar() {
    return Container(
      height: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          aspectRatio: 20 / 9,
          showVideoProgressIndicator: true,
          progressIndicatorColor: buttonColor,
          onReady: () {},
          progressColors: ProgressBarColors(
              playedColor: buttonColor,
              handleColor: buttonColor,
              backgroundColor: Colors.grey),
        ),
        builder: (context, player) {
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
                  widget.topicName,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 20),
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  player,
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        "assets/images/bottom.png",
                        scale: 1.5,
                      ))
                ],
              ),
            ),
          );
        });
  }
}
