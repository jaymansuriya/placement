import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:placementprep/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class LodingWidget extends StatelessWidget {
  const LodingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0 / 2,
          ),
          // color: Colors.blueAccent,
          height: 160,
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
                ),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade50,
                  direction: ShimmerDirection.ltr,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
              ),
              // our product image
              Positioned(
                top: -20,
                right: -2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 160,
                  // image is square but we add extra 20 + 20 padding thats why width is 200
                  width: 200,
                ),
              ),
              // Product title and price
              Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  height: 136,
                  // our image take 200 width, thats why we set out total width - 200

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          " ",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      // it use the available space
                      Spacer(),
                      Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20 * 1.5,
                            // 30 padding
                            vertical: 20 / 4, // 5 top and bottom
                          ),
                          decoration: BoxDecoration(
                            color: kSecondaryBackgroundColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(22),
                              topRight: Radius.circular(22),
                            ),
                          ),
                          child: Text(
                            "            ",
                            style: TextStyle(fontSize: 12),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0 / 2,
          ),
          // color: Colors.blueAccent,
          height: 160,
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
                ),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade50,
                  direction: ShimmerDirection.ltr,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
              ),
              // our product image
              Positioned(
                top: -20,
                right: -2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 160,
                  // image is square but we add extra 20 + 20 padding thats why width is 200
                  width: 200,
                ),
              ),
              // Product title and price
              Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  height: 136,
                  // our image take 200 width, thats why we set out total width - 200

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          " ",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      // it use the available space
                      Spacer(),
                      Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20 * 1.5,
                            // 30 padding
                            vertical: 20 / 4, // 5 top and bottom
                          ),
                          decoration: BoxDecoration(
                            color: kSecondaryBackgroundColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(22),
                              topRight: Radius.circular(22),
                            ),
                          ),
                          child: Text(
                            "            ",
                            style: TextStyle(fontSize: 12),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
