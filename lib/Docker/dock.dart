import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterOs/Docker/dockController.dart';
import 'dart:math';

import 'package:flutterOs/Docker/dockItem.dart';
import 'package:flutterOs/Util/fileManager/fileIconManager.dart';

class Dock extends StatefulWidget {


  DockController controller;

  Dock({required this.controller});

  @override
  _DockState createState() => _DockState();
}

class _DockState extends State<Dock> {

  static const rad = 15.0;
  static const _defaultSize = 40.0;
  var _offset = 0.0;
  var currentIndex = -1;
  late double _dockerWidth;



   final double itemWidth = 100.0;

  @override
  Widget build(BuildContext context) {

    _dockerWidth = itemWidth * widget.controller.items.length;

    return Container(
      width: _dockerWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: [

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color.lerp(Colors.blue, Colors.transparent, 0.2),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(rad),
                    topRight: Radius.circular(rad),
                    bottomLeft: Radius.circular(rad),
                    bottomRight: Radius.circular(rad)
                ),
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: getList()
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(rad),
                      topRight: Radius.circular(rad),
                      bottomLeft: Radius.circular(rad),
                      bottomRight: Radius.circular(rad)
                  ),
                ),
                child: Listener(
                  onPointerDown: (action){
                    _onPointerDown(action,currentIndex);
                  },
                  child: MouseRegion(
                    child: GestureDetector(
                      onTap: (){
                          widget.controller.callback(widget.controller.items[currentIndex]);
                      },
                    ),
                    onHover: (event){
                      setState(() {
                        _offset = event.localPosition.dx;
                        currentIndex =  (getOffset()).toInt();
                      });
                    },
                    onExit: (event){
                      setState(() {
                        _offset = 0 ;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onPointerDown(PointerDownEvent event, int currentIndex) async {
    // Check if right mouse button clicked

    DockItem item = widget.controller.items[currentIndex];

    List<PopupMenuEntry<int>> menuItems;

    if(item.isActive){
      menuItems = [
        PopupMenuItem(child: Text('Show all'), value: 1),
        PopupMenuItem(child: Text('Hide all'), value: 2),
        PopupMenuItem(child: Text('Close all'), value: 3),
      ];
      if(item.alwaysVisible){
        menuItems.insert(0, PopupMenuItem(child: Text('Open new'), value: 0));
      }
    }else if(item.alwaysVisible){
      menuItems = [
        PopupMenuItem(child: Text('Open'), value: 0),
      ];
    }else {
      menuItems = [];
    }

    if (event.kind == PointerDeviceKind.mouse &&
        event.buttons == kSecondaryMouseButton) {
      final overlay =
      Overlay.of(context)!.context.findRenderObject() as RenderBox;
      final menuItem = await showMenu<int>(
          context: context,
          items: menuItems,
          position: RelativeRect.fromSize(
              event.position & Size(48.0, 48.0), overlay.size));

      Future.delayed(const Duration(milliseconds: 100), null);

      switch (menuItem) {
        case 0:
         // open;
        widget.controller.openOfType(item.fileType);
          break;
        case 1:
         // show all;
          widget.controller.showAllOfType(item.fileType);
          break;
        case 2:
        // hide all;
          widget.controller.hideAllOfType(item.fileType);
          break;
        case 3:
        // close all;
          widget.controller.closeAllOfType(item.fileType);
          break;
        default:
      }
    }
  }

  double getOffset(){
    return _offset/itemWidth;
  }

  double getButtons(int x, double x1){
      if(_offset==0) return 0 ;
      var z = (x - x1)*(x - x1) - 3 ;
      if(z>0) return 0 ;
      return sqrt(-z)*20;

  }


  List<Widget> getList(){
    var x1 = getOffset();
    List<Widget> list = [];
    for(int  i = 0 ; i<widget.controller.items.length;i++){
      var dx = getButtons(i,x1);
      list.add(Expanded(
        child: Container(
          child: Column(
            children: [
              i == currentIndex && _offset!= 0? Card(
                  color: Color.lerp(Colors.black, Colors.transparent, 0.5),
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8),
                child: Text(widget.controller.items[i].name,style: TextStyle(color: Colors.white,fontSize: 10,),textAlign: TextAlign.center,),
              )):Container(),
              Container(
                margin: EdgeInsets.only(bottom: dx/3),
                height:   _defaultSize + dx,
                width:  _defaultSize + dx,
                child: Image.asset(widget.controller.items[i].getIcon())
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: widget.controller.items[i].isActive? Material(
                    elevation: 4,
                    color: Colors.transparent,
                    child: Icon(Icons.circle,color: Colors.white,size: 5,)):Container(),
              )
            ],
          ),
        ),
      ),);
    }
    return list ;

  }
}
