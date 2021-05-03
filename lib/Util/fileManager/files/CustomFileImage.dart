import 'package:mywebsite/Util/fileManager/fileIconManager.dart';
import 'package:mywebsite/Util/fileManager/fileNode.dart';

class CustomFileImage extends FileNode{

  String path;

  CustomFileImage(String name,this.path) : super(name, FileType.PICTURE);

}