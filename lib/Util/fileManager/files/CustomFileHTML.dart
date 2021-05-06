import 'package:mywebsite/Util/fileManager/fileIconManager.dart';
import 'package:mywebsite/Util/fileManager/fileNode.dart';

class CustomFileHTML extends FileNode{

  final String fileName;

  const CustomFileHTML(String name,this.fileName) : super(name, FileType.HTML);

}