

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterOs/Util/fileManager/consts/colors.dart';
import 'package:flutterOs/windows/apps/widgets/fileTiles.dart';
import 'package:flutter_treeview/tree_view.dart';
import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutterOs/Util/fileManager/fileNode.dart';
import 'package:flutterOs/Util/fileManager/files/CustomFileImage.dart';
import 'package:flutterOs/Util/fileManager/files/CustomFileVideo.dart';
import 'package:flutterOs/Util/fileManager/files/fileManager.dart';
import 'package:flutterOs/Util/fileManager/files/Folder.dart';
import 'package:flutterOs/windows/window.dart';
import 'package:get_it/get_it.dart';
import '../WindowListener.dart';




class FilesApp extends Application {

   Folder currentFolder ;

   FilesApp( { required Key key,GlobalKey? appKey,  String? title,  WindowListener? listener, required this.currentFolder }) : super(key: key,appKey: appKey,title: title,listener: listener);
   @override
   double getHeight() {

     return 600;
   }

   @override
   double getWidth() {
     return 800;
   }
   @override
   FileType getFileType() {
     return FileType.APP_FILE_MANAGER;
   }

   static getImage(FileNode e) {



     if(e.fileType==FileType.PICTURE){
       return
          Material(
            elevation: 6,
            color: Colors.transparent,
            child: Container(

             decoration: BoxDecoration(
                 border: Border.all(color: Colors.white,width:4)
             ),
             child: Image.asset("assets/photos/${(e as CustomFileImage).path}")),
          );


     }
     if(e.fileType==FileType.VIDEO){
       return ClipRRect(
           borderRadius: BorderRadius.all(
             Radius.circular(10),
           ),
           child: Image.asset("assets/thumbnails/${(e as CustomFileVideo).thumbnail}"));
     }

     return     Image.asset(IconManager.getIconPath(e.fileType));
   }

   static Node<Folder> convert(Folder folder,{bool isExpanded = false}){
     List<Node<Folder>> children = [];
     for(var child in folder.children){
       if(child.fileType==FileType.FOLDER) children.insert(0, convert(child as Folder));
     }
     return Node<Folder>(
         label: folder.name,
         data: folder,
         children: children,
         expanded: isExpanded,
         key: folder.hashCode.toString()
     );
   }
  

  @override
  _FilesAppState createState() => _FilesAppState(currentFolder);
}

class _FilesAppState extends ApplicationState {

  List<Folder> stack = List.empty(growable: true);
  List<Node> nodes = List.empty(growable: true);
  late TreeViewController _treeViewController ;

  _FilesAppState(Folder currentFolder){
    stack.add(currentFolder);
  }

  var _defaultPanelWidth = 150.0;
  var _panelWidth = 150.0;

  @override
  Widget getApp(){

    nodes = [FilesApp.convert(_fileManager.root,isExpanded: true)];
    _treeViewController = TreeViewController(children: nodes);

    return Container(
      height: widget.windowHeight,
      width: widget.windowWidth,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.lerp(Colors.blue, Colors.transparent, 0.2),
          leading: Row(
            children: [
              IconButton(onPressed: (stack.length>1)? _onBackClicked : null, icon: Icon(Icons.arrow_back_ios))
            ],
          ),
          title: Text(getPath(_fileManager.root,stack.first)),
        ),
        body: Container(
          child: Row(
            children: [
              Container(

                width: _panelWidth,
                height: widget.windowHeight,
                color: Color.lerp(Colors.blue, Colors.transparent, 0.2),
                child: getPane(),
              ),
              Container(
                height: widget.windowHeight,
                width: widget.windowWidth - _panelWidth,
                color: Resources.WINDOW_BODY_COLOR,
                child: SingleChildScrollView(
                  child: Container(
                    child: FileTails(
                        stack,
                        fromFileManagerApp: true,
                        onFolderOpen: (e){
                          stack.insert(0, e as Folder);
                          setState(() {

                          });
                        },
                      onFileNodeDelete: (e){
                          _fileManager.delete(e, _fileManager.root);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  late FileManager _fileManager;
  @override
  void initState() {
    super.initState();
    _fileManager = GetIt.instance.get<FileManager>();
    _fileManager.subscribeToListener((){
      setState(() {

      });
    });
  }

  void _onBackClicked() {
      stack.removeAt(0);
      setState(() {

      });
  }

  void _onHorizontalDragRight(DragUpdateDetails details) {
    setState(() {
      if(_panelWidth<widget.windowWidth/2 || details.delta.dx<0 )
      _panelWidth += details.delta.dx;
      if (_panelWidth < _defaultPanelWidth) {
        _panelWidth = _defaultPanelWidth;
      }
    });
  }

  TreeViewTheme _treeViewTheme = TreeViewTheme(
    expanderTheme: ExpanderThemeData(
      type: ExpanderType.chevron,
      color: Colors.white,
      animated: true,
      size: 20,
    ),
  );

  getPane() {
    return Stack(
      children: [
        TreeView(
          allowParentSelect: true,
          controller: _treeViewController,
          nodeBuilder: _nodeBuilder,
          theme: _treeViewTheme,
          onNodeTap: (key) {
            Node selectedNode = _treeViewController.getNode(key);
            stack.insert(0,selectedNode.data) ;
            setState(() {

            });
          },
        ),
        Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onHorizontalDragUpdate: _onHorizontalDragRight,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeLeftRight,
                opaque: true,
                child: Container(
                  width: 4,
                ),
              ),
            )),
      ],
    );
  }

  getPath(Folder folder,Folder dist){
    if(folder==dist) return folder.name;
    for(var f in folder.getSubFolders()){

      var x = getPath(f, dist);
      if(x!=null){
        return folder.name + " > "+ x;
      }
    }
    return null;
  }



  _nodeBuilder(BuildContext buildContext, Node<dynamic> node) {
    var isSelected = node.data == stack.first;
    return
        Container(
          decoration: BoxDecoration(
              color: isSelected? Color.lerp(Colors.blue, Colors.transparent, 0.5):Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),

          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/icons/folder.png",height: 20,width: 20,),
              ),
              Text(node.data.name,style: TextStyle(color: Colors.white),),
            ],
          ),
        );
  }



}