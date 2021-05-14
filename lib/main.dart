import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutterOs/Util/fileManager/files/fileManager.dart';
import 'package:flutterOs/home.dart';
import 'package:flutterOs/windows/WindowManager.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'Util/fileManager/AnalyticsService.dart';


void main() {

   FirebaseAnalytics analytics = FirebaseAnalytics();
   FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<FileManager>(FileManager());
  getIt.registerSingleton<WindowManager>(WindowManager());
  getIt.registerSingleton<AnalyticsService>(AnalyticsService(analytics,observer));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '⭐️FlutterGUI⭐️',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: GetIt.instance.get<AnalyticsService>().analytics),
      ],
      home: HomeScreen(),
    );
  }
}


