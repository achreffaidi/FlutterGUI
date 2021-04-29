import 'package:flutter/material.dart';
import 'package:mywebsite/windows/window.dart';

class DraggableWindow extends StatefulWidget {

  final WindowBody childWidget;

  VoidCallback feedback;
  double x = 0 ;
  double y = 0;

  DraggableWindow({Key? key, required this.childWidget,required this.feedback}) : super(key: key);

  void setListener(VoidCallback listener){
    feedback = listener;
  }

  @override
  DraggableWindowState createState() => DraggableWindowState();
}

class DraggableWindowState extends State<DraggableWindow> {




  @override
  Widget build(BuildContext context) {
    return Draggable(

    child: widget.childWidget,
    feedback: Material(
      color: Colors.transparent,
      child: Opacity(
        opacity: 0.5,
        child: widget.childWidget),),
    childWhenDragging: Container(),

    onDragEnd: (dragDetails) {
    widget.x = dragDetails.offset.dx;
    widget.y = dragDetails.offset.dy ;
    widget.feedback();
    },
    );
  }
}
