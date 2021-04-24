import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mywebsite/windows/WindowListener.dart';
import 'package:mywebsite/docker.dart';
import 'package:mywebsite/windows/WindowManager.dart';
import 'package:mywebsite/windows/draggableWindow.dart';
import 'package:mywebsite/windows/window.dart';
import 'package:mywebsite/extension.dart';

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {




  WindowManager _windowManager;


  @override
  void initState() {
    print("INIT");
    _windowManager = WindowManager( onUpdate:  (){
      print("UPDATE");
      setState(() {

    });});



      _windowManager.generateSimpleDraggableWindow("Window 1 ");
      _windowManager.generateSimpleDraggableWindow("Window 2 ");
      _windowManager.generateSimpleDraggableWindow("Window 3 ");
      _windowManager.generateSimpleDraggableWindow("Window 4 ");
      _windowManager.generateSimpleDraggableWindow("Window 5 ");
      _windowManager.generateSimpleDraggableWindow("Window 6 ");


    super.initState();
  }

  getPositioned(){
   return _windowManager.windows.reversed.map((e) => Positioned(
        left: e.x,
        top: e.y,
        child: e)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          _getBody(),
          Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(child: GestureDetector(child: Docker()).showCursorOnHover))
        ],
      ),
    );
  }

  Widget _getBody() {

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: getPositioned(),
      ),
    );
  }
}
