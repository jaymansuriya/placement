import 'package:flutter/material.dart';
import 'package:placementprep/resources/auth_methods.dart';
import 'package:placementprep/screens/navpages/route_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 7,
                child: Center(
                  child: Image.asset(
                    "assets/images/3.png",
                    fit: BoxFit.contain,
                    // width: 400.0,
                    // height: 450.0,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Practice with \nunique question",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Divider(color: Colors.black38),
                      Text(
                        "Solve different question to clear \nyour concepts",
                        style: TextStyle(
                            color: Color(0xFFA1B6CC),
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 70.0, right: 70, bottom: 50, top: 20),
                child: MaterialButton(
                  onPressed: () async {
                    bool res = await _authMethods.signInWithGoogle(context);
                    //Navigator.pushNamed(context, '/home');
                    if (res) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RoutePage(
                            currentIndex: 0,
                          ),
                        ),
                      );
                    }
                  },
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 11),
                  child: Center(
                    child: Text(
                      "Google Sign in",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
