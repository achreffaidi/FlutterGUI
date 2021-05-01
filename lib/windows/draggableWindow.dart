import 'package:flutter/material.dart';
import 'package:mywebsite/windows/window.dart';

class DraggableWindow extends StatefulWidget {

  final Application childWidget;

  VoidCallback feedback;
  double x = 0 ;
  double y = 0;
  Key key = UniqueKey();
  DraggableWindow({Key? key, required this.childWidget,required this.feedback}) : super(key: key);

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
        print(x);
        widget.x += x;
        widget.y += y;
        widget.feedback();
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return widget.childWidget;
  }
}
