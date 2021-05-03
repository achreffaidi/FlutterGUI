

import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:mywebsite/windows/window.dart';
import 'package:photo_view/photo_view.dart';

import '../WindowListener.dart';




class PhotoPreviewApp extends Application {



   String path;
   PhotoPreviewApp( { required Key key,GlobalKey? appKey,  String? title,  WindowListener? listener , required this.path}) : super(key: key,appKey: appKey,title: title,listener: listener);
   @override
   double getHeight() {
     return Image.asset(path).height ?? 400;
   }

   @override
   double getWidth() {
     return Image.asset(path).width ?? 400;
   }
  

  @override
  _PhotoPreviewAppState createState() => _PhotoPreviewAppState(path);
}

class _PhotoPreviewAppState extends ApplicationState {
  String path;
  _PhotoPreviewAppState(this.path);






  @override
  Widget getApp(){
    return Container(
      height: widget.windowHeight,
      width: widget.windowWidth,
      child:  Container(
    child: PhotoView(
    imageProvider: AssetImage(path),
    )
    )
    );
  }



}