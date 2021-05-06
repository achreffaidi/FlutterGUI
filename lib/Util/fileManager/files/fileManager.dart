import 'package:mywebsite/Util/fileManager/files/CustomFileHTML.dart';
import 'package:mywebsite/Util/fileManager/files/CustomFileImage.dart';
import 'package:mywebsite/Util/fileManager/files/CustomFilePDF.dart';
import 'package:mywebsite/Util/fileManager/files/Folder.dart';

import 'CustomFileVideo.dart';

class FileManager {
  static const Folder desktop = Folder("Desktop", [
    Folder("Pictures", [
      Folder("2021", [
        CustomFileImage("airplane.png", "1.jpeg"),
        CustomFileImage("arctichare.png", "3.jpeg"),
        CustomFileImage("baboon.png", "2.jpeg"),
        CustomFileImage("girl.png", "1.jpeg"),
        CustomFileImage("monarch.png", "3.jpeg"),
      ]),
      Folder("2022", []),
      Folder("2010", []),
      Folder("2011", []),
    ]),
    CustomFileImage("baboon.png", "2.jpeg"),
    Folder("Music", []),
    Folder("Movies", [
      CustomFileVideo(
          "Tears of Steel",
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
          "TearsOfSteel.jpeg"),
      CustomFileVideo(
          "Big Buck Bunny",
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
          "BigBuckBunny.jpeg"),
      CustomFileVideo(
          "Elephant Dream",
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
          "ElephantsDream.jpeg"),
    ]),
    CustomFileImage("airplane.png", "1.jpeg"),
    CustomFileVideo(
        "Tears of Steel",
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
        "TearsOfSteel.jpeg"),
    CustomFilePDF("resume3.pdf", "resume.pdf"),
    Folder("Documents", [
      CustomFilePDF("resume1.pdf", "resume.pdf"),
      CustomFilePDF("resume2.pdf", "resume.pdf"),
      CustomFilePDF("resume3.pdf", "resume.pdf"),
      CustomFilePDF("resume4.pdf", "resume.pdf"),
      CustomFilePDF("resume5.pdf", "resume.pdf"),
    ]),

    CustomFileVideo(
        "Big Buck Bunny",
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        "BigBuckBunny.jpeg"),
    CustomFilePDF("resume2.pdf", "resume.pdf"),
    CustomFilePDF("resume2.pdf", "resume.pdf"),
    CustomFileHTML("About me.html", "about_me"),
    CustomFileImage("arctichare.png", "3.jpeg"),


    CustomFilePDF("resume4.pdf", "resume.pdf"),

  ]);

  static const Folder root  =  Folder("Root", [
      desktop,
      Folder("Pictures", [
        Folder("2021", [
          CustomFileImage("airplane.png", "1.jpeg"),
          CustomFileImage("arctichare.png", "3.jpeg"),
          CustomFileImage("baboon.png", "2.jpeg"),
          CustomFileImage("girl.png", "1.jpeg"),
          CustomFileImage("monarch.png", "3.jpeg"),
        ]),
        Folder("2022", []),
        Folder("2010", []),
        Folder("2011", []),
      ]),
      Folder("Music", []),
      Folder("Movies", [
        CustomFileVideo(
            "Tears of Steel",
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
            "TearsOfSteel.jpeg"),
        CustomFileVideo(
            "Big Buck Bunny",
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            "BigBuckBunny.jpeg"),
        CustomFileVideo(
            "Elephant Dream",
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
            "ElephantsDream.jpeg"),
      ]),
      Folder("Documents", [
        CustomFilePDF("resume1.pdf", "resume.pdf"),
        CustomFilePDF("resume2.pdf", "resume.pdf"),
        CustomFilePDF("resume3.pdf", "resume.pdf"),
        CustomFilePDF("resume4.pdf", "resume.pdf"),
        CustomFilePDF("resume5.pdf", "resume.pdf"),
      ]),
    ]);

}
