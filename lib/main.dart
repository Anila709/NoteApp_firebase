import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_709/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_firebase_709/note_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FirebaseFirestore firestore;

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: firestore.collection("notes").get(),
          builder: (_, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              if(snapshot.hasError){
                return Center(
                  child: Text("could not fetch data"),
                );
              }
              else if(snapshot.hasData){
                var mData=snapshot.data!.docs;
                return ListView.builder(
                  itemCount: mData.length,
                  itemBuilder: (_,index){
                    NoteModel currNote=NoteModel.fromMap(mData[index].data());
                  return ListTile(
                    title: Text('${currNote.title}'),
                    subtitle:Text('${currNote.desc}'),
                  );
                });
              }
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CollectionReference collRef = firestore.collection("notes");
          collRef
              .add(NoteModel(title: "hii", desc: "my favorite car").toMap())
              .then((value) {
                setState(() {
                  
                });
                 print("notes added");})
              .catchError((error) => print("failed to add notes $error"));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
