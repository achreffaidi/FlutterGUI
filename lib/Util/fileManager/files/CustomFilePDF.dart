import 'package:mywebsite/Util/fileManager/fileIconManager.dart';
import 'package:mywebsite/Util/fileManager/fileNode.dart';

class CustomFilePDF extends FileNode{

  final String path;

  const CustomFilePDF(String name,this.path) : super(name, FileType.PDF);

}