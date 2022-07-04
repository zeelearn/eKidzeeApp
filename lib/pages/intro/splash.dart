import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/KidzeePref.dart';
import 'package:flutter/foundation.dart';
import 'package:ekidzee/pages/login/login_screen.dart';
import 'package:ekidzee/pages/intro/intro.dart';

import '../../helper/LocalConstant.dart';
import '../home/home_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  KidzeePref pref =KidzeePref();

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  // checkLoginStatus() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   if(pref.getString(key))
  // }

  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() async{
    print("-------init---=-=-=-=-=-=-");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String displayName = '';

    if(prefs.getString(LocalConstant.KEY_DISPLAY_NAME)!=null) {
      displayName = prefs.getString(LocalConstant.KEY_DISPLAY_NAME) as String;
    }
      print("-------${displayName}");
      if(prefs.getString(LocalConstant.KEY_USER_ID)=='') {
        Timer(
            Duration(seconds: 4),
                () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MyHomePage(
                              name: displayName,
                              title: displayName)),
                ));
      }else {
        if (kIsWeb) {
          Timer(
              Duration(seconds: 4),
                  () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen())));
        } else {
          //IntroPage
          Timer(
              Duration(seconds: 4),
                  () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => IntroPage())));
        }
      }
  }


  void navigationPage() {
    //Navigator.of(context).pushReplacementNamed('/pages/intro/IntroPage');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      child: Image.asset('assets/icons/app_logo.png'),
                    ),
                    Container(
                      child: Text(
                        "",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                  // children: const [
                  //   CircleAvatar(
                  //     backgroundColor: Colors.white,
                  //     radius: 50.0,
                  //     child: ImageIcon(
                  //       AssetImage("assets/icons/app_logo.png"),
                  //
                  //     ),
                  //   ),
                  //   Padding(padding: EdgeInsets.only(top: 10.0)),
                  //   Text(
                  //     "Kidzee",
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 24.0,
                  //         color: Colors.black),
                  //   )
                  // ],
                ),
              ),
              // Expanded(
              //   flex: 1,
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     CircularProgressIndicator.adaptive(value: 3.0,),
              //     Padding(padding: const EdgeInsets.only(top: 20.0))
              //   ],
              // ),)
            ],
          ),

          // Container(
          //   margin: EdgeInsets.only(bottom: 30),
          //   child: TextButton(
          //     style: TextButton.styleFrom(
          //       backgroundColor: Colors.red,
          //       primary: Colors.white, // foreground
          //     ),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => LoginScreen()),
          //       );
          //     },
          //     child: Text('Start Now'),
          //   ),
          // ),
        ],
      ),
    );
  }
}