import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mywebsite/Docker/dockerItem.dart';
import 'package:mywebsite/Util/fileManager/fileIconManager.dart';
import 'package:mywebsite/Util/fileManager/files/Folder.dart';
import 'package:mywebsite/Util/fileManager/files/fileManager.dart';
import 'package:mywebsite/windows/WindowListener.dart';
import 'package:mywebsite/Docker/docker.dart';
import 'package:mywebsite/windows/WindowManager.dart';
import 'package:mywebsite/windows/apps/fileSystem.dart';
import 'package:mywebsite/windows/draggableWindow.dart';
import 'package:mywebsite/windows/window.dart';
import 'package:mywebsite/extension.dart';
import 'package:reorderables/reorderables.dart';

import 'Util/fileManager/files/CustomFileHTML.dart';
import 'Util/fileManager/files/CustomFileImage.dart';
import 'Util/fileManager/files/CustomFilePDF.dart';
import 'Util/fileManager/files/CustomFileVideo.dart';

class HomeScreen extends StatefulWidget {

  static late WindowManager windowManager;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  var desktopFolder = FileManager.desktop;

  @override
  void initState() {
    HomeScreen.windowManager = WindowManager( onUpdate:  (){
      setState(() {

    });});

    updateTiles();

    super.initState();
  }

  getPositioned(){
   return HomeScreen.windowManager.windows.reversed.map((e) => Positioned(
     key: e.key,
        left: e.x,
        top: e.y,
        child: e)).toList();
  }
  List<Widget> _tiles = List.empty();

  @override
  Widget build(BuildContext context) {

    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = _tiles.removeAt(oldIndex);
        _tiles.insert(newIndex, row);
      });
    }

    var wrap = ReorderableWrap(
        spacing: 8.0,
        runSpacing: 4.0,
        padding: const EdgeInsets.all(8),
        children: _tiles,

        onReorder: _onReorder,
        onNoReorder: (int index) {
          //this callback is optional
          debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
        },
        onReorderStarted: (int index) {
          //this callback is optional
          debugPrint('${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
        }
    );
    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        wrap,
      ],
    );


    return Scaffold(
      body:Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network("https://blog.glugmvit.com/assets/images/first_app/flutter.jpg",fit: BoxFit.fill,),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
                height: 500,
                width: 500,
                child: column),
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
      HomeScreen.windowManager.startMazeGame();
    }
  }


  //TODO Refactor this, redundant code in fileSystem.dart
  void updateTiles(){
    setState(() {
      _tiles = desktopFolder.children.map<Widget>((e) => GestureDetector(

        onDoubleTap: (){
          if(e.fileType == FileType.FOLDER){
            HomeScreen.windowManager.startFolderApp(folder: e as Folder);
            updateTiles();
          }else
          if(e.fileType==FileType.VIDEO){
            HomeScreen.windowManager.startVideoApp((e as CustomFileVideo).path);
          }
          else if(e.fileType==FileType.PICTURE){
            HomeScreen.windowManager.startPhotoPreviewApp("assets/photos/${(e as CustomFileImage).path}");
          }
          else if(e.fileType==FileType.PDF){
            HomeScreen.windowManager.startPdfApp("assets/pdf/${(e as CustomFilePDF).path}");
          }else if(e.fileType==FileType.HTML){
            HomeScreen.windowManager.startHtmlReader("assets/html/${(e as CustomFileHTML).fileName}.html");
          }

        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 80, width: 80,child: FolderApp.getImage(e),),
            Text(e.name)
          ],
        ),
      )).toList();
    });
  }


}
