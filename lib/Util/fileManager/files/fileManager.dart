import 'package:mywebsite/Util/fileManager/files/Folder.dart';

class FileManager{


  static Folder getMainFolder(){

    return Folder("Main", [
      Folder("Pictures",[
        Folder("2021",[]),
        Folder("2022",[]),
        Folder("2010",[]),
        Folder("2011",[]),
      ]),
      Folder("Music",[]),
      Folder("Drive",[]),
      Folder("Fun",[]),
    ]);


  }


}