import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cursor/flutter_cursor.dart';
import 'package:mywebsite/windows/WindowListener.dart';
import 'package:screenshot/screenshot.dart';

abstract class Application extends StatefulWidget {
  String? title;
  WindowListener? listener;
  GlobalKey? appKey;
  Application({Key? key, this.appKey, this.title, this.listener})
      : super(key: key){
     windowWidth = getWidth();
     windowHeight = getHeight();
  }

  Function(double, double)? callback;

  late double windowWidth ;
  late double windowHeight ;
  var headerHeight = 30.0;
  bool canResize = true;

  double getWidth();
  double getHeight();

  get currentWidth => windowWidth;
  get currentHeight => windowHeight+headerHeight;

  void setListener(WindowListener listener) {
    this.listener = listener;
  }


}

abstract class ApplicationState extends State<Application> {



  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.windowHeight + widget.headerHeight,
      width: widget.windowWidth,
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
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x54000000),
                    spreadRadius: 4,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _getHeader(),
                  _getBody()
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
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeLeftRight,
                  opaque: true,
                  child: Container(
                    width: 4,
                  ),
                ),
              )),
          Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onHorizontalDragUpdate: _onHorizontalDragLeft,
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeLeftRight,
                  opaque: true,
                  child: Container(
                    width: 4,
                  ),
                ),
              )),
          Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: GestureDetector(
                onVerticalDragUpdate: _onHorizontalDragTop,
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeUpDown,
                  opaque: true,
                  child: Container(
                    height: 4,
                  ),
                ),
              )),
          Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onVerticalDragUpdate: _onHorizontalDragBottom,
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeUpDown,
                  opaque: true,
                  child: Container(
                    height: 4,
                  ),
                ),
              )),
          Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onPanUpdate: _onHorizontalDragBottomRight,
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeUpLeftDownRight,
                  opaque: true,
                  child: Container(
                    height: 6,
                    width: 6,
                  ),
                ),
              )),
          Positioned(
              bottom: 0,
              left: 0,
              child: GestureDetector(
                onPanUpdate: _onHorizontalDragBottomLeft,
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeUpRightDownLeft,
                  opaque: true,
                  child: Container(
                    height: 6,
                    width: 6,
                  ),
                ),
              )),
          Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onPanUpdate: _onHorizontalDragTopRight,
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeUpRightDownLeft,
                  opaque: true,
                  child: Container(
                    height: 6,
                    width: 6,
                  ),
                ),
              )),
          Positioned(
              left: 0,
              top: 0,
              child: GestureDetector(
                onPanUpdate: _onHorizontalDragTopLeft,
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeUpLeftDownRight,
                  opaque: true,
                  child: Container(
                    height: 6,
                    width: 6,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  _getHeader() {
    return GestureDetector(
      onPanUpdate: (tapInfo) {
        widget.callback!(tapInfo.delta.dx, tapInfo.delta.dy);
      },
      child: Container(
          width: widget.windowWidth,
          height: widget.headerHeight,
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
                    _getCircleButton(Colors.red, Icons.close, callback: () {
                      widget.listener!.onClose!(widget);
                    }),
                    _getCircleButton(Colors.orangeAccent, Icons.remove,
                        callback: () {
                      widget.listener!.onResize!(widget);
                    },
                    onDoubleClick: (){
                      widget.listener!.onAppCrash!(widget);
                    }
                    ),
                    _getCircleButton(Colors.green, Icons.fullscreen)
                  ],
                ),
              ),
              Center(
                  child:
                      Title(color: Colors.white, child: Text(widget.title!))),
              Container()
            ],
          )),
    );
  }

  _getBody() {
    return Container(
        child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            child: getApp()));
  }


  Widget getApp();

  _getCircleButton(Color color, IconData iconData, {VoidCallback? callback, VoidCallback? onDoubleClick}) {
    return InkResponse(
      onTap: callback,
      onDoubleTap: onDoubleClick,
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

    if(!widget.canResize) return;
    setState(() {
      widget.windowWidth -= details.delta.dx;
      if (widget.windowWidth < widget.getWidth()) {
        widget.windowWidth = widget.getWidth();
      } else {
        widget.callback!(details.delta.dx, 0);
      }
    });
  }

  void _onHorizontalDragRight(DragUpdateDetails details) {
    if(!widget.canResize) return;
    setState(() {
      widget.windowWidth += details.delta.dx;
      if (widget.windowWidth < widget.getWidth()) {
        widget.windowWidth = widget.getWidth();
      }
    });
  }

  void _onHorizontalDragBottom(DragUpdateDetails details) {
    if(!widget.canResize) return;
    setState(() {
      widget.windowHeight += details.delta.dy;
      if (widget.windowHeight < widget.getHeight()) {
        widget.windowHeight = widget.getHeight();
      }
    });
  }

  void _onHorizontalDragTop(DragUpdateDetails details) {
    if(!widget.canResize) return;
    setState(() {
      widget.windowHeight -= details.delta.dy;
      if (widget.windowHeight < widget.getHeight()) {
        widget.windowHeight = widget.getHeight();
      } else {
        widget.callback!(0, details.delta.dy);
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
