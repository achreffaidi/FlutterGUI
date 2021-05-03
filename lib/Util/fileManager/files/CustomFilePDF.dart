import 'package:mywebsite/Util/fileManager/fileIconManager.dart';
import 'package:mywebsite/Util/fileManager/fileNode.dart';

class CustomFilePDF extends FileNode{

  String path;

  CustomFilePDF(String name,this.path) : super(name, FileType.PDF);

}