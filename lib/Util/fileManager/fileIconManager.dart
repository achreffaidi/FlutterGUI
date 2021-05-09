class IconManager{

  static getIconPath(FileType fileType){

    switch(fileType){
      case FileType.APP_CALCULATOR :  return  getPath("calculator");
      case FileType.PDF :  return  getPath("reader");
      case FileType.APP_VIDEO_PLAYER :  return  getPath("youtube");
      case FileType.APP_PAINTER :  return  getPath("painter");
      case FileType.APP_FILE_MANAGER :  return  getPath("folder");
      case FileType.FOLDER :  return  getPath("folder");
      case FileType.VIDEO :  return  getPath("video");
      default: return getPath("photos");
    }

  }

  static String getPath(String fileName){
    return "assets/icons/$fileName.png";
  }
}


enum FileType {
  FOLDER,
  PICTURE,VIDEO,MUSIC,
  APP_CALCULATOR,APP_FILE_MANAGER,APP_VIDEO_PLAYER,APP_PAINTER,APP_IMAGE_PREVIEW,APP_PDF_READER,APP_HTML_READER,APP_MAZE_GAME,
  PDF,HTML
}

