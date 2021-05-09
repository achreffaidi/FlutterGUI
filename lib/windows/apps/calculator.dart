

import 'package:flutter/material.dart';
import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:flutterOs/windows/window.dart';

import '../WindowListener.dart';




class CalculatorApp extends Application {



   CalculatorApp( { required Key key,GlobalKey? appKey,  String? title,  WindowListener? listener }) : super(key: key,appKey: appKey,title: title,listener: listener);
   @override
   double getHeight() {
     return 250;
   }

   @override
   double getWidth() {
     return 400;
   }
   @override
   FileType getFileType() {
     return FileType.APP_CALCULATOR;
   }
  

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends ApplicationState {





  @override
  Widget getApp(){
    return Container(
      height: widget.windowHeight,
      width: widget.windowWidth,
      child: SimpleCalculator(
        theme: const CalculatorThemeData(
          displayColor: Colors.black,
          displayStyle: const TextStyle(fontSize: 80, color: Colors.yellow),
        ),
      ),
    );
  }



}