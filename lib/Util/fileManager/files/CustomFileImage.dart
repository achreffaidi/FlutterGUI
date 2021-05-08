import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutterOs/Util/fileManager/fileNode.dart';

class CustomFileImage extends FileNode{

  final String path;

   CustomFileImage(String name,this.path) : super(name, FileType.PICTURE);

}