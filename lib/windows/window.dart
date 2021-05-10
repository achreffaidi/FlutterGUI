import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterOs/Util/fileManager/consts/colors.dart';
import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutterOs/windows/WindowListener.dart';

abstract class Application extends StatefulWidget {
  String? title;
  WindowListener? listener;
  late VoidCallback? draggableOnResizeListener;
  GlobalKey? appKey;
  Application({Key? key, this.appKey, this.title, this.listener})
      : super(key: key){
     windowWidth = getWidth();
     windowHeight = getHeight();
  }

  Function(double, double)? callback;
  late double windowWidth ;
  late double prevWindowWidth ;
  late double windowHeight ;
  late double prevWindowHeight ;
  bool isFullScreen = false;
  var headerHeight = 30.0;
  bool canResize = true;

  double getWidth();
  double getHeight();
  FileType getFileType();

  get currentWidth => windowWidth;
  get currentHeight => windowHeight+headerHeight;



  void setListener(WindowListener listener) {
    this.listener = listener;
  }

}

abstract class ApplicationState extends State<Application> with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation animation;

  var dx = 0.0;
  var dy = 0.0 ;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    animation = IntTween(begin: 0,end: 100).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    animation.addListener(() {
      setState(() {
          widget.windowWidth = widget.prevWindowWidth + animation.value*dx/100;
          widget.windowHeight = widget.prevWindowHeight + animation.value*dy/100;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.windowHeight + widget.headerHeight,
      width: widget.windowWidth,
      key: widget.appKey,
      child: Stack(
        children: [
          Positioned.fill(

            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0),
                ),
              ),),
          ),
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
      onDoubleTap: _onResizeButtonClicked,
      onPanUpdate: (tapInfo) {
        widget.callback!(tapInfo.delta.dx, tapInfo.delta.dy);
      },
      child: Container(
          width: widget.windowWidth,
          height: widget.headerHeight,
          decoration: BoxDecoration(
            color: Resources.WINDOW_HEADER_COLOR,
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
                    _getCircleButton(Colors.red, callback: () {
                      widget.listener!.onClose!(widget);
                    }),
                    _getCircleButton(Colors.orangeAccent,
                        callback: () {
                      widget.listener!.onHide!(widget);
                    },
                    onDoubleClick: (){
                      widget.listener!.onAppCrash!(widget);
                    }
                    ),
                    _getCircleButton(Colors.green,callback: _onResizeButtonClicked
                    )
                  ],
                ),
              ),
              Center(
                  child:
                      Title(color: Colors.white, child: Text(widget.title!,style: TextStyle(color: Colors.white),))),
              Container()
            ],
          )),
    );
  }

  void _onResizeButtonClicked() {
    widget.draggableOnResizeListener!();
    
     if(widget.isFullScreen){
    
       dx = (widget.windowWidth - widget.prevWindowWidth);
       dy = (widget.windowHeight - widget.prevWindowHeight) ;
       widget.isFullScreen = false;
       animationController.animateTo(0);
    
    
     }else{
    
        widget.prevWindowWidth = widget.windowWidth ;
        widget.prevWindowHeight = widget.windowHeight ;
        dx = (MediaQuery.of(context).size.width - widget.prevWindowWidth);
        dy = (MediaQuery.of(context).size.height - widget.headerHeight - widget.prevWindowHeight) ;
        animationController.forward();
        widget.isFullScreen = true;
    
     }
    
    
    widget.listener!.onResize!(widget);
  }

  _getBody() {
    return Container(
        child: GestureDetector(
          onTap:(){
            widget.callback!(0, 0);
          },
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              child: Container(
                  child: getApp())),
        ));
  }


  Widget getApp();

  _getCircleButton(Color color, {VoidCallback? callback, VoidCallback? onDoubleClick}) {
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
      ),
    );
  }

  void _onHorizontalDragLeft(DragUpdateDetails details) {

    if(!widget.canResize) return;
    widget.isFullScreen = false;
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
    widget.isFullScreen = false;
    setState(() {
      widget.windowWidth += details.delta.dx;
      if (widget.windowWidth < widget.getWidth()) {
        widget.windowWidth = widget.getWidth();
      }
    });
  }

  void _onHorizontalDragBottom(DragUpdateDetails details) {
    if(!widget.canResize) return;
    widget.isFullScreen = false;
    setState(() {
      widget.windowHeight += details.delta.dy;
      if (widget.windowHeight < widget.getHeight()) {
        widget.windowHeight = widget.getHeight();
      }
    });
  }

  void _onHorizontalDragTop(DragUpdateDetails details) {
    if(!widget.canResize) return;
    widget.isFullScreen = false;
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
