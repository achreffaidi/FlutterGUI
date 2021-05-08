import 'dart:collection';

import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutterOs/Util/fileManager/fileNode.dart';

class Folder extends FileNode{

  LinkedList<FileNode> children = LinkedList();


   Folder(String name,List <FileNode> children,{bool canBeDeleted = true}) : super(name, FileType.FOLDER,canBeDeleted: canBeDeleted){
     this.children.addAll(children);
   }

  List<Folder> getSubFolders(){
    List<FileNode> temp = List.from(children);
    temp.retainWhere((element) => element.fileType==FileType.FOLDER);
    return temp.map((e) => (e as Folder)).toList();
  }




}