import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutterOs/Util/fileManager/fileNode.dart';
import 'package:flutterOs/Util/fileManager/files/CustomFileHTML.dart';
import 'package:flutterOs/Util/fileManager/files/CustomFileImage.dart';
import 'package:flutterOs/Util/fileManager/files/CustomFilePDF.dart';
import 'package:flutterOs/Util/fileManager/files/CustomFileVideo.dart';
import 'package:flutterOs/Util/fileManager/files/Folder.dart';
import 'package:flutterOs/windows/WindowManager.dart';
import 'package:get_it/get_it.dart';
import 'package:reorderables/reorderables.dart';

import '../../../home.dart';
import '../FilesApp.dart';

class FileTails extends StatefulWidget {

  late Function(FileNode)? onFolderClick;
  late  Function(FileNode)? onFileNodeDelete;
  List<Folder> stack;
  FileTails(this.stack,{this.onFolderClick,this.onFileNodeDelete});

  @override
  _FileTailsState createState() => _FileTailsState(stack);
}

class _FileTailsState extends State<FileTails> {

  List<Folder> stack;
  WindowManager _windowManager = GetIt.instance.get<WindowManager>();
  _FileTailsState(this.stack);

  @override
  void initState() {
    super.initState();
    generateTiles();
  }

  @override
  Widget build(BuildContext context) {

    generateTiles();

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
    return column;
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      Widget row = _tiles.removeAt(oldIndex);
      _tiles.insert(newIndex, row);
    });
  }

  List<Widget> _tiles = List.empty();

  Future<void> _onPointerDown(PointerDownEvent event, FileNode e) async {
    // Check if right mouse button clicked
    if (event.kind == PointerDeviceKind.mouse &&
        event.buttons == kSecondaryMouseButton) {
      final overlay =
      Overlay.of(context)!.context.findRenderObject() as RenderBox;
      final menuItem = await showMenu<int>(
          context: context,
          items: [
            PopupMenuItem(child: Text('Open'), value: 1),
            PopupMenuItem(child: Text('Remove'), value: 2),
          ],
          position: RelativeRect.fromSize(
              event.position & Size(48.0, 48.0), overlay.size));

      Future.delayed(const Duration(milliseconds: 100), null);

      switch (menuItem) {
        case 1:
          onItemTap(e);
          break;
        case 2:
          widget.onFileNodeDelete!(e);
          break;
        default:
      }
    }
  }

  void onItemTap(FileNode e) async {
    if(e.fileType == FileType.FOLDER){
      widget.onFolderClick!(e);
      generateTiles();
    }else
    if(e.fileType==FileType.VIDEO){
      _windowManager.startVideoApp((e as CustomFileVideo).path);
    }
    else if(e.fileType==FileType.PICTURE){
      _windowManager.startPhotoPreviewApp("assets/photos/${(e as CustomFileImage).path}",null);
    }
    else if(e.fileType==FileType.PDF){
      _windowManager.startPdfApp("assets/pdf/${(e as CustomFilePDF).path}");
    }else if(e.fileType==FileType.HTML){
      _windowManager.startHtmlReader("assets/html/${(e as CustomFileHTML).fileName}.html");
    }
  }

  void generateTiles(){
    setState(() {
      _tiles = stack.first.children.map<Widget>((e) => GestureDetector(


        onDoubleTap: (){
          onItemTap(e);

        },
        child: Listener(
          onPointerDown: (event) => _onPointerDown(event,e),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 80, width: 80,child: FilesApp.getImage(e),),
              Text(e.name)
            ],
          ),
        ),
      )).toList();
    });
  }


}
