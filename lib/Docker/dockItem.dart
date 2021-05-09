import 'package:flutterOs/Util/fileManager/fileIconManager.dart';

class DockItem {
  String name ;
  FileType fileType;
  bool isActive = false;
  bool alwaysVisible ;
  DockItem(this.name, this.fileType,this.alwaysVisible);

  String getIcon(){
    return IconManager.getIconPath(fileType);
  }

  String getName(){
    return name;
  }

}