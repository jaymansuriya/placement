import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:placementprep/resources/auth_methods.dart';
import 'package:placementprep/screens/login_screens/get_started.dart';
import 'package:placementprep/screens/navpages/route_page.dart';

void main() async {
  // Step 2
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  runApp(MyApp());
}

const String apiURL = "https://placement-api.onrender.com/api/";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Placement Preparation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Quicksand',
      ),
      routes: {
        '/home': (context) => const RoutePage(
              currentIndex: 0,
            ),
      },
      home: StreamBuilder(
        stream: AuthMethods().authChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return const RoutePage(
              currentIndex: 0,
            );
          }
          return const GetStarted();
        },
      ),
      //const GetStarted(),
    );
  }
}
