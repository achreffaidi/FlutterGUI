import 'package:mywebsite/Util/fileManager/fileIconManager.dart';

abstract class FileNode{

  String name;
  FileType fileType;

  FileNode(this.name, this.fileType);
}