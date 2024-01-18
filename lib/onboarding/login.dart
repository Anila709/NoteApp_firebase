import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_709/custom_widgets/custom_textfield.dart';
import 'package:my_firebase_709/onboarding/send_otp.dart';
import 'package:my_firebase_709/onboarding/signup.dart';
import 'package:my_firebase_709/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var emailController = TextEditingController();
  var passController = TextEditingController();

  static const String LOGIN_PREF_KEY = "isLogin";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withBlue(200),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Center(
                child: Image.asset(
              "assets/icons/user.png",
              height: 150,
              width: 150,
            )),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            child: Container(
              padding: EdgeInsets.all(31),
              margin: EdgeInsets.symmetric(horizontal: 11),
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(color: Colors.indigo),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 11),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter email',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.email, color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 21),
                    Container(
                      padding: EdgeInsets.only(left: 11),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: passController,
                        decoration: InputDecoration(
                          hintText: 'Enter password',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          suffixIcon:
                              Icon(Icons.visibility, color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 21),
                    TextButton(
                        onPressed: () async {
                          var auth = FirebaseAuth.instance;
                          try {
                            var userCred =
                                await auth.signInWithEmailAndPassword(
                              email: emailController.text.toString(),
                              password: passController.text.toString(),
                            );
                            //add shared pref. here .
                            //if user is successfully logged in
                            var prefs = await SharedPreferences.getInstance();
                            var userId = userCred.user!.uid;
                            prefs.setString(LOGIN_PREF_KEY, userId);

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage(
                                          
                                        )));
                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('$e')));
                            // if (e.code == 'user-not-found') {
                            //   print('No user found for that email.');
                            // } else if (e.code == 'wrong-password') {
                            //   print('Wrong password provided for that user.');
                            // }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Ohh no error occured!!$e')));
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 21),
                        )),
                    SizedBox(height: 11),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?',
                            style: TextStyle(color: Colors.cyan)),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                            child: Text('Create Account',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                      ],
                    ),
                    SizedBox(height: 11),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Or login with',
                            style: TextStyle(color: Colors.green)),
                        InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SendOTPScreen()));
                            },
                            child: Image.asset(
                              "assets/images/smartphone.png",
                              width: 30,
                              height: 30,
                            )),
                      ],
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
