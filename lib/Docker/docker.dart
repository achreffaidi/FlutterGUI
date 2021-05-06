import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutterOs/Docker/dockerItem.dart';
import 'package:flutterOs/Util/fileManager/fileIconManager.dart';

class Dock extends StatefulWidget {

  Function (DockItem item) callback;

  Dock(this.callback);

  @override
  _DockState createState() => _DockState();
}

class _DockState extends State<Dock> {

  static const rad = 15.0;
  static const _defaultSize = 40.0;
  var _offset = 0.0;
  var currentIndex = -1;
  late double _dockerWidth;

  List<DockItem> items = [
    DockItem("Calculator", FileType.APP_CALCULATOR),
    DockItem("File Manager", FileType.APP_FILE_MANAGER),
    DockItem("resume", FileType.PDF),
    DockItem("Painter", FileType.APP_PAINTER),
    DockItem("File Manager", FileType.APP_FILE_MANAGER),
    DockItem("youtube", FileType.APP_YOUTUBE),
    DockItem("Calculator", FileType.APP_CALCULATOR),
    DockItem("File Manager", FileType.APP_FILE_MANAGER),
    DockItem("Painter", FileType.APP_PAINTER),
    DockItem("youtube", FileType.APP_YOUTUBE),
    DockItem("Painter", FileType.APP_PAINTER),
  ];

  @override
  Widget build(BuildContext context) {

    _dockerWidth = MediaQuery.of(context).size.width*(_offset==0?0.5:0.6);
    return Container(
      width: _dockerWidth,
      child: Stack(
        children: [

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Color.lerp(Colors.black, Colors.transparent, 0.8),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                child: MouseRegion(
                  child: GestureDetector(
                    onTap: (){
                        widget.callback(items[currentIndex]);
                    },
                  ),
                  onHover: (event){
                    setState(() {
                      _offset = event.localPosition.dx;
                      currentIndex =  (getOffset()).round();
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
        ],
      ),
    );
  }

  double getOffset(){
    return (_offset)/(items.length*_defaultSize/5);
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
    for(int  i = 0 ; i<items.length;i++){
      var dx = getButtons(i,x1);
      list.add(Expanded(
        child: Column(
          children: [
            i == currentIndex && _offset!= 0? Card(
                color: Color.lerp(Colors.black, Colors.transparent, 0.5),
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8),
              child: Text(items[i].name,style: TextStyle(color: Colors.white,fontSize: 10,),textAlign: TextAlign.center,),
            )):Container(),
            Container(
              margin: EdgeInsets.only(bottom: dx/3),
              height:   _defaultSize + dx,
              width:  _defaultSize + dx,
              child: Image.asset(items[i].getIcon())
            ),
          ],
        ),
      ),);
    }
    return list ;

  }
}
