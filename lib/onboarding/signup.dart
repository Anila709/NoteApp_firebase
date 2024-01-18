import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_709/custom_widgets/custom_textfield.dart';
import 'package:my_firebase_709/onboarding/login.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();

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
                    // CustomTextField(
                    //   textFieldController: nameController.text,
                    //   emailHint: 'Enter Name',
                    //   tIcon: Icons.person,
                    // ),
                    // SizedBox(height: 21),
                    // CustomTextField(
                    //   textFieldController: emailController.text,
                    //   emailHint: 'Enter Email',
                    //   tIcon: Icons.email,
                    // ),
                    // SizedBox(height: 21),
                    // CustomTextField(
                    //   textFieldController: passController.text,
                    //   emailHint: 'Enter Password',
                    //   tIcon: Icons.visibility,
                    // ),
                    Container(
                      padding: EdgeInsets.only(left: 11),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(color: Colors.white,width: 1),
                      ),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: nameController,
                        decoration: InputDecoration(hintText: 'Enter name',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.person,color: Colors.grey),
                        
                        ),
                      ),
                    ),
                    SizedBox(height: 21),
                    Container(
                      padding: EdgeInsets.only(left: 11),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(color: Colors.white,width: 1),
                      ),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: emailController,
                        decoration: InputDecoration(hintText: 'Enter email',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.email,color: Colors.grey),
                        
                        ),
                      ),
                    ),
                    SizedBox(height: 21),
                    Container(
                      padding: EdgeInsets.only(left: 11),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(color: Colors.white,width: 1),
                      ),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: passController,
                        decoration: InputDecoration(hintText: 'Enter password',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.visibility,color: Colors.grey),
                        
                        ),
                      ),
                    ),
                    SizedBox(height: 21),
                    TextButton(
                        onPressed: () async {
                          var auth = FirebaseAuth.instance;
                          var firestore = FirebaseFirestore.instance;
                          try {
                            var userCred =
                                await auth.createUserWithEmailAndPassword(
                              email: emailController.text.toString(),
                              password: passController.text.toString(),
                            );
                            var uuid = userCred.user!.uid;
                            var createdAt =
                                DateTime.now().millisecondsSinceEpoch;
                            firestore.collection("users").doc(uuid).set({
                              "name": nameController.text.toString(),
                              "email": userCred.user!.email,
                              "Created At": createdAt,
                            });
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password is too weak!!!')));
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('The account already exists for that email.')));
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ohh no error occured!!$e')));
                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 21),
                        )),
                    SizedBox(height: 11),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?',
                            style: TextStyle(color: Colors.cyan)),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text('Login Now',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
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
