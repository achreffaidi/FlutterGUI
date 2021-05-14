

import 'package:flutter/material.dart';
import 'package:flutterOs/Util/fileManager/consts/colors.dart';
import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:maze/maze.dart';
import 'package:flutterOs/windows/window.dart';

import '../WindowListener.dart';




class MazeGameApp extends Application {



   MazeGameApp( { required Key key,GlobalKey? appKey,  String? title,  WindowListener? listener }) : super(key: key,appKey: appKey,title: title,listener: listener);
   @override
   double getHeight() {
     return 400;
   }

   @override
   double getWidth() {
     return 400;
   }
   @override
   FileType getFileType() {
     return FileType.APP_MAZE_GAME;
   }
  

  @override
  _MazeGameState createState() => _MazeGameState();
}

class _MazeGameState extends ApplicationState {

  MazeStatus _status = MazeStatus.idle;
  MazeDifficulty _difficulty = MazeDifficulty.easy;
  int size = 0;

  @override
  Widget getApp() {


     switch(_status){
      case MazeStatus.idle: return Container(
        height: widget.windowHeight,
        width: widget.windowWidth,
        color: Resources.WINDOW_BODY_COLOR,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Choose difficulty",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800),),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Radio<MazeDifficulty>(
                    value: MazeDifficulty.easy,
                    groupValue: _difficulty,
                    onChanged: _handleRadioValueChange,
                  ),
                  new Text(
                    'Easy',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  new Radio<MazeDifficulty>(
                    value: MazeDifficulty.medium,
                    groupValue: _difficulty,
                    onChanged: _handleRadioValueChange,
                  ),
                  new Text(
                    'Medium',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  new Radio<MazeDifficulty>(
                    value: MazeDifficulty.hard,
                    groupValue: _difficulty,
                    onChanged: _handleRadioValueChange,
                  ),
                  new Text(
                    'Hard',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              ElevatedButton(onPressed: (){
                setState(() {
                  switch(_difficulty){
                    case MazeDifficulty.easy: size = 5; break;
                    case MazeDifficulty.medium: size = 20;break;
                    case MazeDifficulty.hard: size = 40;break;
                  }
                  _status = MazeStatus.playing;
                });
              }, child: Text("Start"))
            ],
          ),
        ),
      );
       case MazeStatus.playing: return Container(
         height: widget.windowHeight,
         width: widget.windowWidth,
         color: Resources.WINDOW_BODY_COLOR,
         child: Maze(
             player: MazeItem(
                 'assets/photos/game/pug.png',
                 ImageType.asset),
             columns: size,
             rows: size,
             wallThickness: 4.0,
             wallColor: Theme
                 .of(context)
                 .primaryColor,
             finish: MazeItem(
                 'assets/photos/game/bone.png',
                 ImageType.asset),
             onFinish: (){
               setState(() {
                 _status = MazeStatus.end;
               });
             }),
       );
       case MazeStatus.end: return Container(
         color: Resources.WINDOW_BODY_COLOR,
         height: widget.windowHeight,
         width: widget.windowWidth,
         child: Container(
           child:
              Image.asset(getAssetPath(_difficulty))
         ),
       );
      default: return Container();
    }


    
  }

  String getAssetPath(MazeDifficulty difficulty){
    String fileName;
    switch(difficulty){
      case MazeDifficulty.easy: fileName = "easy";break;
      case MazeDifficulty.medium: fileName = "medium";break;
      case MazeDifficulty.hard: fileName = "hard";break;
    }
    return "assets/mazeResources/$fileName.jpeg";

  }

  void _handleRadioValueChange(MazeDifficulty? value) {
    setState(() {
      _difficulty = value!;
    });
  }

}

enum MazeStatus{idle,playing,end}
enum MazeDifficulty{easy,medium,hard}