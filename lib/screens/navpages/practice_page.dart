import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:placementprep/screens/que_practice_screens/Widgets/topic_list_practice_reasoning.dart';
import 'package:placementprep/screens/que_practice_screens/Widgets/topic_quantitative.dart';
import 'package:placementprep/screens/sidebar/navigation_drawer.dart';
import 'package:placementprep/utils/colors.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({Key? key}) : super(key: key);

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: NavigationDrawer(),
          appBar: AppBar(
            centerTitle: true,
            leading: Builder(builder: (context) {
              return Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.barsStaggered,
                    color: Colors.white,
                  ),
                ),
              );
            }),
            backgroundColor: Colors.deepPurple[500],
            title: Text(
              "Practice here!",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 20),
            ),
          ),
          backgroundColor: Colors.grey.shade50,
          body: Container(
            //padding: EdgeInsets.only(left: 20, right: 20, top: 5),
            child: Column(
              children: [
                Container(
                  // height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[500],
                      boxShadow: [BoxShadow(blurRadius: 8.0)],
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(60),
                          bottomLeft: Radius.circular(60))),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: 10, left: 40, right: 40),
                        child: TabBar(
                          unselectedLabelColor: Colors.white,
                          labelColor: Colors.deepPurple,
                          indicatorColor: kSecondaryBackgroundColor,
                          indicatorWeight: 2,
                          indicator: BoxDecoration(
                            color: Colors.deepPurple[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          controller: tabController,
                          tabs: [
                            Tab(
                              child: Text(
                                "Reasoning",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Quantitative",
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    margin: EdgeInsets.only(top: 10),
                    width: double.maxFinite,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        topicListPracticeReasoning(),
                        topicListPracticeQuantitative()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
