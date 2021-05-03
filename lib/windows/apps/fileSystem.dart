

import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:mywebsite/Util/fileManager/fileIconManager.dart';
import 'package:mywebsite/Util/fileManager/fileNode.dart';
import 'package:mywebsite/Util/fileManager/files/CustomFileImage.dart';
import 'package:mywebsite/Util/fileManager/files/fileManager.dart';
import 'package:mywebsite/Util/fileManager/files/Folder.dart';
import 'package:mywebsite/windows/window.dart';
import 'package:reorderables/reorderables.dart';

import '../WindowListener.dart';




class FolderApp extends Application {

   Folder currentFolder ;

   FolderApp( { required Key key,GlobalKey? appKey,  String? title,  WindowListener? listener, required this.currentFolder }) : super(key: key,appKey: appKey,title: title,listener: listener);
   @override
   double getHeight() {

     return 600;
   }

   @override
   double getWidth() {
     return 800;
   }
  

  @override
  _FolderAppState createState() => _FolderAppState(currentFolder);
}

class _FolderAppState extends ApplicationState {

  List<Folder> stack = List.empty(growable: true);

  _FolderAppState(Folder currentFolder){
    stack.add(currentFolder);
  }

  var _panelWidth = 150.0;

  @override
  Widget getApp(){
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

    return Container(
      height: widget.windowHeight,
      width: widget.windowWidth,
      child: Scaffold(
        appBar: AppBar(
          leading: Row(
            children: [
              IconButton(onPressed: (stack.length>1)? _onBackClicked : null, icon: Icon(Icons.arrow_back_ios))
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Row(
            children: [
              Container(

                width: _panelWidth,
                height: widget.windowHeight,
                child: Card(
                  color: Colors.blueGrey,
                ),
              ),
              Container(
                height: widget.windowHeight,
                width: widget.windowWidth - _panelWidth,
                child: SingleChildScrollView(
                  child: column,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  final double _iconSize = 90;
  List<Widget> _tiles = List.empty();

  @override
  void initState() {
    super.initState();
    updateTiles();
  }

  void updateTiles(){
    setState(() {
      _tiles = stack.first.children.map<Widget>((e) => GestureDetector(

        onDoubleTap: (){
          if(e.fileType == FileType.FOLDER){
            stack.insert(0, e as Folder);
            updateTiles();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 80, width: 80,child: _getImage(e),),
            Text(e.name)
          ],
        ),
      )).toList();
    });
  }


  void _onBackClicked() {
      stack.removeAt(0);
      updateTiles();
  }

  _getImage(FileNode e) {
    if(e.fileType==FileType.PICTURE){
     return Image.network((e as CustomFileImage).url);
    }

    return     Image.asset(IconManager.getIconPath(e.fileType));
  }
}