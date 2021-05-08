import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutterOs/Util/fileManager/fileNode.dart';

class CustomFileHTML extends FileNode{

  final String fileName;

   CustomFileHTML(String name,this.fileName) : super(name, FileType.HTML);

}