
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_firebase_709/custom_widgets/custom_textfield.dart';
import 'package:my_firebase_709/onboarding/verify_otp.dart';

class SendOTPScreen extends StatelessWidget {
  const SendOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withBlue(200),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: Image.asset(
                  "assets/icons/pin.png",
                  height: 130,
                  width: 130,
                )),
                Text("OTP Verification",style: TextStyle(color: Colors.amber,fontSize: 21,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            child: Container(
              padding: EdgeInsets.all(31),
              margin: EdgeInsets.symmetric(horizontal: 11),
              height: MediaQuery.of(context).size.height * 0.60,
              decoration: BoxDecoration(color: Colors.indigo),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Enter your mobile number",style: TextStyle(color: Colors.redAccent,fontSize: 21,fontWeight: FontWeight.bold),),
                     SizedBox(height: 11),
                    Text("We will send you a OTP message",style: TextStyle(color: Colors.white,fontSize: 12),),
                    SizedBox(height: 31),
                    CustomTextField(
                      emailHint: 'Enter mobile number',
                      tIcon: Icons.phone_android,
                      keyboardtype: TextInputType.number,
                    ),
                    SizedBox(height: 21),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyOTPScreen()));
                        // showDialog(context: context, builder: (context){
                        //   return AlertDialog(
                        //       icon: Lottie.asset("assets/lottie/anim_1.json",height: 100,width: 100),
                              
                              
                        //   );
                          
                        // });
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),color: Colors.cyan),
                        child: 
                        
                         Center(child: Text('Send OTP',style:TextStyle(fontWeight: FontWeight.bold) ,)),
                      ),
                    ),
                    SizedBox(height: 21),
                    
                  ]),
            ),
          )
        ],
      ),
    );
  }
}


