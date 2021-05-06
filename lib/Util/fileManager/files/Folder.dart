import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutterOs/Util/fileManager/fileNode.dart';

class Folder extends FileNode{

  final List<FileNode> children;

  const Folder(String name,this.children) : super(name, FileType.FOLDER);

  List<Folder> getSubFolders(){
    List<FileNode> temp = List.from(children);
    temp.retainWhere((element) => element.fileType==FileType.FOLDER);
    return temp.map((e) => (e as Folder)).toList();
  }




}