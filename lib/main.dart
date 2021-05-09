import 'package:flutter/material.dart';
import 'package:flutterOs/Util/fileManager/files/fileManager.dart';
import 'package:flutterOs/home.dart';
import 'package:get_it/get_it.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

void main() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<FileManager>(FileManager());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}


class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container() ,
    );
  }



}
