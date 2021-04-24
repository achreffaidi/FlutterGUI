import 'package:flutter/widgets.dart';
import 'package:mywebsite/windows/draggableWindow.dart';
import 'package:mywebsite/windows/window.dart';

import 'WindowListener.dart';

class WindowManager{

  final VoidCallback onUpdate;


  WindowManager({this.onUpdate});

  List<DraggableWindow> windows = List.empty(growable: true);


  void generateSimpleDraggableWindow(String title){

    var key = UniqueKey();
    final draggableWindow =  DraggableWindow(
      key: key ,
      childWidget: WindowBody(title: title));

    draggableWindow.setListener((){

          windows.remove(draggableWindow);

          windows.insert(0, draggableWindow);

          onUpdate();

    });


    draggableWindow.childWidget.setListener(WindowListener(
        onClose: (window){
          windows.remove(draggableWindow);
          onUpdate();
        }));

    windows.add(draggableWindow);

    onUpdate();
  }


}