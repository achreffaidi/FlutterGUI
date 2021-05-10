import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutterOs/Util/fileManager/files/fileManager.dart';
import 'package:flutterOs/home.dart';
import 'package:flutterOs/windows/WindowManager.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<FileManager>(FileManager());
  getIt.registerSingleton<WindowManager>(WindowManager());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '⭐️FlutterGUI⭐️',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      home: HomeScreen(analytics: analytics,observer: observer,),
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
