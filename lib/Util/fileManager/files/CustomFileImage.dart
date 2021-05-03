import 'package:mywebsite/Util/fileManager/fileIconManager.dart';
import 'package:mywebsite/Util/fileManager/fileNode.dart';

class CustomFileImage extends FileNode{

  String url;

  CustomFileImage(String name,this.url) : super(name, FileType.PICTURE);

}