import 'package:mywebsite/Util/fileManager/fileIconManager.dart';
import 'package:mywebsite/Util/fileManager/fileNode.dart';

class CustomFileVideo extends FileNode{

  String path;
  String thumbnail;

  CustomFileVideo(String name,this.path,this.thumbnail) : super(name, FileType.VIDEO);

}