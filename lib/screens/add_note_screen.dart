import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_709/note_model.dart';

class AddNoteScreen extends StatefulWidget {
  AddNoteScreen({super.key,required this.instance,required this.ref,required this.id,this.updateTitle="",this.updateDesc="",this.isUpdate=false});

  FirebaseFirestore instance;
  CollectionReference ref;
  String id;
  String updateTitle;
  String updateDesc;
  bool isUpdate;
  

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  

  var titleController = TextEditingController();

  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text=widget.updateTitle;
    descController.text=widget.updateDesc;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        backgroundColor: Colors.blue,
      ),
      body: Column(children: [
        TextField(
          controller: titleController,
        ),
        TextField(
          controller: descController,
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(onPressed: () {
          print(widget.isUpdate);
                    print(widget.id);
                    print(widget.updateTitle);
                    print(widget.updateDesc);
          if (titleController.text.isNotEmpty &&
                  descController.text.isNotEmpty&&widget.id.isNotEmpty) {
                    
                    if(widget.isUpdate){
                      widget.ref
                .doc(widget.id)
                    .update(NoteModel(
                  title: titleController.text.toString(),
                  desc: descController.text.toString(),
                ).toMap())
                    .then((value) {
                  setState(() {});
                  Navigator.pop(context);
                  print("notes updated");
                }).catchError(
                        (error) => print("failed to add notes $error"));
                    }
                    else{
                   widget.ref
                    .add(NoteModel(
                  title: titleController.text.toString(),
                  desc: descController.text.toString(),
                ).toMap())
                    .then((value) {
                  setState(() {});
                  Navigator.pop(context);
                  print("notes added");
                }).catchError(
                        (error) => print("failed to add notes $error"));
                    }
                
              }
        }, child: widget.isUpdate?Text("Update"):Text('Add note'))
      ]),
    );
  }
}
