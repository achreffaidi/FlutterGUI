import 'package:mywebsite/Util/fileManager/files/CustomFileImage.dart';
import 'package:mywebsite/Util/fileManager/files/Folder.dart';

class FileManager{


  static Folder getMainFolder(){

    return Folder("Main", [
      Folder("Pictures",[
        Folder("2021",[
          CustomFileImage("airplane.png", "https://homepages.cae.wisc.edu/~ece533/images/airplane.png"),
          CustomFileImage("arctichare.png", "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png"),
          CustomFileImage("baboon.png", "https://homepages.cae.wisc.edu/~ece533/images/baboon.png"),
          CustomFileImage("girl.png", "https://homepages.cae.wisc.edu/~ece533/images/girl.png"),
          CustomFileImage("monarch.png", "https://homepages.cae.wisc.edu/~ece533/images/monarch.png"),
        ]),
        Folder("2022",[]),
        Folder("2010",[]),
        Folder("2011",[]),
      ]),
      Folder("Music",[]),
      Folder("Movies",[]),
      Folder("Fun",[]),
    ]);


  }


}