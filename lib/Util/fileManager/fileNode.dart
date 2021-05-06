import 'package:flutterOs/Util/fileManager/fileIconManager.dart';

abstract class FileNode{

  final String name;
  final FileType fileType;

  const FileNode(this.name, this.fileType);
}