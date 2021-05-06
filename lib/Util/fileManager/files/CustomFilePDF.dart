import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutterOs/Util/fileManager/fileNode.dart';

class CustomFilePDF extends FileNode{

  final String path;

  const CustomFilePDF(String name,this.path) : super(name, FileType.PDF);

}