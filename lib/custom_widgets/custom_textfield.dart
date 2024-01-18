import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({
    super.key,
    required this.emailHint,
    required this.tIcon,
    this.keyboardtype=TextInputType.text,
    this.textFieldController="",
   
  });

  final String emailHint;
  final IconData tIcon;
  final TextInputType keyboardtype;
  final String textFieldController;
  var tController=TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    tController.text=textFieldController;
    return Container(
      padding: EdgeInsets.only(left:11),
      height: 40,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),border: Border.all(color: Colors.white,width: 1)),
      child: TextField(
        controller: tController,
        keyboardType: keyboardtype,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            hintText: emailHint,
            suffixIcon: Icon(tIcon,color: Colors.grey,),
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none),
      ),
    );
  }
}