import 'package:mywebsite/Util/fileManager/fileIconManager.dart';
import 'package:mywebsite/Util/fileManager/fileNode.dart';

class CustomFileImage extends FileNode{

  final String path;

  const CustomFileImage(String name,this.path) : super(name, FileType.PICTURE);

}