import 'package:flutter/material.dart';
import 'dart:math';

import 'package:mywebsite/Docker/dockerItem.dart';
import 'package:mywebsite/Util/fileManager/fileIconManager.dart';

class Docker extends StatefulWidget {

  Function (DockItem item) callback;

  Docker(this.callback);

  @override
  _DockerState createState() => _DockerState();
}

class _DockerState extends State<Docker> {

  static const rad = 20.0;
  static const defaultSize = 40.0;
  static const off = 5.0;
  var _offest = 0.0;
  var currentIndex = -1;

  List<DockItem> items = [
    DockItem("Calculator", FileType.APP_CALCULATOR),
    DockItem("File Manager", FileType.APP_FILE_MANAGER),
    DockItem("youtube", FileType.APP_YOUTUBE),
    DockItem("Calculator", FileType.APP_CALCULATOR),
    DockItem("File Manager", FileType.APP_FILE_MANAGER),
    DockItem("youtube", FileType.APP_YOUTUBE),
    DockItem("Calculator", FileType.APP_CALCULATOR),
    DockItem("File Manager", FileType.APP_FILE_MANAGER),
    DockItem("youtube", FileType.APP_YOUTUBE),
    DockItem("Calculator", FileType.APP_CALCULATOR),
    DockItem("File Manager", FileType.APP_FILE_MANAGER),
    DockItem("youtube", FileType.APP_YOUTUBE),

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*(_offest==0?0.5:0.6),
      child: Stack(
        children: [

          Positioned(
            bottom: 0,
left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color.lerp(Colors.blue, Colors.transparent, 0.8),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(rad),
                      topRight: Radius.circular(rad),
                      bottomLeft: Radius.circular(rad),
                      bottomRight: Radius.circular(rad)
                  ),
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
                child: MouseRegion(
                  child: GestureDetector(
                    onTap: (){
                        widget.callback(items[currentIndex]);
                    },
                  ),
                  onHover: (event){
                    setState(() {
                      _offest = event.position.dx;
                      currentIndex =  ((_offest-460)/100 ).round();
                    });
                  },
                  onExit: (event){
                    setState(() {
                      _offest = 0 ;
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

  double getButtons(int x){
      if(_offest==0) return 0 ;
      var x1 = (_offest-460)/100 + 1;
      var z = (x - x1)*(x - x1) - 4 ;
      if(z>0) return 0 ;
      return sqrt(-z)*20;

  }

  List<Widget> getList(){
    List<Widget> list = [];
    for(int  i = 0 ; i<items.length;i++){
      var dx = getButtons(i);
      list.add(Column(
        children: [
          i == currentIndex? Card(child: Text(items[i].name)):Container(),
          Container(
            margin: EdgeInsets.only(bottom: getButtons(i)/3, right: (dx+defaultSize)/5,left: (dx+defaultSize)/5),
            height:  dx + defaultSize,
            width: dx + defaultSize,
            child: Image.asset(items[i].getIcon())
          ),
        ],
      ),);
    }
    return list ;

  }
}
