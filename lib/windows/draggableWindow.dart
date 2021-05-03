import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mywebsite/windows/window.dart';
import 'package:screenshot/screenshot.dart';

import 'apps/screenshot.dart';

class DraggableWindow extends StatefulWidget {

  final Application childWidget;

  VoidCallback feedback;
  VoidCallback? onCrash;
  double x = 0 ;
  double y = 0;
  bool isCrashed = false;
  Key key = UniqueKey();
  Uint8List? screenshot;



  DraggableWindow({Key? key, required this.childWidget,required this.feedback,this.onCrash}) : super(key: key);

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

class DraggableWindowState extends State<DraggableWindow> {


  @override
  void initState() {
    super.initState();
    widget.childWidget.callback = (x,y){
      setState(() {
        widget.x += x;
        widget.y += y;
        widget.feedback();
      });
    };
  }


  @override
  Widget build(BuildContext context) {
    return Screenshot(
        controller: widget.screenshotController,
          child: widget.childWidget,
        );
  }
}
