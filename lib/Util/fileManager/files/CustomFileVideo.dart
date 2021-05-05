import 'package:mywebsite/Util/fileManager/fileIconManager.dart';
import 'package:mywebsite/Util/fileManager/fileNode.dart';

class CustomFileVideo extends FileNode{

  final String path;
  final String thumbnail;

  const CustomFileVideo(String name,this.path,this.thumbnail) : super(name, FileType.VIDEO);

}