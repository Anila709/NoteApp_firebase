
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_firebase_709/custom_widgets/custom_textfield.dart';

class VerifyOTPScreen extends StatelessWidget {
  const VerifyOTPScreen({super.key});

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
                    child: Lottie.asset(
                  "assets/lottie/anim_2.json",
                  height: 130,
                  width: 130,
                )),
                Text("Enter Verification Code",style: TextStyle(color: Colors.amber,fontSize: 21,fontWeight: FontWeight.bold),),
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
                    Text("Enter OTP",style: TextStyle(color: Colors.redAccent,fontSize: 21,fontWeight: FontWeight.bold),),
                     SizedBox(height: 11),
                    Text("We have sent OTP on you mobile",style: TextStyle(color: Colors.white,fontSize: 12),),
                    SizedBox(height: 31),
                   Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => Container(
                  width: 50,
                  decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 1),borderRadius: BorderRadius.circular(5)),
                  child: TextField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      counterText: '',
                      border: InputBorder.none
                      
                    ),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
                    SizedBox(height: 21),
                    InkWell(
                      onTap: () {
                        
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),color: Colors.cyan),
                        child: 
                        
                         Center(child: Text('Verify',style:TextStyle(fontWeight: FontWeight.bold) ,)),
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


