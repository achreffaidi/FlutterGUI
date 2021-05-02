import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mywebsite/Docker/dockerItem.dart';
import 'package:mywebsite/Util/fileManager/fileIconManager.dart';
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




  late WindowManager _windowManager;


  @override
  void initState() {
    print("INIT");
    _windowManager = WindowManager( onUpdate:  (){
      print("UPDATE");
      setState(() {

    });});



    super.initState();
  }

  getPositioned(){
   return _windowManager.windows.reversed.map((e) => Positioned(
     key: e.key,
        left: e.x,
        top: e.y,
        child: e)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network("https://blog.glugmvit.com/assets/images/first_app/flutter.jpg",fit: BoxFit.fill,),
          ),
          _getBody(),
          Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(child: GestureDetector(child: Docker(_onDockerItemClicked)).showCursorOnHover))
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

  _onDockerItemClicked(DockItem item) {
    if(item.fileType == FileType.APP_CALCULATOR){
      _windowManager.startCalculatorApp();
    }else if(item.fileType == FileType.APP_FILE_MANAGER) {
      _windowManager.startPdfApp();
    }else{
      _windowManager.startPainterApp();
    }
  }
}
