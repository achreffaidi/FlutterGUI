class IconManager{

  static getIconPath(FileType fileType){

    switch(fileType){
      case FileType.APP_CALCULATOR :  return  getPath("calculator");
      case FileType.PDF :  return  getPath("reader");
      case FileType.APP_YOUTUBE :  return  getPath("youtube");
      case FileType.APP_PAINTER :  return  getPath("painter");
      case FileType.APP_FILE_MANAGER :  return  getPath("folder");
      case FileType.FOLDER :  return  getPath("folder");
      default: return getPath("photos");
    }

  }

  static String getPath(String fileName){
    return "assets/$fileName.png";
  }
}


enum FileType {
  FOLDER,
  PICTURE,VIDEO,MUSIC,
  APP_CALCULATOR,APP_FILE_MANAGER,APP_YOUTUBE,APP_PAINTER,
  PDF
}

