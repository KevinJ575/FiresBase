import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),

      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("todoclass").snapshots(),
          builder: (context, snapshot ) {
            if (!snapshot.hasData) return const Text('cargando datos...');

            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, Index) =>  ListTile(
                  leading: const Icon(Icons.task_alt),
                  title: Text('Numero de tareas ${snapshot.data!.docs[Index].data()["number"]}'),
                  subtitle: Text(snapshot.data!.docs[Index]['name']),


                ));

          }),


      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print('hola');
        },
        tooltip: 'agregar nueva tarea',
        child: const Icon(Icons.add),
      ),
    );
  }
}
