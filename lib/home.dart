import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterOs/Docker/dockerItem.dart';
import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutterOs/Util/fileManager/files/Folder.dart';
import 'package:flutterOs/Util/fileManager/files/fileManager.dart';
import 'package:flutterOs/Docker/docker.dart';
import 'package:flutterOs/windows/WindowManager.dart';
import 'package:flutterOs/extension.dart';
import 'package:flutterOs/windows/apps/widgets/fileTiles.dart';
import 'package:get_it/get_it.dart';


class HomeScreen extends StatefulWidget {
  static late WindowManager windowManager;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FileManager _fileManager;

  @override
  void initState() {
    super.initState();
    _fileManager = GetIt.instance.get<FileManager>();
    document.onContextMenu.listen((event) => event.preventDefault());
    HomeScreen.windowManager = WindowManager(onUpdate: () {
      setState(() {});
    });
    _fileManager.subscribeToListener((){
      setState(() {

      });
    });
  }

  getPositioned() {
    var size = MediaQuery.of(context).size;
    return HomeScreen.windowManager.windows.reversed.map((e) {
      if (e.x == -1) {
        e.x = (size.width - e.childWidget.getWidth()) / 2;
        e.y = (size.height - e.childWidget.getHeight()) / 2;
      }
      return Positioned(key: e.key, left: e.x, top: e.y, child: e);
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              "https://blog.glugmvit.com/assets/images/first_app/flutter.jpg",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
                height: 500,
                width: 500,
                child: FileTails(
                  [_fileManager.desktop],
                  onFolderClick: (e) {
                    HomeScreen.windowManager
                        .startFolderApp(folder: e as Folder);
                  },
                  onFileNodeDelete: (e) {
                    _fileManager.delete(e, _fileManager.desktop);
                  },
                )),
          ),
          _getBody(),
          Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                  child: GestureDetector(child: Dock(_onDockerItemClicked))
                      .showCursorOnHover)),
        ],
      ),
    );
  }

  Widget _getBody() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: getPositioned(),
      ),
    );
  }

  _onDockerItemClicked(DockItem item) {
    if (item.fileType == FileType.APP_CALCULATOR) {
      HomeScreen.windowManager.startCalculatorApp();
    } else if (item.fileType == FileType.APP_PAINTER) {
      HomeScreen.windowManager.startPainterApp();
    } else if (item.fileType == FileType.APP_FILE_MANAGER) {
      HomeScreen.windowManager.startFolderApp();
    } else {
      HomeScreen.windowManager.startMazeGame();
    }
  }
}
