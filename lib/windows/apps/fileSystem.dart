

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:flutter_treeview/tree_view.dart';
import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutterOs/Util/fileManager/fileNode.dart';
import 'package:flutterOs/Util/fileManager/files/CustomFileHTML.dart';
import 'package:flutterOs/Util/fileManager/files/CustomFileImage.dart';
import 'package:flutterOs/Util/fileManager/files/CustomFilePDF.dart';
import 'package:flutterOs/Util/fileManager/files/CustomFileVideo.dart';
import 'package:flutterOs/Util/fileManager/files/fileManager.dart';
import 'package:flutterOs/Util/fileManager/files/Folder.dart';
import 'package:flutterOs/windows/window.dart';
import 'package:reorderables/reorderables.dart';
import '../../home.dart';
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
  _FolderAppState createState() => _FolderAppState(currentFolder);
}

class _FolderAppState extends ApplicationState {

  List<Folder> stack = List.empty(growable: true);
  List<Node> nodes = List.empty(growable: true);
  late TreeViewController _treeViewController ;

  _FolderAppState(Folder currentFolder){
    stack.add(currentFolder);
  }

  var _defaultPanelWidth = 150.0;
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          leading: Row(
            children: [
              IconButton(onPressed: (stack.length>1)? _onBackClicked : null, icon: Icon(Icons.arrow_back_ios))
            ],
          ),
          title: Text(getPath(FileManager.root,stack.first)),
        ),
        body: Container(
          child: Row(
            children: [
              Container(

                width: _panelWidth,
                height: widget.windowHeight,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue,
                        Colors.white,
                        Colors.white,
                      ],
                    )
                ),
                child: getPane(),
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


  List<Widget> _tiles = List.empty();

  @override
  void initState() {
    super.initState();
    FileManager.subscribeToListener(updateTiles);
    updateTiles();
  }

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
      // Check if menu item clicked
      switch (menuItem) {
        case 1:
          onItemTap(e);
          break;
        case 2:
          FileManager.delete(e,FileManager.root);
          break;
        default:
      }
    }
  }

  void onItemTap(FileNode e){
    if(e.fileType == FileType.FOLDER){
      stack.insert(0, e as Folder);
      updateTiles();
    }else
    if(e.fileType==FileType.VIDEO){
      HomeScreen.windowManager.startVideoApp((e as CustomFileVideo).path);
    }
    else if(e.fileType==FileType.PICTURE){
      HomeScreen.windowManager.startPhotoPreviewApp("assets/photos/${(e as CustomFileImage).path}",null);
    }
    else if(e.fileType==FileType.PDF){
      HomeScreen.windowManager.startPdfApp("assets/pdf/${(e as CustomFilePDF).path}");
    }else if(e.fileType==FileType.HTML){
      HomeScreen.windowManager.startHtmlReader("assets/html/${(e as CustomFileHTML).fileName}.html");
    }
  }

  void updateTiles(){
    nodes = [FolderApp.convert(FileManager.root,isExpanded: true)];
    _treeViewController = TreeViewController(children: nodes);
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
              Container(height: 80, width: 80,child: FolderApp.getImage(e),),
              Text(e.name)
            ],
          ),
        ),
      )).toList();
    });
  }


  void _onBackClicked() {
      stack.removeAt(0);
      updateTiles();
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

  getPane() {
    return Stack(
      children: [
        TreeView(
          allowParentSelect: true,
          controller: _treeViewController,
          nodeBuilder: _nodeBuilder,
          onNodeTap: (key) {
            Node selectedNode = _treeViewController.getNode(key);
            stack.insert(0,selectedNode.data) ;
            updateTiles();
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
          color: isSelected? Color.lerp(Colors.blue, Colors.transparent, 0.5):Colors.transparent,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/icons/folder.png",height: 20,width: 20,),
              ),
              Text(node.data.name),
            ],
          ),
        );
  }
}