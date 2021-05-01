import 'package:mywebsite/Util/fileManager/fileIconManager.dart';

class DockItem {
  String name ;
  FileType fileType;
  DockItem(this.name, this.fileType);

  String getIcon(){
    return IconManager.getIconPath(fileType);
  }

  String getName(){
    return name;
  }

}