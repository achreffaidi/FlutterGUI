import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mywebsite/Docker/dockerItem.dart';
import 'package:mywebsite/Util/fileManager/fileIconManager.dart';
import 'package:mywebsite/windows/WindowListener.dart';
import 'package:mywebsite/Docker/docker.dart';
import 'package:mywebsite/windows/WindowManager.dart';
import 'package:mywebsite/windows/draggableWindow.dart';
import 'package:mywebsite/windows/window.dart';
import 'package:mywebsite/extension.dart';

class HomeScreen extends StatefulWidget {

  static late WindowManager windowManager;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {







  @override
  void initState() {
    HomeScreen.windowManager = WindowManager( onUpdate:  (){
      setState(() {

    });});



    super.initState();
  }

  getPositioned(){
   return HomeScreen.windowManager.windows.reversed.map((e) => Positioned(
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
              child: Center(child: GestureDetector(child: Docker(_onDockerItemClicked)).showCursorOnHover)),
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
      HomeScreen.windowManager.startCalculatorApp();
    }else if(item.fileType == FileType.APP_PAINTER) {
      HomeScreen.windowManager.startPainterApp();
    }else if(item.fileType == FileType.APP_FILE_MANAGER){
      HomeScreen.windowManager.startFolderApp();
    }else{
      HomeScreen.windowManager.startVideoApp("h3uBr0CCm58");
    }
  }
}
