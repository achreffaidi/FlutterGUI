import 'package:flutter/widgets.dart';
import 'package:mywebsite/windows/apps/pdfReader.dart';
import 'package:mywebsite/windows/draggableWindow.dart';

import 'WindowListener.dart';
import 'apps/calculator.dart';

class WindowManager{

  final VoidCallback onUpdate;


  WindowManager({required this.onUpdate});

  List<DraggableWindow> windows = List.empty(growable: true);


  void startCalculatorApp(){

    var key = UniqueKey();
    var appKey = GlobalKey();
    final draggableWindow =  DraggableWindow(
      key: key ,
      childWidget: CalculatorApp(key: key,appKey: appKey, title: "Calculator"), feedback: () {  },);

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

  void startPdfApp(){

    var key = UniqueKey();
    var appKey = GlobalKey();

    final draggableWindow =  DraggableWindow(
      key: key ,
      childWidget: PdfReaderApp(title: "Pdf Reader",appKey: appKey), feedback: () {  },);

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


  void generateSimpleDraggableWindow(String title){

    var key = GlobalKey();
    final draggableWindow =  DraggableWindow(
      key: key ,
      childWidget: CalculatorApp(key: key,title: title), feedback: () {  },);

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