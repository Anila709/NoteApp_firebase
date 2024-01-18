import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_firebase_709/onboarding/login.dart';
import 'package:my_firebase_709/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashSCreen extends StatefulWidget {
  const SplashSCreen({super.key});

  @override
  State<SplashSCreen> createState() => _SplashSCreenState();
}

class _SplashSCreenState extends State<SplashSCreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 9), () async{

      var prefs = await SharedPreferences.getInstance();

      String? checkLogin = prefs.getString(LoginScreen.LOGIN_PREF_KEY);

      Widget navigateTo = LoginScreen();


      if(checkLogin!=null && checkLogin !=""){
        navigateTo = MyHomePage();
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => navigateTo,
          ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withBlue(200),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/lottie/splash_anim.json",width: 80,height: 80),
            SizedBox(height: 21),
            Text("Welcome To",style: TextStyle(fontSize: 21,),),
            SizedBox(
              width: 200,
              child: TextLiquidFill(text: 'Notes',
              loadDuration: Duration(seconds: 5),
              waveDuration: Duration(seconds: 6),
              waveColor: Colors.blueAccent,
              boxHeight: 100,
              boxBackgroundColor: Colors.white.withBlue(200),
              
              loadUntil: 0.8,
              //boxWidth: 500,
              textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
