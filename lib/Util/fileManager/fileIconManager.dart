class FileManager { 

}


class IconManager{

  static getIconPath(FileType fileType){

    switch(fileType){
      case FileType.APP_CALCULATOR :  return  getPath("calculator");
      case FileType.APP_FILE_MANAGER :  return  getPath("folder");
      case FileType.APP_YOUTUBE :  return  getPath("youtube");
      case FileType.APP_PAINTER :  return  getPath("painter");
      default: return getPath("photos");
    }

  }

  static String getPath(String fileName){
    return "assets/$fileName.png";
  }
}


enum FileType {
  PICTURE,VIDEO,MUSIC,
  APP_CALCULATOR,APP_FILE_MANAGER,APP_YOUTUBE,APP_PAINTER,
  PDF
}

