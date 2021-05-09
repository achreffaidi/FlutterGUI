import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutterOs/windows/window.dart';
import 'package:screenshot/screenshot.dart';

import 'apps/screenshot.dart';

class DraggableWindow extends StatefulWidget {

  final Application childWidget;

  VoidCallback feedback;
  double x = -1 ;
  double y = -1;
  late double prevX = 0 ;
  late double prevY = 0 ;
  bool isVisible = true;

  bool isCrashed = false;
  Key key = UniqueKey();
  Uint8List? screenshot;
  bool isFullScreen = false;


  DraggableWindow({Key? key, required this.childWidget,required this.feedback}) : super(key: key);

  ScreenshotController screenshotController = ScreenshotController();

  Future<DraggableWindow> getScreenShotWidget() async {


    if(screenshot==null){
      screenshot = await screenshotController.capture();
    }
    var screenshotWidget = DraggableWindow(childWidget:
    CrashedApp(appKey: GlobalKey(),key: UniqueKey(),width: childWidget.currentWidth,height: childWidget.currentHeight,image: screenshot!,), feedback: () {  },);
    screenshotWidget.x = x;
    screenshotWidget.y = y;
    return screenshotWidget ;
  }

  void setListener(VoidCallback listener){
    feedback = listener;
  }

  @override
  DraggableWindowState createState() => DraggableWindowState();
}

class DraggableWindowState extends State<DraggableWindow> with SingleTickerProviderStateMixin {


  late AnimationController animationController;
  late Animation animation;
  var dx = 0.0;
  var dy = 0.0 ;

  @override
  void initState() {
    super.initState();
    widget.childWidget.draggableOnResizeListener = onFullScreenClick;
    widget.childWidget.callback = (x,y){
      widget.isFullScreen = false;
      setState(() {
        widget.x += x;
        widget.y += y;
        widget.feedback();
      });
    };

    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    animation = IntTween(begin: 0,end: 100).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    animation.addListener(() {


          widget.x = widget.prevX - animation.value*dx/100;
          widget.y = widget.prevY - animation.value*dy/100;

     widget.feedback();
    });

  }

  void onFullScreenClick(){
    if(widget.isFullScreen){
      dx =   widget.prevX;
      dy =  widget.prevY;
      animationController.animateTo(0);
      widget.isFullScreen = false;
    }else{
      widget.prevX = widget.x;
      widget.prevY = widget.y;

      dx =  widget.x ;
      dy = widget.y ;

      animationController.forward();

      widget.isFullScreen = true;
    }
    widget.feedback();
  }


  @override
  Widget build(BuildContext context) {
    return Screenshot(
        controller: widget.screenshotController,
          child: widget.childWidget,
        );
  }
}
