import 'package:flutter/cupertino.dart';
import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutterOs/Util/fileManager/files/CustomFileHTML.dart';
import 'package:flutterOs/Util/fileManager/files/CustomFileImage.dart';
import 'package:flutterOs/Util/fileManager/files/CustomFilePDF.dart';
import 'package:flutterOs/Util/fileManager/files/Folder.dart';

import '../fileNode.dart';
import 'CustomFileVideo.dart';

class FileManager {
  late Folder _desktop, _root;
  List<VoidCallback> _listeners = List.empty(growable: true);

  Folder get desktop => _desktop;
  Folder get root => _root;

  FileManager() {
    _desktop = Folder(
        "Desktop",
        [
          Folder("Don't Open", [
            Folder("You think you're smart!", [
              CustomFileImage("easily-fooled-you-are.jpeg", "easily-fooled-you-are.jpeg"),
            ]),
          ]),
          CustomFileHTML("FlutterGUI.html", "about_flutter_gui"),
          CustomFileHTML("AboutMe.html", "about_me"),
          CustomFileImage("Ex-Cat.jpeg", "1.jpeg"),
          CustomFilePDF("resume.pdf", "resume.pdf"),
          CustomFileHTML("MyInstagram.html", "my_instagram"),
          CustomFileImage("MyCountry.jpg", "instagram/insta1.jpg"),
          CustomFileImage("StreetCat.jpg", "instagram/insta2.jpg"),
          CustomFileImage("randomChicken.jpg", "instagram/insta3.jpg"),
        ],
        canBeDeleted: false);
    _root = Folder(
        "Root",
        [
          _desktop,
          Folder("Pictures", [
            Folder("memes", [
              CustomFileImage("meme1.jpg", "memes/meme1.jpg"),
              CustomFileImage("meme2.jpg", "memes/meme2.jpg"),
              CustomFileImage("meme3.jpg", "memes/meme3.jpg"),
              CustomFileImage("meme4.jpg", "memes/meme4.jpg"),
              CustomFileImage("meme5.jpg", "memes/meme5.jpg"),
              CustomFileImage("meme6.jpg", "memes/meme6.jpg"),
              CustomFileImage("meme7.jpg", "memes/meme7.jpg"),
              CustomFileImage("meme8.jpg", "memes/meme8.jpg"),
              CustomFileImage("meme9.jpg", "memes/meme9.jpg"),
              CustomFileImage("meme10.jpg", "memes/meme10.jpg"),
              CustomFileImage("meme11.jpg", "memes/meme11.jpg"),
              CustomFileImage("meme12.jpg", "memes/meme12.jpg"),
              CustomFileImage("meme13.jpg", "memes/meme13.jpg"),
              CustomFileImage("meme14.jpg", "memes/meme14.jpg"),
              CustomFileImage("meme15.jpg", "memes/meme15.jpg"),
              CustomFileImage("meme16.jpg", "memes/meme16.jpg"),
              CustomFileImage("meme17.jpg", "memes/meme17.jpg"),
              CustomFileImage("meme18.jpg", "memes/meme18.jpg"),
              CustomFileImage("meme19.jpg", "memes/meme19.jpg"),
              CustomFileImage("meme20.jpg", "memes/meme20.jpg"),
              CustomFileImage("meme21.jpg", "memes/meme21.jpg"),
              CustomFileImage("meme22.jpg", "memes/meme22.jpg"),
              CustomFileImage("meme23.jpg", "memes/meme23.jpg"),
              CustomFileImage("meme24.jpg", "memes/meme24.jpg"),
              CustomFileImage("meme25.jpg", "memes/meme25.jpg"),
              CustomFileImage("meme26.jpg", "memes/meme26.jpg"),
            ]),
            Folder("Instagram", [
              CustomFileHTML("MyInstagram.html", "my_instagram"),
              CustomFileImage("insta1.jpg", "instagram/insta1.jpg"),
              CustomFileImage("insta2.jpg", "instagram/insta2.jpg"),
              CustomFileImage("insta3.jpg", "instagram/insta3.jpg"),
              CustomFileImage("insta4.jpg", "instagram/insta4.jpg"),
              CustomFileImage("insta5.jpg", "instagram/insta5.jpg"),
              CustomFileImage("insta6.jpg", "instagram/insta6.jpg"),
              CustomFileImage("insta7.jpg", "instagram/insta7.jpg"),
              CustomFileImage("insta8.jpg", "instagram/insta8.jpg"),
              CustomFileImage("insta9.jpg", "instagram/insta9.jpg"),
              CustomFileImage("insta10.jpg", "instagram/insta10.jpg"),
              CustomFileImage("insta11.jpg", "instagram/insta11.jpg"),
              CustomFileImage("insta12.jpg", "instagram/insta12.jpg"),
              CustomFileImage("insta13.jpg", "instagram/insta13.jpg"),
              CustomFileImage("insta14.jpg", "instagram/insta14.jpg"),

            ]),
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
            CustomFileVideo(
                "Sintel",
                "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
                "Sintel.jpeg"),
          ]),
          Folder("Documents", [
            CustomFilePDF("resume.pdf", "resume.pdf"),
            CustomFilePDF("crypto.pdf", "crypto.pdf"),
            CustomFileHTML("FlutterGUI.html", "about_flutter_gui"),
            CustomFileHTML("AboutMe.html", "about_me"),
          ]),
        ],
        canBeDeleted: false);
  }

  // Delete a File starting from room.
  bool delete(FileNode file, Folder root) {
    for (int i = 0; i < root.children.length; i++) {
      if (file == root.children.elementAt(i) && file.canBeDeleted) {
        root.children.remove(root.children.elementAt(i));
        notifyListener();
        return true;
      } else {
        if (root.children.elementAt(i).fileType == FileType.FOLDER) {
          if (delete(file, (root.children.elementAt(i) as Folder))) return true;
        }
      }
    }
    return false;
  }

  subscribeToListener(VoidCallback callback) {
    _listeners.add(callback);
  }

  // Notify Listeners when a file is deleted.
  notifyListener() {
    for (var listener in _listeners) {
      try {
        listener();
      } catch (e) {}
    }
  }
}
