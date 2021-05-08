import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutterOs/Util/fileManager/files/CustomFileHTML.dart';
import 'package:flutterOs/Util/fileManager/files/CustomFileImage.dart';
import 'package:flutterOs/Util/fileManager/files/CustomFilePDF.dart';
import 'package:flutterOs/Util/fileManager/files/Folder.dart';

import '../fileNode.dart';
import 'CustomFileVideo.dart';

class FileManager {

  static final List<VoidCallback> listeners = List.empty(growable: true);

  static  Folder desktop = Folder("Desktop", [
    Folder("Pictures", [
      Folder("2021", [
        CustomFileImage("airplane.png", "1.jpeg"),
        CustomFileImage("arctichare.png", "3.jpeg"),
        CustomFileImage("baboon.png", "2.jpeg"),
        CustomFileImage("girl.png", "1.jpeg"),
        CustomFileImage("monarch.png", "3.jpeg"),
      ]),
      Folder("2022", []),
      Folder("2010", []),
      Folder("2011", []),
    ]),
    CustomFileImage("baboon.png", "2.jpeg"),
    Folder("Music", []),
    Folder("Movies", [
      CustomFileVideo(
          "Tears of Steel",
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
          "TearsOfSteel.jpeg"),
      CustomFileVideo(
          "Big Buck Bunny",
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
          "BigBuckBunny.jpeg"),
      CustomFileVideo(
          "Elephant Dream",
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
          "ElephantsDream.jpeg"),
    ]),
    CustomFileImage("airplane.png", "1.jpeg"),
    CustomFileVideo(
        "Tears of Steel",
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
        "TearsOfSteel.jpeg"),
    CustomFilePDF("resume3.pdf", "resume.pdf"),
    Folder("Documents", [
      CustomFilePDF("resume1.pdf", "resume.pdf"),
      CustomFilePDF("resume2.pdf", "resume.pdf"),
      CustomFilePDF("resume3.pdf", "resume.pdf"),
      CustomFilePDF("resume4.pdf", "resume.pdf"),
      CustomFilePDF("resume5.pdf", "resume.pdf"),
    ]),

    CustomFileVideo(
        "Big Buck Bunny",
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        "BigBuckBunny.jpeg"),
    CustomFilePDF("resume2.pdf", "resume.pdf"),
    CustomFilePDF("resume2.pdf", "resume.pdf"),
    CustomFileHTML("About me.html", "about_me"),
    CustomFileImage("arctichare.png", "3.jpeg"),


    CustomFilePDF("resume4.pdf", "resume.pdf"),

  ], canBeDeleted: false);

  static  Folder root  =  Folder("Root", [
      desktop,
      Folder("Pictures", [
        Folder("2021", [
          CustomFileImage("airplane.png", "1.jpeg"),
          CustomFileImage("arctichare.png", "3.jpeg"),
          CustomFileImage("baboon.png", "2.jpeg"),
          CustomFileImage("girl.png", "1.jpeg"),
          CustomFileImage("monarch.png", "3.jpeg"),
        ]),
        Folder("2022", []),
        Folder("2010", []),
        Folder("2011", []),
      ]),
      Folder("Music", []),
      Folder("Movies", [
        CustomFileVideo(
            "Tears of Steel",
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
            "TearsOfSteel.jpeg"),
        CustomFileVideo(
            "Big Buck Bunny",
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            "BigBuckBunny.jpeg"),
        CustomFileVideo(
            "Elephant Dream",
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
            "ElephantsDream.jpeg"),
      ]),
      Folder("Documents", [
        CustomFilePDF("resume1.pdf", "resume.pdf"),
        CustomFilePDF("resume2.pdf", "resume.pdf"),
        CustomFilePDF("resume3.pdf", "resume.pdf"),
        CustomFilePDF("resume4.pdf", "resume.pdf"),
        CustomFilePDF("resume5.pdf", "resume.pdf"),
      ]),
    ], canBeDeleted: false);

  static bool delete(FileNode file,Folder source ){
      for(int i = 0 ; i<source.children.length;i++){
        if(file == source.children.elementAt(i) && file.canBeDeleted){

          source.children.remove(source.children.elementAt(i));
          notifyListener();
          return true ;
        }else{
          if(source.children.elementAt(i).fileType == FileType.FOLDER){
            if (delete(file, (source.children.elementAt(i) as Folder))) return true;
          }
        }
      }
      return false;
  }

  static subscribeToListener(VoidCallback callback){
    listeners.add(callback);
  }

  static notifyListener(){
    for(var listener in listeners){
      listener();
    }
  }

}
