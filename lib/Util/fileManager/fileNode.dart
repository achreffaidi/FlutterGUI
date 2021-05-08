import 'dart:collection';
import 'dart:html';

import 'package:flutterOs/Util/fileManager/fileIconManager.dart';

abstract class FileNode extends LinkedListEntry<FileNode> {

  final String name;
  final FileType fileType;
  bool canBeDeleted;
   FileNode(this.name, this.fileType, {this.canBeDeleted = true});
}