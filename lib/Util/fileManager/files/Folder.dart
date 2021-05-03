import 'package:mywebsite/Util/fileManager/fileIconManager.dart';
import 'package:mywebsite/Util/fileManager/fileNode.dart';

class Folder extends FileNode{

  List<FileNode> children;

  Folder(String name,this.children) : super(name, FileType.FOLDER);





}