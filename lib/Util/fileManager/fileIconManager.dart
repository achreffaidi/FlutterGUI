class IconManager{

  static getIconPath(FileType fileType){

    switch(fileType){
      case FileType.APP_CALCULATOR :  return  getPath("ic_calculator");
      case FileType.APP_PDF_READER :  return  getPath("ic_pdf");
      case FileType.APP_VIDEO_PLAYER :  return  getPath("ic_video");
      case FileType.APP_PAINTER :  return  getPath("ic_paint");
      case FileType.APP_MAZE_GAME :  return  getPath("ic_game");
      case FileType.APP_FILE_MANAGER :  return  getPath("ic_files");
      case FileType.APP_HTML_READER :  return  getPath("ic_html");
      case FileType.APP_IMAGE_PREVIEW :  return  getPath("ic_photo");
      case FileType.FOLDER :  return  getPath("folder");
      case FileType.VIDEO :  return  getPath("ic_video");
      case FileType.PDF :  return  getPath("ic_pdf_file");
      case FileType.HTML :  return  getPath("ic_html_file");
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

