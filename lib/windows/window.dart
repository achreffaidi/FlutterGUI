import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cursor/flutter_cursor.dart';
import 'package:mywebsite/windows/WindowListener.dart';

abstract class Application extends StatefulWidget {


        String? title;
        WindowListener? listener;
        GlobalKey? appKey;
        Application({Key? key,this.appKey, this.title, this.listener}) : super(key: key);

        Function(double,double)? callback;


        void setListener(WindowListener listener){
    this.listener = listener;
  }


}


abstract class ApplicationState extends State<Application> {

  late double windowWidth ;
  late double windowHeight ;
  var headerHeight = 30.0;

  @override
  void initState() {
    super.initState();
     windowWidth = getWidth();
     windowHeight = getHeight();
  }



  @override
  Widget build(BuildContext context) {

   

    return Container(
      height: windowHeight+headerHeight,
      width:  windowWidth,
      key: widget.appKey,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                //Here goes the same radius, u can put into a var or function
                borderRadius:
                BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x54000000),
                    spreadRadius:4,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _getHeader(),
                  _getBody(),
                ],
              ),
            ),
          ),


          Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(

                onHorizontalDragUpdate: _onHorizontalDragRight,
                child:
                MouseRegion(
                  cursor: SystemMouseCursors.resizeLeftRight,
                  opaque: true,
                  child: Container(
                    width: 4,
                  ),
                )
                ,
              )),
          Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child:

              GestureDetector(

                onHorizontalDragUpdate: _onHorizontalDragLeft,
                child:
                MouseRegion(
                  cursor: SystemMouseCursors.resizeLeftRight,
                  opaque: true,
                  child: Container(
                    width: 4,
                  ),
                )
                ,
              )

            ),
          Positioned(
              left: 0,
              top: 0,
              right: 0,
              child:  GestureDetector(

                onVerticalDragUpdate: _onHorizontalDragTop,
                child:
                MouseRegion(
                  cursor: SystemMouseCursors.resizeUpDown,
                  opaque: true,
                  child: Container(
                    height: 4,
                  ),
                )
                ,
              )),
          Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: GestureDetector(

                onVerticalDragUpdate: _onHorizontalDragBottom,
                child:
                MouseRegion(
                  cursor: SystemMouseCursors.resizeUpDown,
                  opaque: true,
                  child: Container(
                    height: 4,
                  ),
                )
                ,
              )),

          Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(

                onPanUpdate: _onHorizontalDragBottomRight,
                child:
                MouseRegion(
                  cursor: SystemMouseCursors.resizeUpLeftDownRight,
                  opaque: true,
                  child: Container(
                    height: 6,
                    width: 6,
                  ),
                )
                ,
              )),
          Positioned(
              bottom: 0,
              left: 0,
              child: GestureDetector(

                onPanUpdate: _onHorizontalDragBottomLeft,
                child:
                MouseRegion(
                  cursor: SystemMouseCursors.resizeUpRightDownLeft,
                  opaque: true,
                  child: Container(
                    height: 6,
                    width: 6,
                  ),
                )
                ,
              )),
          Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(

                onPanUpdate: _onHorizontalDragTopRight,
                child:
                MouseRegion(
                  cursor: SystemMouseCursors.resizeUpRightDownLeft,
                  opaque: true,
                  child: Container(
                    height: 6,
                    width: 6,
                  ),
                )
                ,
              )),
          Positioned(
              left: 0,
              top: 0,
              child: GestureDetector(

                onPanUpdate: _onHorizontalDragTopLeft,
                child:
                MouseRegion(
                  cursor: SystemMouseCursors.resizeUpLeftDownRight,
                  opaque: true,
                  child: Container(
                    height: 6,
                    width: 6,
                  ),
                )
                ,
              )),

        ],
      ),
    );
  }

  _getHeader() {

    return GestureDetector(
        onPanUpdate: (tapInfo) {
          widget.callback!(tapInfo.delta.dx,tapInfo.delta.dy);
          },
      child: Container(
        width: windowWidth,
        height: headerHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
          ),
        ),
        child: Stack(
          children: [

            Positioned(

              left: 10,
              top: 10,
              bottom: 10,

              child: Row(
                children: [
                  _getCircleButton(Colors.red, Icons.close,callback: (){
                    widget.listener!.onWindowClose(widget);
                  }),
                  _getCircleButton(Colors.orangeAccent, Icons.remove),
                  _getCircleButton(Colors.green, Icons.fullscreen)
                ],
              ),
            ),
            Center(child: Title(color: Colors.white, child: Text(widget.title!))),
            Container()
          ],
        )
      ),
    );

  }

  _getBody() {
    return Container(

        child: ClipRRect(

            borderRadius:
            BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
            ),
            child: getApp()));
  }

  double getWidth();
  double getHeight();
  Widget getApp();


  

  _getCircleButton(Color color, IconData iconData, {VoidCallback? callback}){

    return InkResponse(
      onTap: callback,
      child: new Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        width: 12,
        height: 12,
        decoration: new BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          size: 10,
          color: Color.lerp(Colors.black, Colors.transparent, 0.5),
        ),
      ),
    );

  }


  void _onHorizontalDragLeft(DragUpdateDetails details) {


    setState(() {
      windowWidth -= details.delta.dx;
      if(windowWidth< getWidth()){
        windowWidth = getWidth();
      }else{
        widget.callback!(details.delta.dx, 0 );
      }
    });

  }
  void _onHorizontalDragRight(DragUpdateDetails details) {


    setState(() {
      windowWidth += details.delta.dx;
      if(windowWidth< getWidth()){
        windowWidth = getWidth();
      }
    });

  }

  void _onHorizontalDragBottom(DragUpdateDetails details) {


    setState(() {
      windowHeight += details.delta.dy;
      if(windowHeight< getHeight()){
        windowHeight = getHeight();
      }
    });

  }

  void _onHorizontalDragTop(DragUpdateDetails details) {


    setState(() {
      windowHeight -= details.delta.dy;
      if(windowHeight< getHeight()){
        windowHeight = getHeight();
      }else{
        widget.callback!(0, details.delta.dy );
      }
    });

  }
  
  

  void _onHorizontalDragBottomRight(DragUpdateDetails details) {
    _onHorizontalDragRight(details);
    _onHorizontalDragBottom(details);
  }
  void _onHorizontalDragBottomLeft(DragUpdateDetails details) {
    _onHorizontalDragLeft(details);
    _onHorizontalDragBottom(details);
  }
  void _onHorizontalDragTopRight(DragUpdateDetails details) {
    _onHorizontalDragRight(details);
    _onHorizontalDragTop(details);
  }
  void _onHorizontalDragTopLeft(DragUpdateDetails details) {
    _onHorizontalDragLeft(details);
    _onHorizontalDragTop(details);
  }
}
