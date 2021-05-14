

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutterOs/windows/window.dart';
import 'package:photo_view/photo_view.dart';

import '../WindowListener.dart';




class PhotoPreviewApp extends Application {



   String? path;
   Uint8List? memory;
   PhotoPreviewApp( { required Key key,GlobalKey? appKey,  String? title,  WindowListener? listener , required this.path,required this.memory}) : super(key: key,appKey: appKey,title: title,listener: listener){
    assert ((path != null) ^ (memory !=null),"You should provide a path to the asset or the image in memory, and not both.");
   }
   @override
   double getHeight() {
     if(path!=null)
     return Image.asset(path!).height ?? 400;
     return Image.memory(memory!).height??400;
   }

   @override
   double getWidth() {
     if(path!=null)
       return Image.asset(path!).width ?? 400;
     return Image.memory(memory!).width??400;
   }
   @override
   FileType getFileType() {
     return FileType.APP_IMAGE_PREVIEW;
   }
  

  @override
  _PhotoPreviewAppState createState() => _PhotoPreviewAppState(path,memory);
}

class _PhotoPreviewAppState extends ApplicationState {
  String? path;
  Uint8List? memory;
  _PhotoPreviewAppState(this.path,this.memory);

  @override
  Widget getApp(){
    return Container(
      height: widget.windowHeight,
      width: widget.windowWidth,
      child:  Container(
    child: PhotoView(
      backgroundDecoration: BoxDecoration(
        color: Colors.white,
      ),
    imageProvider: path==null? MemoryImage(memory!)  : AssetImage(path!) as ImageProvider,
    )
    )
    );
  }




}