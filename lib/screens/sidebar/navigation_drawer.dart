import 'dart:io' show Platform;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:placementprep/resources/auth_methods.dart';
import 'package:placementprep/screens/about%20us/about_us.dart';
import 'package:placementprep/screens/login_screens/get_started.dart';
import 'package:placementprep/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  Future<void> share() async {
    await FlutterShare.share(
      title: 'Placement Preparation',
      text:
          """Want to ace your interview process? The "Placement Preparation" app is your ultimate solution. Our comprehensive curriculum ranges from beginner to advanced level, catering to users of all skill levels. Enhance your skills with our diverse practice questions, video lectures, and reading materials. And with our test feature, you'll be fully prepared for your next interview. Download "Placement Preparation" now and start preparing for your dream job!""",
      linkUrl:
          'https://play.google.com/store/apps/details?id=com.aswdc.placementpreparation',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                AuthMethods().user.displayName.toString(),
                style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                AuthMethods().user.email.toString(),
                style: TextStyle(fontSize: 10),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 48, // Image radius
                backgroundImage:
                    NetworkImage(AuthMethods().user.photoURL.toString()),
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(107, 82, 200, 0.5),
                    offset: Offset(1.0, 5.0), //(x,y)
                    blurRadius: 10.0,
                  ),
                ],
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.5,

                  // begin: Alignment.topCenter,
                  // end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(107, 82, 200, 0.3),
                    Color.fromRGBO(107, 82, 200, 1.0),
                  ],
                ),
              ),
            ),
            ListTile(
              //leading: Icon(Icons.question_mark_rounded),
              title: Text(
                'Do you have any query?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),

              //onTap: () => null,
            ),
            GestureDetector(
              onTap: () {
                launch('tel:96019 01005');
              },
              child: ListTile(
                //leading: Icon(Icons.call_rounded),
                title: Text(
                  'Call : Prof. Krunal Vyas',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                subtitle: Row(
                  children: [
                    Icon(
                      Icons.call,
                      size: 10,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "+91 96019 01005",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                //onTap: () => null,
              ),
            ),
            GestureDetector(
              onTap: () {
                launch(
                    'mailto:krunal.vyas@darshan.ac.in?subject=Query regarding aptitude &body=your question here');
              },
              child: ListTile(
                //leading: Icon(Icons.person),
                title: Text(
                  'Mail :',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                subtitle: Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      size: 10,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "krunal.vyas@darshan.ac.in",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                //onTap: () => null,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.share,
                color: Colors.lightBlue,
              ),
              title: Text(
                'Share',
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              onTap: () => share(),
            ),
            ListTile(
                leading: Icon(Icons.browser_updated_rounded),
                title: Text(
                  'Check for update',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600),
                ),
                onTap: () {
                  if (Platform.isMacOS) {
                    print('is a Mac');
                  } else if (Platform.isAndroid) {
                    launch(
                        'https://play.google.com/store/apps/details?id=com.aswdc.placementpreparation&hl=en&gl=US');
                  }
                }),
            ListTile(
                leading: Icon(
                  Icons.star_border_outlined,
                  color: Colors.amber,
                ),
                title: Text(
                  'Rate',
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                onTap: () {
                  if (Platform.isMacOS) {
                    print('is a Mac');
                  } else if (Platform.isAndroid) {
                    launch(
                        'https://play.google.com/store/apps/details?id=com.aswdc.placementpreparation&hl=en&gl=US');
                  }
                }),
            ListTile(
              leading: Image.asset(
                "assets/images/about.png",
                scale: 16,
                color: kPrimaryBackgroundColor,
              ),
              title: Text(
                'Developer',
                style: TextStyle(
                    color: kPrimaryBackgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutUs(),
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Log out',
                style: TextStyle(
                    fontSize: 14,
                    color: buttonColor,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.logout_rounded,
                color: buttonColor,
              ),
              onTap: () {
                AwesomeDialog(
                        context: context,
                        animType: AnimType.SCALE,
                        dialogType: DialogType.WARNING,
                        body: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Center(
                                child: Text(
                                  "Are you sure you want to Log out?",
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
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const GetStarted()),
                              (route) => false);
                        },
                        btnCancelColor: Colors.redAccent.shade400)
                    .show();
              },
            ),
          ],
        ),
      ),
    );
  }
}
