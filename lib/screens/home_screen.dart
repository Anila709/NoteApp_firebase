import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_709/note_model.dart';
import 'package:my_firebase_709/onboarding/login.dart';
import 'package:my_firebase_709/screens/add_note_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key});

  // String userId;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userId="";
  late FirebaseFirestore firestore;
  late CollectionReference collRef;
  String id = "";
  // String title = "";
  // String desc = "";
  // bool isUpdate = false;
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var searchController=TextEditingController();

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    collRef = firestore.collection("users");
    getUserIdFromPref();
  }

   getUserIdFromPref()async{
    var prefs=await SharedPreferences.getInstance();
    userId=prefs.getString(LoginScreen.LOGIN_PREF_KEY)!;
    setState(() {
      
    });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withBlue(200),
      appBar: AppBar(
        title: const Text("Notes"),
        backgroundColor: Colors.indigo,
        actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 150,
                height: 30,
                        padding: EdgeInsets.only(left: 11),
                        
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search Notes',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            suffixIcon:
                                IconButton(onPressed: (){},icon: Icon(Icons.search,color: Colors.white,),),
                          ),
                        ),
                      ),
            ),
          IconButton(onPressed: () async {
                  var prefs = await SharedPreferences.getInstance();
                  prefs.setString(LoginScreen.LOGIN_PREF_KEY, "");
          
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }, icon: Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: firestore.collection("users").doc(userId).collection("notes").get(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("could not fetch data"),
                );
              } else if (snapshot.hasData) {
                var mData = snapshot.data!.docs;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: mData.length,
                      itemBuilder: (_, index) {
                        NoteModel currNote =
                            NoteModel.fromMap(mData[index].data());
                        var itemTitle = currNote.title!;
                        var itemDesc = currNote.desc!;
                        return Card(
                          child: ListTile(
                            title: Text('$itemTitle'),
                            subtitle: Text('$itemDesc'),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        titleController.text = itemTitle;
                                        descController.text = itemDesc;
                                        id = mData[index].id;
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: 250,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top: Radius.circular(
                                                                16)),
                                                    color: Colors.white),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(11.0),
                                                  child: Column(children: [
                                                    Text("Update Note Here"),
                                                    SizedBox(height: 11),
                                                    TextField(
                                                      controller: titleController,
                                                      decoration: InputDecoration(
                                                          hintText: 'Enter Title ',
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(16),
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.indigo),
                                                          )),
                                                    ),
                                                    SizedBox(height: 11),
                                                    TextField(
                                                      controller: descController,
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              'Enter Description',
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(16),
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color:
                                                                    Colors.indigo),
                                                          )),
                                                    ),
                                                    SizedBox(height: 21),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          collRef.doc(userId).collection("notes")
                                                              .doc(id)
                                                              .update(NoteModel(
                                                                      title: titleController
                                                                          .text
                                                                          .toString(),
                                                                      desc: descController
                                                                          .text
                                                                          .toString())
                                                                  .toMap())
                                                              .then((value) {
                                                            titleController.text =
                                                                "";
                                                            descController.text =
                                                                "";
                                                            setState(() {});
                                                            Navigator.pop(context);
                        
                                                            print("Note Updated!!");
                                                          }).catchError((error,
                                                                      stackTrace) =>
                                                                  print('$error'));
                                                        },
                                                        child: Text('Update'))
                                                  ]),
                                                ),
                                              );
                                            });
                                      },
                                      icon: Icon(Icons.edit,
                                          color: Colors.greenAccent)),
                                  IconButton(
                                    onPressed: () {
                                      id = mData[index].id;
                                      //to delete note ...
                                      collRef.doc(userId).collection("notes").doc(mData[index].id).delete().then(
                                          (value) {
                                        setState(() {});
                                        print('note deleted sucessfully');
                                      }).catchError((error) =>
                                          print('failed to delete note $error'));
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return Container(
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Column(children: [
                      Text("Add Note Here"),
                      SizedBox(height: 11),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                            hintText: 'Enter Title ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.indigo),
                            )),
                      ),
                      SizedBox(height: 11),
                      TextField(
                        controller: descController,
                        decoration: InputDecoration(
                            hintText: 'Enter Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.indigo),
                            )),
                      ),
                      SizedBox(height: 21),
                      ElevatedButton(
                          onPressed: () {
                            collRef.doc(userId).collection("notes")
                                .add(NoteModel(
                                        title: titleController.text.toString(),
                                        desc: descController.text.toString())
                                    .toMap())
                                .then((value) {
                              setState(() {
                                titleController.text = "";
                                descController.text = "";
                              });
                              Navigator.pop(context);

                              print("Note Added!!");
                            }).catchError(
                                    (error, stackTrace) => print('$error'));
                          },
                          child: Text('Add'))
                    ]),
                  ),
                );
              });
        },
        tooltip: 'Add note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
